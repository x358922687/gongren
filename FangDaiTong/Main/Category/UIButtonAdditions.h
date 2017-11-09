//
//  UIButtonAdditions.h
//  DWiPhone
//
//  Created by yhj on 13-4-10.
//  Copyright (c) 2013年 yhj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIButton (Extends)


+ (UIButton *)buttonWithType:(NSUInteger)type
					   title:(NSString *)title
					   frame:(CGRect)frame
                      cImage:(UIImage *)cImage
                     bgImage:(UIImage *)bgImage
				 tappedImage:(UIImage *)tappedImage
					  target:(id)target
					  action:(SEL)selector;

+ (UIButton *)buttonWithType:(NSUInteger)type
					   title:(NSString *)title
					   frame:(CGRect)frame
                      cImage:(UIImage *)cImage
                     bgImage:(UIImage *)bgImage
            highlightedImage:(UIImage *)highlightedImage
					  target:(id)target
					  action:(SEL)selector;


+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                      bgImage:(UIImage *)bgImage
                   titleColor:(UIColor *)aColor
                       target:(id)target
                       action:(SEL)selector;

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                        image:(UIImage *)image
                   titleColor:(UIColor *)aColor
                       target:(id)target
                       action:(SEL)selector;

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        image:(UIImage *)image
                       target:(id)target
                       action:(SEL)selector;

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                     textFont:(UIFont *)font
                      bgImage:(UIImage *)bgImage
                   titleColor:(UIColor *)aColor
                       target:(id)target
                       action:(SEL)selector;
//默认btn
+ (UIButton *)buttonForNormalWithFrame:(CGRect)frame
                                 title:(NSString *)title
                                target:(id)target
                                action:(SEL)selector;
//带边框的btn
+ (UIButton *)buttonForBorderColor:(UIColor *)color
                             title:(NSString *)title
                              font:(UIFont *)font
                            target:(id)target
                         action:(SEL)selector;
//圆角Btn   
+ (UIButton *)buttonForcornerRadius:(CGFloat)cornerRadius
                             target:(id)target
                             action:(SEL)selector;
@end
