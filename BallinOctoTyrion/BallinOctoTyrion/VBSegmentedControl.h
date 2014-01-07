//
//  VBSegmentedControl.h
//  BallinOctoTyrion
//
//  Created by Ariel Rodriguez on 1/6/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBSegmentedControl : UIControl
@property (assign, nonatomic) BOOL allowsMultiSelection;
/**
 @discussion: Undefined if `allowsMultiSelection` is set to `YES`
 */
@property (assign, nonatomic) NSInteger selectedSegmentIndex;

/**
 @discussion: Undefined if `allowsMultiSelection` is set to `NO`
 */
@property (strong, nonatomic) NSIndexSet *selectedSegmentedIndeces;

- (id)initWithItems:(NSArray *)items;
@end
