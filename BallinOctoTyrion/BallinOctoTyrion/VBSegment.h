//
//  VBSegment.h
//  BallinOctoTyrion
//
//  Created by Ariel Rodriguez on 1/6/14.
//

#import <UIKit/UIKit.h>

/** 
 A `UIButton` subclass used to render each of the elements of the segmented control. 
 @warning This should be treated as a protected class. Users should not customize the segment itself. We are exposing `VBSegmentConfiguration` to let users configure the look and feel of the control. Allowing them to interact with `VBSegment` might make it harder to change implementation down the road.
 */
@class VBSegmentConfiguration;

@interface VBSegment : UIButton
/**
 Used to let the control knows how it should be render to the screen. 
 @discussion Right now, we are using `UISegmentedControlSegmentLeft` to round the left corners, but not the right ones. `UISegmentedControlSegmentCenter` to draw all the corners squared. `UISegmentedControlSegmentRight` to draw only the corners at the right as rounded corners, and `UISegmentedControlSegmentAlone` to round all the corners.
 */
@property (assign, nonatomic) UISegmentedControlSegment controlSegment;

@property (nonatomic, strong) UIColor *segmentedControlTintColor;

/**
 Factory method that returns an instance of `VBSegmentConfiguration` configured according to the information in `VBSegmentConfiguration`
 @param configuration An `VBSegmentConfiguration` instance that enclose all the relevant information (`title`, `selectedTitle`, `tintColor`) to draw the control. 
 */
+ (instancetype)segmentWithConfiguration:(VBSegmentConfiguration *)configuration;
@end
