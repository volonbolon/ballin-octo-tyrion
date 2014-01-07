//
//  VBViewController.m
//  BallinOctoTyrion
//
//  Created by Ariel Rodriguez on 1/6/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import "VBViewController.h"
#import "VBSegmentedControl.h"
#import "VBSegmentConfiguration.h"

@interface VBViewController ()
- (void)segmentedControlValueDidChange:(VBSegmentedControl *)segmentedControl;
@end

@implementation VBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIColor *whiteColor = [UIColor whiteColor];
    
    UIColor *redColor = [UIColor redColor];
    NSAttributedString *redTitle = [[NSAttributedString alloc] initWithString:@"RED"
                                                                   attributes:@{NSForegroundColorAttributeName:redColor}];
    NSAttributedString *redSelectedTitle = [[NSAttributedString alloc] initWithString:@"RED"
                                                                   attributes:@{NSForegroundColorAttributeName:whiteColor}];
    VBSegmentConfiguration *redSegment = [[VBSegmentConfiguration alloc] initWithTitle:redTitle
                                                                         selectedTitle:redSelectedTitle
                                                                             tintColor:redColor];
    
    UIColor *greenColor = [UIColor greenColor];
    NSAttributedString *greenTitle = [[NSAttributedString alloc] initWithString:@"GREEN"
                                                                   attributes:@{NSForegroundColorAttributeName:greenColor}];
    NSAttributedString *greenSelectedTitle = [[NSAttributedString alloc] initWithString:@"GREEN"
                                                                     attributes:@{NSForegroundColorAttributeName:whiteColor}];
    VBSegmentConfiguration *greenSegment = [[VBSegmentConfiguration alloc] initWithTitle:greenTitle
                                                                         selectedTitle:greenSelectedTitle
                                                                             tintColor:greenColor];
    
    UIColor *blueColor = [UIColor blueColor];
    NSAttributedString *blueTitle = [[NSAttributedString alloc] initWithString:@"BLUE"
                                                                     attributes:@{NSForegroundColorAttributeName:blueColor}];
    NSAttributedString *blueSelectedTitle = [[NSAttributedString alloc] initWithString:@"BLUE"
                                                                    attributes:@{NSForegroundColorAttributeName:whiteColor}];
    VBSegmentConfiguration *blueSegment = [[VBSegmentConfiguration alloc] initWithTitle:blueTitle
                                                                           selectedTitle:blueSelectedTitle
                                                                               tintColor:blueColor];
    
    NSArray *segments = @[redSegment, greenSegment, blueSegment];
    VBSegmentedControl *segmentedControl = [[VBSegmentedControl alloc] initWithItems:segments];
    [segmentedControl setTintColor:[UIColor blueColor]];
    [segmentedControl addTarget:self
                         action:@selector(segmentedControlValueDidChange:)
               forControlEvents:UIControlEventValueChanged];
    
    [segmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UIView *superview = [self view];
    [superview addSubview:segmentedControl];
    
    NSDictionary *variables = NSDictionaryOfVariableBindings(segmentedControl, superview);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[superview]-(<=1)-[segmentedControl]"
                                                                   options:NSLayoutFormatAlignAllCenterX
                                                                   metrics:nil
                                                                     views:variables];
    [[self view] addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[superview]-(<=1)-[segmentedControl]"
                                            options:NSLayoutFormatAlignAllCenterY
                                            metrics:nil
                                              views:variables];
    [[self view] addConstraints:constraints];
    
}

- (void)segmentedControlValueDidChange:(VBSegmentedControl *)segmentedControl
{
    
    NSLog(@"segmentedControlValueDidChange: %d", [segmentedControl selectedSegmentIndex]);
    
}
     

@end
