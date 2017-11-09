//
//  UIImageViewAdditions.m
//  TestFont
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import "UIImageViewAdditions.h"



@implementation UIImageView (UIImageViewExtend)

+ (UIImageView *)imageViewWithName:(NSString *)name
{
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    view.backgroundColor = [UIColor clearColor];
#if __has_feature(objc_arc)
    return view;
#else
    return [view autorelease];
#endif
}
+ (UIImageView *)imageViewWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    view.image = image;
#if __has_feature(objc_arc)
    return view;
#else
    return [view autorelease];
#endif
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame color:(UIColor *)color
{
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:frame];
    lineView.backgroundColor = color;
#if __has_feature(objc_arc)
    return lineView;
#else
    return [lineView autorelease];
#endif
}

+ (UIImageView *)imageViewWithDashLineFrame:(CGRect)frame color:(UIColor *)color
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    CGFloat lengths[] = {2,10};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, color.CGColor);
    CGContextSetLineDash(line, 0, lengths, 1);  //画虚线
    CGContextMoveToPoint(line, 0.0, 1);    //开始画线
    CGContextAddLineToPoint(line, frame.size.width, 1);
    CGContextStrokePath(line);
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    return imageView;
}

@end



