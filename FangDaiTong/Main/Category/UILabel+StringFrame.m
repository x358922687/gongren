//
//  UILabel+StringFrame.m
//  jiaTouWang
//
//  Created by yhj on 16/7/29.
//  Copyright © 2016年 yhj. All rights reserved.
//

#import "UILabel+StringFrame.h"

@implementation UILabel (StringFrame)


- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}
@end
