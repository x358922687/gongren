//
//  UIViewAdditions.h
//  DWiPhone
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kActivityTag        9212111
@interface UIView (Extends)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;
@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 * The view controller whose view contains this view.
 */
- (UIViewController*)viewController;

- (void)setOriginY:(CGFloat)originY;
- (void)setOriginX:(CGFloat)originx;
- (void)setOriginXAdd:(float)addX;
- (void)setOriginYAdd:(float)addY;
- (void)setSizeHeight:(float)heigth;
- (void)setSizeHeightAdd:(float)addHeigth;
- (void)setSizeWidth:(float)width;
- (void)setSizeWidthAdd:(float)addWidth;

+ (instancetype)viewFromXIB;
/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowInKeyWindow;



@end
