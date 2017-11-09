//
//  YSTabBar.m
//  SendHome
//
//  Created by lijun on 15/4/23.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "YSTabBar.h"
#import "CustomTabBarButton.h"


@interface YSTabBar()

@property (nonatomic,strong) NSMutableArray *tabBarButtons;

@end

@implementation YSTabBar

- (NSMutableArray *)tabBarButtons
{
    if (!_tabBarButtons) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    CustomTabBarButton *button = [[CustomTabBarButton alloc] init];
    [self addSubview:button];
    [self.tabBarButtons addObject:button];
   // [GlobalData sharedGlobalData].tabArray = self.tabBarButtons;
    button.item = item;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    if (self.tabBarButtons.count == 1)
    {
        CustomTabBarButton *ecptButton = button;
        ecptButton.tag = -1;
        [self buttonClick:ecptButton];
    }
}
- (void)selectedBtnWithIndex:(int)index
{
   
    for (CustomTabBarButton *btn in self.tabBarButtons)
    {
        if (btn.tag == index) {
            btn.selected = YES;
        }else
        {
             btn.selected = NO;
        }
       
    }

    
}
- (void)buttonClick:(CustomTabBarButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonIndex:)])
    {
        [self.delegate tabBar:self didSelectButtonIndex:button.tag];
    }
    // 2.设置按钮的状态
    for (CustomTabBarButton *btn in self.tabBarButtons)
    {
        btn.selected = NO;
    }
    button.selected = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    
    // 按钮的frame数据
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index < self.subviews.count; index++) {
        // 1.取出按钮
        CustomTabBarButton *button = self.subviews[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}

@end
