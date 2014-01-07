//
//  VBSegmentConfiguration.h
//  BallinOctoTyrion
//
//  Created by Ariel Rodriguez on 1/6/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VBSegmentConfiguration : NSObject
@property (strong) NSAttributedString *title;
@property (strong) NSAttributedString *selectedTitle;
@property (strong) UIColor *tintColor;

- (id)initWithTitle:(NSAttributedString *)title
      selectedTitle:(NSAttributedString *)selectedTitle
          tintColor:(UIColor *)tintColor;
@end
