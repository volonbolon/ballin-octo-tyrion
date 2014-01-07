//
//  VBSegmentConfiguration.m
//  BallinOctoTyrion
//
//  Created by Ariel Rodriguez on 1/6/14.
//

#import "VBSegmentConfiguration.h"

@implementation VBSegmentConfiguration
- (id)initWithTitle:(NSAttributedString *)title
      selectedTitle:(NSAttributedString *)selectedTitle
          tintColor:(UIColor *)tintColor
{
    
    self = [super init];
    
    if ( self != nil ) {
        
        _tintColor = tintColor;
        _title = title;
        _selectedTitle = selectedTitle;
        
    }
    
    return self;
    
}
@end
