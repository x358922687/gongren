//
//  UIPageControlAdditions.m
//  OtoStore
//
//  Created by lijun on 15/2/7.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "UIPageControlAdditions.h"

@implementation UIPageControl (Extends)

+ (UIPageControl *)pageControlWithFrame:(CGRect)frame currentPageColor:(UIColor *)currentColor indicatorColor:(UIColor *)indicatorColor
{
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:frame];
    pageControl.currentPageIndicatorTintColor = currentColor;
    pageControl.pageIndicatorTintColor = indicatorColor;
    pageControl.hidesForSinglePage = YES;
    return pageControl;
}

+ (CustomPageControl *)pageControlWithFrame:(CGRect)frame currentPageImage:(UIImage *)currentImage indicatorImage:(UIImage *)indicatorImage
{
    CustomPageControl *pageControl = [[CustomPageControl alloc] initWithFrame:frame];
    pageControl.hidesForSinglePage = YES;
    pageControl.currentImg = currentImage;
    pageControl.inditorImg = indicatorImage;
    return pageControl;
}


@end
