//
//  YSTabBar.h
//  SendHome
//
//  Created by lijun on 15/4/23.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YSTabBar;

@protocol CustomTabBarDelegate <NSObject>

@optional
- (void)tabBar:(YSTabBar*)tabBar didSelectButtonIndex:(NSInteger)index;

@end

@interface YSTabBar : UIView

@property (nonatomic,weak) id <CustomTabBarDelegate> delegate;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

- (void)selectedBtnWithIndex:(int)index;

@end
