//
//  YSBadgeButton.m
//  SendHome
//
//  Created by lijun on 15/4/23.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "YSBadgeButton.h"

@implementation YSBadgeButton

- (void)awakeFromNib {
    
    self.hidden = YES;
    self.userInteractionEnabled = NO;
    [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    if (badgeValue) {
        self.hidden = NO;
        // 设置文字
        if ([badgeValue intValue] > 99)
        {
            badgeValue = @"99+";
        }
        if ([badgeValue intValue] == 0)
        {
            self.hidden = YES;
        }
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            // 文字的尺寸
            CGSize badgeSize = [badgeValue sizeAutoFitWithFont:self.titleLabel.font];
            badgeW = badgeSize.width + 10;
            if (badgeW > 30) {
                badgeW = 30;
            }
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
}

@end
