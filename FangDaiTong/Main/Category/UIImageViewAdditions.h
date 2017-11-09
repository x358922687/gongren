//
//  UIImageViewAdditions.h
//  TestFont
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (UIImageViewExtend)

+ (UIImageView *)imageViewWithName:(NSString *)name;
+ (UIImageView *)imageViewWithFrame:(CGRect)frame andImage:(UIImage *)image;

//实线
+ (UIImageView *)imageViewWithFrame:(CGRect)frame color:(UIColor *)color;

//虚线
+ (UIImageView *)imageViewWithDashLineFrame:(CGRect)frame color:(UIColor *)color;

@end
