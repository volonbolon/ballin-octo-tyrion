//
//  VBSegmentedControl.m
//  BallinOctoTyrion
//
//  Created by Ariel Rodriguez on 1/6/14.
//

#import "VBSegmentedControl.h"
#import "VBSegmentedControl_Private.h"
#import "VBSegment.h"
#import "VBSegmentConfiguration.h"

@implementation VBSegmentedControl

- (id)initWithItems:(NSArray *)items
{
    
    self = [super init];
    if ( self != nil ) {
        
        [self setContentMode:UIViewContentModeRedraw];
        [self setBackgroundColor:[UIColor clearColor]];
        
        _selectedSegmentIndex = UISegmentedControlNoSegment;

        NSUInteger itemCount = [items count];
        NSMutableArray *mutableSegments = [[NSMutableArray alloc] initWithCapacity:itemCount];
        
        __block VBSegment *previousSegment = nil;
        [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            VBSegment *segment = [VBSegment segmentWithConfiguration:(VBSegmentConfiguration *)obj];

            [segment addTarget:self
                        action:@selector(didTapItem:)
              forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:segment];
            
            [segment setTranslatesAutoresizingMaskIntoConstraints:NO];
            NSDictionary *viewDict = NSDictionaryOfVariableBindings(segment);
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[segment]|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewDict]];
            if ( previousSegment != nil ) {
                
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[previousSegment]-1-[segment(==previousSegment)]"
                                                                             options:kNilOptions
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(previousSegment, segment)]];
                
            }
            
            if ( itemCount == 1 ) {
                
                [segment setControlSegment:UISegmentedControlSegmentAlone];
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[segment]|"
                                                                             options:kNilOptions
                                                                             metrics:nil
                                                                               views:viewDict]];
                
            } else {
                
                if ( idx == 0 ) {
                    
                    [segment setControlSegment:UISegmentedControlSegmentLeft];
                    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[segment]"
                                                                                 options:kNilOptions
                                                                                 metrics:nil
                                                                                   views:viewDict]];
                    
                } else if ( idx == (itemCount - 1) ) {
                    
                    [segment setControlSegment:UISegmentedControlSegmentRight];
                    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[segment]|"
                                                                                 options:kNilOptions
                                                                                 metrics:nil
                                                                                   views:viewDict]];
                    
                } else {
                    
                    [segment setControlSegment:UISegmentedControlSegmentCenter];
                    
                }
                
                previousSegment = segment;
                
            }
            
            [mutableSegments addObject:segment];
            
        }];
        
        _segments = mutableSegments;
        
        [self sizeToFit];
        
    }
    
    return self;
    
}

- (void)setEnabled:(BOOL)enabled
{
    
    [super setEnabled:enabled];
    
    for ( VBSegment *segment in [self segments] ) {
        
        [segment setEnabled:enabled];
        
    }
    
}

- (void)setAllowsMultiSelection:(BOOL)allowsMultiSelection
{
    
    if ( allowsMultiSelection != _allowsMultiSelection ) {
        
        _allowsMultiSelection = allowsMultiSelection;
        
        if ( allowsMultiSelection ) {
            
            NSInteger selectedSegmentIndex = [self selectedSegmentIndex];
            if ( selectedSegmentIndex != UISegmentedControlNoSegment ) {
                
                [self setSelectedSegmentedIndeces:[NSMutableIndexSet indexSetWithIndex:selectedSegmentIndex]];
                
            } else {
                
                [self setSelectedSegmentedIndeces:[NSMutableIndexSet indexSet]];
                
            }
            
        } else {
            
            [self setSelectedSegmentedIndeces:nil];
            [self setSelectedSegmentIndex:UISegmentedControlNoSegment];
            
        }
        
    }
    
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    
    if ( selectedSegmentIndex != _selectedSegmentIndex ) {
        
        if ( _selectedSegmentIndex != UISegmentedControlNoSegment ) {
            
            VBSegment *selectedSegment = [[self segments] objectAtIndex:_selectedSegmentIndex];
            [selectedSegment setSelected:NO];
            [self sendSubviewToBack:selectedSegment];
            
        }
        
        if ( selectedSegmentIndex != UISegmentedControlNoSegment ) {
            
            VBSegment *segmentToSelect = [[self segments] objectAtIndex:selectedSegmentIndex];
            [segmentToSelect setSelected:YES];
            [self bringSubviewToFront:segmentToSelect];
            
        }
        
        _selectedSegmentIndex = selectedSegmentIndex;
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];

    }
    
}

- (void)setSelectedSegmentedIndeces:(NSIndexSet *)selectedSegmentedIndeces
{
    
    if ( ![_selectedSegmentedIndeces isEqualToIndexSet:selectedSegmentedIndeces] ) {
        
        [_selectedSegmentedIndeces enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            
            VBSegment *selectedSegment = [[self segments] objectAtIndex:idx];
            [selectedSegment setSelected:NO];
            [self sendSubviewToBack:selectedSegment];
            
        }];
        
        [selectedSegmentedIndeces enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            
            VBSegment *segmentToSelect = [[self segments] objectAtIndex:idx];
            [segmentToSelect setSelected:YES];
            [self bringSubviewToFront:segmentToSelect];
            
        }];
        
        _selectedSegmentedIndeces = selectedSegmentedIndeces;
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        
    }
    
}

- (CGSize)sizeThatFits:(CGSize)size
{
    
	CGSize sizeThatFits = CGSizeZero;
	
    CGFloat maxWidth = .0;
    CGFloat maxHeight = .0;
    
	for ( VBSegment *segment in [self segments] ) {
        
		CGSize segmentSize = [segment sizeThatFits:size];
		maxWidth = MAX(maxWidth, segmentSize.width);
		maxHeight = MAX(maxHeight, segmentSize.height);
        
	}
    
    NSUInteger segmentsCount = [[self segments] count];
	sizeThatFits.width = maxWidth * segmentsCount + 1 * (segmentsCount - 1);
	sizeThatFits.height = MAX(maxHeight, 29);
    
	return sizeThatFits;
    
}

- (void)drawRect:(CGRect)rect {

	CGFloat lineWidth = 1.0;
	UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset([self bounds], lineWidth / 2, lineWidth / 2) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(3.5, 3.5)];
    [path setLineWidth:lineWidth];
    
    if ( [self isEnabled] ) {
        
        [[self tintColor] setStroke];
        
    } else {
        
        [[[self tintColor] colorWithAlphaComponent:0.50] setStroke];
    }
    
	[path stroke];
    
}

- (CGSize)intrinsicContentSize
{
    
	CGSize intrinsicSize = CGSizeZero;
	
    CGFloat maxWidth = .0;
    CGFloat maxHeight = .0;
    
	for ( VBSegment *segment in [self segments] ) {
        
		CGSize segmentSize = [segment intrinsicContentSize];
		maxWidth = MAX(maxWidth, segmentSize.width);
		maxHeight = MAX(maxHeight, segmentSize.height);
        
	}
    
    NSUInteger segmentsCount = [[self segments] count];
	intrinsicSize.width = maxWidth * segmentsCount + 1 * (segmentsCount - 1);
	intrinsicSize.height = MAX(maxHeight, 29);
    
	return intrinsicSize;
}

- (IBAction)didTapItem:(id)sender
{
    
    NSUInteger index = [[self segments] indexOfObject:sender];
    if ( [self allowsMultiSelection] ) {
        
        if ( [sender isSelected] ) {
            
            [(VBSegment *)sender setSelected:NO];
            [self sendSubviewToBack:(VBSegment *)sender];
            
            NSMutableIndexSet *mutableIndexSet = [[self selectedSegmentedIndeces] mutableCopy];
            [mutableIndexSet removeIndex:index];
            [self setSelectedSegmentedIndeces:mutableIndexSet];

        } else {
            
            [(VBSegment *)sender setSelected:YES];
            [self bringSubviewToFront:(VBSegment *)sender];
            
            NSMutableIndexSet *mutableIndexSet = [[self selectedSegmentedIndeces] mutableCopy];
            [mutableIndexSet addIndex:index];
            [self setSelectedSegmentedIndeces:mutableIndexSet];
            
        }
        
    } else {
        
        [self setSelectedSegmentIndex:index];
        
    }
    
}



- (void)setTintColor:(UIColor *)tintColor
{
    
    [super setTintColor:tintColor];
    
    for ( VBSegment *segment in [self segments] ) {
        
        [segment setSegmentedControlTintColor:tintColor];
        
    }
    
}

@end
