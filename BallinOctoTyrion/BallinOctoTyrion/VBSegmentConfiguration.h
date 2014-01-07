//
//  VBSegmentConfiguration.h
//  BallinOctoTyrion
//
//  Created by Ariel Rodriguez on 1/6/14.
//

#import <Foundation/Foundation.h>

/** 
 Used to encapsule the relevant UI information for each segment of the segmented control.
 */
@interface VBSegmentConfiguration : NSObject
/**
 Attributed string with used for the title.
 */
@property (strong) NSAttributedString *title;

/**
 Attributed string with used for the title when the segment is selected.
 */
@property (strong) NSAttributedString *selectedTitle;

/** 
 Color used to tint the control
 */
@property (strong) UIColor *tintColor;

/**
 Designated initializer
 @param title Attributed string for the control title
 @param selectedTitle Attributed string for the control title when selected
 @param tintColor Color used to tint the control
 */
- (id)initWithTitle:(NSAttributedString *)title
      selectedTitle:(NSAttributedString *)selectedTitle
          tintColor:(UIColor *)tintColor;
@end
