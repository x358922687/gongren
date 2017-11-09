//
//  CustomPageControl.m
//  OtoStore
//
//  Created by lijun on 15/2/6.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "CustomPageControl.h"

static float kspace = 10.0f;

@implementation CustomPageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    if ([self respondsToSelector:@selector(setCurrentPageIndicatorTintColor:)] && [self respondsToSelector:@selector(setPageIndicatorTintColor:)]) {
        [self setCurrentPageIndicatorTintColor:[UIColor clearColor]];
        [self setPageIndicatorTintColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    [self updateDots];
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    [super setNumberOfPages:numberOfPages];
    [self updateDots];
    [self setNeedsDisplay];
}

- (void)updateDots
{
    NSArray *subviewArr = self.subviews;
    for (NSInteger i = 0; i< subviewArr.count; i++)
    {
        UIImageView *dot = subviewArr[i];
        if (i == self.currentPage)
        {
            if ([dot respondsToSelector:@selector(setImage:)])
            {
                dot.image = _currentImg;
            }
        }
        else
        {
            if ([dot respondsToSelector:@selector(setImage:)])
            {
                dot.image = _inditorImg;
            }
        }
    }
}

-(void)drawRect:(CGRect)iRect
{
       CGRect rect;
    UIImage *image;
    iRect = self.bounds;
    
    if ( self.opaque )
    {
        [self.backgroundColor set];
        UIRectFill( iRect );
    }
    
    if ( self.hidesForSinglePage && self.numberOfPages == 1 ) return;
    
    rect.size.height = _currentImg.size.height;
    rect.size.width = self.numberOfPages * _currentImg.size.width + ( self.numberOfPages - 1 ) * kspace;
    rect.origin.x = floorf( ( iRect.size.width - rect.size.width ) / 2.0 );
    rect.origin.y = floorf( ( iRect.size.height - rect.size.height ) / 2.0 );
    rect.size.width = _currentImg.size.width;
    
    for (int i = 0; i < self.numberOfPages; ++i )
    {
        image = i == self.currentPage ? _currentImg : _inditorImg;
        [image drawInRect: rect];
        rect.origin.x += _currentImg.size.width + kspace;
    }
    
}

@end
