//
//  YSNewsCell.m
//  BankApp
//
//  Created by yhj on 17/4/13.
//  Copyright © 2017年 QDPCI. All rights reserved.
//

#import "YSNewsCell.h"

@interface YSNewsCell()

@property (weak, nonatomic) UIImageView *iconView;

@end

@implementation YSNewsCell

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.iconView = imageView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconView.frame = CGRectMake(0, 0, SCREEN_WEIGHT, self.height);
}

- (void)setImgName:(NSString *)imgName{
    
}

//- (void)setImgName:(NSString *)imgName
//{
//    [self.iconView setImageWithURL:[NSURL URLWithString:imgName] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor]]];
//}



@end
