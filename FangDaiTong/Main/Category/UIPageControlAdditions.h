//
//  UIPageControlAdditions.h
//  OtoStore
//
//  Created by lijun on 15/2/7.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPageControl.h"

@interface UIPageControl (Extends)

+ (UIPageControl *)pageControlWithFrame:(CGRect)frame currentPageColor:(UIColor *)currentColor indicatorColor:(UIColor *)indicatorColor;

+ (CustomPageControl *)pageControlWithFrame:(CGRect)frame currentPageImage:(UIImage *)currentImage indicatorImage:(UIImage *)indicatorImage;

@end
