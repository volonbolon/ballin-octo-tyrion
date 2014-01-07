//
//  VBSegment.m
//  BallinOctoTyrion
//
//  Created by Ariel Rodriguez on 1/6/14.
//

#import "VBSegment.h"
#import "VBSegmentConfiguration.h"
#import "VBSegment_Private.h"

@implementation VBSegment

+ (instancetype)segmentWithConfiguration:(VBSegmentConfiguration *)configuration
{
    
    VBSegment *segment = [self buttonWithType:UIButtonTypeSystem];
    
    if ( segment != nil ) {
        
        [segment setAttributedTitle:[configuration title]
                           forState:UIControlStateNormal];
        
        [segment setContentEdgeInsets:UIEdgeInsetsMake(6.0, 6.0, 6.0, 6.0)];
        
        NSAttributedString *selectedTitle = [configuration selectedTitle];
        if ( selectedTitle != nil ) {
            
            [segment setAttributedTitle:selectedTitle
                               forState:UIControlStateSelected];
            
        }
        
        UIView *divider = [UIView new];
        [divider setTranslatesAutoresizingMaskIntoConstraints:NO];
        [segment addSubview:divider];
        
        NSLayoutConstraint *widthContraint = [NSLayoutConstraint constraintWithItem:divider
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:1];
        [divider addConstraint:widthContraint];
        
        NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:divider
                                                                             attribute:NSLayoutAttributeLeading
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:segment
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:0];
        [segment addConstraint:leadingConstraint];
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:divider
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:segment
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1
                                                                          constant:0];
        
        [segment addConstraint:topConstraint];
        
        NSLayoutConstraint *bottomContraint = [NSLayoutConstraint constraintWithItem:divider
                                                                           attribute:NSLayoutAttributeBottom
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:segment
                                                                           attribute:NSLayoutAttributeBottom
                                                                          multiplier:1
                                                                            constant:0];
        [segment addConstraint:bottomContraint];
        
        UIColor *tintColor = [configuration tintColor];
        
        [segment setDivider:divider];
        
        [segment setTintColor:tintColor];
        
    }
    
    return segment;
    
}

- (void)setControlSegment:(UISegmentedControlSegment)controlSegment
{
    
    if ( controlSegment != _controlSegment ) {
        
        _controlSegment = controlSegment;
        if ( controlSegment == UISegmentedControlSegmentRight || controlSegment == UISegmentedControlSegmentAlone ) {
            
            [[self divider] setHidden:YES];
            
        } else {
            
            [[self divider] setHidden:NO];
            
        }
        
    }
    
}

- (void)drawRect:(CGRect)rect
{
    
    if ( ![self isHighlighted] && ![self isSelected] ) return;

    UIRectCorner roundingCorners = 0;
    
    UISegmentedControlSegment controlSegment = [self controlSegment];
    if ( controlSegment == UISegmentedControlSegmentLeft ) {
        
        roundingCorners |= UIRectCornerTopLeft | UIRectCornerBottomLeft;
        
    }
    
    if ( controlSegment == UISegmentedControlSegmentRight ) {
        
        roundingCorners |= UIRectCornerTopRight | UIRectCornerBottomRight;
        
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:[self bounds]
                                               byRoundingCorners:roundingCorners
                                                     cornerRadii:CGSizeMake(3.5, 3.5)];
    
    BOOL isSelected = [self isSelected];
    
    if ( isSelected ) {
        
        if ( [self isEnabled] ) {
            
            [[self tintColor] setFill];
            
        } else {
            
            [[[self tintColor] colorWithAlphaComponent:.5] setFill];
            
        }
        
    } else {
        
        [[[self tintColor] colorWithAlphaComponent:.15] setFill];
        
    }
    
    [path fill];
    
    if ( isSelected ) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSetBlendMode(context, kCGBlendModeClear);
        
    }
    
}

- (void)setEnabled:(BOOL)enabled
{
    
    [super setEnabled:enabled];
    
    if ( enabled ) {
        
        [[self divider] setBackgroundColor:[self tintColor]];
        
    } else {
        
        [[self divider] setBackgroundColor:[[self tintColor] colorWithAlphaComponent:.5]];
        
    }
    
}

- (void)setHighlighted:(BOOL)highlighted
{
    
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
    
}

- (void)setDividerColor:(UIColor *)dividerColor
{
    
    [[self divider] setBackgroundColor:dividerColor];
    
}

@end
