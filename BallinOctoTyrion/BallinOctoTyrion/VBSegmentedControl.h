//
//  VBSegmentedControl.h
//  BallinOctoTyrion
//
//  Created by Ariel Rodriguez on 1/6/14.
//

#import <UIKit/UIKit.h>
/**
 This is replacement for `UISegmentedControl`. Because the native segmented control is composed by a private `UIControl` subclass (`UISegment`) we cannot simply customize each of the segments. This class use a custom control available to be customized as desired.
 */

@interface VBSegmentedControl : UIControl
/** 
 This flag should be raised if we want to allow users to select more than one option.
 */
@property (assign, nonatomic) BOOL allowsMultiSelection;

/**
 @discussion: Undefined if `allowsMultiSelection` is set to `YES`
 */
@property (assign, nonatomic) NSInteger selectedSegmentIndex;

/**
 @discussion: Undefined if `allowsMultiSelection` is set to `NO`
 */
@property (strong, nonatomic) NSIndexSet *selectedSegmentedIndeces;

/**
 @discussion Designated initializer.
 @param items An array composed by instances of `VBSegmentConfiguration`.
 @return initialized instance of `VBSegmentedControl`
 */
- (id)initWithItems:(NSArray *)items;
@end
