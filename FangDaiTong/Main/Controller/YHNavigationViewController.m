//
//  YHNavigationViewController.m
//  FangDaiTong
//
//  Created by yhj on 2017/9/27.
//  Copyright © 2017年 yhj. All rights reserved.
//

#import "YHNavigationViewController.h"
#import "AppDelegate.h"
#import "YHTabBarViewController.h"

@interface YHNavigationViewController ()<UINavigationControllerDelegate>

@property (strong, nonatomic) id popDelegate;
@end

@implementation YHNavigationViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}
/**
 *  第一次使用这个类的时候会调用(1个类只会调用1次)
 */
+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
}
/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 设置背景
    [navBar setBackgroundImage:[UIImage imageWithColor:kBgColor] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[[UIImage alloc] init]];//去掉底部的线
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // 设置标题属性
  
}



- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
   
    if(viewController == self.viewControllers[0])//是根控制器
    {
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }
    else
    {
        self.interactivePopGestureRecognizer.delegate = nil;
    }

}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
   // YHTabBarViewController *tabBarVc = appDelegate.tabBarController;
    // 删除系统自带的tabBarButton
   // [tabBarVc hideTabBar];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
}

//拦截所有push进来的子控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
      
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"ic_return_nor" higImage:@"ic_return_nor" target:self action:@selector(back)];
    }
    
    [super pushViewController:viewController animated:animated];
}



@end
