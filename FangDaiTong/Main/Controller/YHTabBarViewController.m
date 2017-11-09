 //
//  YHTabBarViewController.m
//  FangDaiTong
//
//  Created by yhj on 2017/9/27.
//  Copyright © 2017年 yhj. All rights reserved.
//

#import "YHTabBarViewController.h"
#import "YHNavigationViewController.h"
#import "IndexViewController.h"
#import "OrderViewController.h"
#import "TeamViewController.h"
#import "UserViewController.h"
#import "YSTabBar.h"

@interface YHTabBarViewController ()<CustomTabBarDelegate>

@property (weak, nonatomic) YSTabBar *customTabBar;
@property (strong, nonatomic) IndexViewController *indexVC;
@property (strong, nonatomic) OrderViewController *orderVC;
@property (strong, nonatomic) UserViewController *userVC;

@end

@implementation YHTabBarViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTabbar];
    [self addAllChildVC];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideTabBar];
   
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    for (UIView * view in self.tabBar.subviews)
    {

        if (![view isKindOfClass:[YSTabBar class]]) {

            [view removeFromSuperview];
        }
    }
}
- (void)showTotalBadge:(NSNotification *)sender
{
    int number = [[sender object] intValue];
    NSString *numStr = [NSString stringWithFormat:@"%d",number];
    //    [GlobalData sharedGlobalData].cartNum = numStr;
    //    self.shop.tabBarItem.badgeValue = numStr;
}
/** 选中哪个tabbar*/
- (void)selectCate:(NSNotification *)sender
{
    int index = [[sender object] intValue];
    [self.customTabBar selectedBtnWithIndex:index];
    [self tabBar:self.customTabBar didSelectButtonIndex:index];
    
}
/*** 初始化tabBar*/
- (void)setupTabbar
{
    YSTabBar *customTabBar = [[YSTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}
/** 隐藏系统tab*/
- (void)hideTabBar
{
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews)
    {
        if ([child isKindOfClass:[UIControl class]])
        {
            [child removeFromSuperview];
        }
    }
}


- (void)hideCustomTabBar
{
    self.customTabBar.hidden = YES;
    self.tabBar.hidden = YES;
}
- (void)showCustomTabBar
{
    self.customTabBar.hidden = NO;
    self.tabBar.hidden = NO;
}


/** 点了哪个模块*/
- (void)tabBar:(YSTabBar *)tabBar didSelectButtonIndex:(NSInteger)index
{
    
    if (index == self.selectedIndex) {
        return;
    }
    self.selectedIndex = index;
}

/***  添加所有子控制器*/
- (void)addAllChildVC
{
    
    IndexViewController *indexVC = [[IndexViewController alloc]init];
    self.indexVC = indexVC;
    [self addChildVC:indexVC title:@"首页" image:@"tab_home_nor" selectedImage:@"tab_home_sel"];
    
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    self.orderVC = orderVC;
    [self addChildVC:orderVC title:@"订单" image:@"tab_order_nor" selectedImage:@"tab_order_sel"];
    
    TeamViewController *order2VC = [[TeamViewController alloc] init];
    self.orderVC = order2VC;
    [self addChildVC:order2VC title:@"消息" image:@"tab_order_nor" selectedImage:@"tab_order_sel"];
    
    UserViewController *userVC = [[UserViewController alloc] init];
    self.userVC = userVC;
    [self addChildVC:userVC title:@"我的" image:@"tab_mine_nor" selectedImage:@"tab_mine_sel"];
   
}
/**
 *  添加一个子控制器
 *  @param childVc       子控制器对象
 *  @param title         标题
 *  @param image         图标
 *  @param selectedImage 选中图标
 */
- (void)addChildVC:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置标题
    childVc.tabBarItem.title = title;
    //设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    
    //设置选中的图标
    UIImage *selectImg = [UIImage imageNamed:selectedImage];
    childVc.tabBarItem.selectedImage = selectImg;
    
    //添加为tabbar控制器的子控制器
    YHNavigationViewController *nav = [[YHNavigationViewController alloc] initWithRootViewController:childVc];
   // [nav setNavigationBarHidden:YES];
    [self addChildViewController:nav];
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

@end
