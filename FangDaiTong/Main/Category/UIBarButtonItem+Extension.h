//
//  UIBarButtonItem+Extension.h
//  Test02
//
//  Created by lijun on 15/3/19.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  快速创建一个显示图片的item
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon
                    highlightIcon:(NSString *)highlightIcon
                             size:(CGSize)size
                           target:(id)target
                           action:(SEL)action;

/** 快速创建一个显示背景图片的item*/
+ (UIBarButtonItem *)itemWithImage:(NSString *)img
                            target:(id)target
                            action:(SEL)action;

/** 快速创建一个显示文字的item*/
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                              size:(CGSize)size
                         alignment:(NSString *)alignment
                            target:(id)target
                            action:(SEL)action;

+ (UIBarButtonItem *)itemWithicon:(NSString *)iconName
                     itemPosition:(NSString *)position
                           target:(id)target
                           action:(SEL)action;
+ (UIBarButtonItem *)itemWithImage:(NSString *)image higImage:(NSString *)higImage target:(id)target action:(SEL)action;
@end
