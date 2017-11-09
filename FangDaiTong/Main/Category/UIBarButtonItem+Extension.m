//
//  UIBarButtonItem+Extension.m
//  Test02
//
//  Created by lijun on 15/3/19.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image higImage:(NSString *)higImage target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    
    // 设置对应状态图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:higImage] forState:UIControlStateHighlighted];
    // btn.backgroundColor = [UIColor blackColor];
    // 设置frame
    //btn.size = btn.currentImage.size;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0,0);
    btn.frame = CGRectMake(0, 0, 50, 30);
   
    // 添加监听事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon
                    highlightIcon:(NSString *)highlightIcon
                             size:(CGSize)size
                           target:(id)target
                           action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:highlightIcon] forState:UIControlStateHighlighted];
    button.size = size;
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithImage:(NSString *)img
                            target:(id)target
                            action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                              size:(CGSize)size
                         alignment:(NSString *)alignment
                            target:(id)target
                            action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = (CGRect){CGPointZero, size};
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor colorWithHex:@"666666"] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if ([alignment isEqualToString:@"left"])
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)itemWithicon:(NSString *)iconName
                     itemPosition:(NSString *)position
                           target:(id)target
                           action:(SEL)action;
{
    UIButton *itmeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    itmeBtn.adjustsImageWhenDisabled = NO;
    itmeBtn.adjustsImageWhenHighlighted = NO;
    if(iconName)[itmeBtn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    itmeBtn.size = itmeBtn.currentImage.size;
    itmeBtn.imageEdgeInsets = [position isEqualToString:@"right"] ? UIEdgeInsetsMake(0, 0, 0, -30) : UIEdgeInsetsMake(0, -30, 0,0);
    [itmeBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemBarBtn = [[UIBarButtonItem alloc] initWithCustomView:itmeBtn];
    return  itemBarBtn;
}
@end
