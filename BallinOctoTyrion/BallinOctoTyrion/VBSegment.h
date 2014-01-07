//
//  VBSegment.h
//  BallinOctoTyrion
//
//  Created by Ariel Rodriguez on 1/6/14.
//  Copyright (c) 2014 Ariel Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VBSegmentConfiguration;

@interface VBSegment : UIButton
@property (assign, nonatomic) UISegmentedControlSegment controlSegment;

+ (instancetype)segmentWithConfiguration:(VBSegmentConfiguration *)configuration;
@end
