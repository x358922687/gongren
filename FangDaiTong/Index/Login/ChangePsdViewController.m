//
//  ChangePsdViewController.m
//  FangDaiTong
//
//  Created by yhj on 2017/10/14.
//  Copyright © 2017年 yhj. All rights reserved.
//

#import "ChangePsdViewController.h"
#import "EnterTextFiledView.h"
#import "ForgetPsdViewController.h"

@interface ChangePsdViewController ()
@property(nonatomic, strong) EnterTextFiledView *oldPsdEnterView;
@property(nonatomic, strong) EnterTextFiledView *myPsdEnterView;
@end

@implementation ChangePsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleStr = @"修改密码";
    [self creatSubviews];
}
- (void)creatSubviews
{
    EnterTextFiledView *oldPsdEnterView = [EnterTextFiledView EnterTextFiledViewWithTitle:@"旧密码" WithsecureTextEntry:NO];
    [self.view addSubview:oldPsdEnterView];
    self.oldPsdEnterView = oldPsdEnterView;
    [oldPsdEnterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.height.offset(textViewHeight);
        make.top.offset(100);
    }];
    EnterTextFiledView *myPsdEnterView = [EnterTextFiledView EnterTextFiledViewWithTitle:@"新密码" WithsecureTextEntry:YES];
    [self.view addSubview:myPsdEnterView];
    self.myPsdEnterView = myPsdEnterView;
    [myPsdEnterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(oldPsdEnterView);
        make.height.offset(textViewHeight);
        make.top.equalTo(oldPsdEnterView.mas_bottom);
    }];
    UIButton *forgetBtn = [UIButton buttonWithFrame:CGRectZero title:@"忘记密码" image:nil titleColor:k999Color target:self action:@selector(forgrtBtnClick)];
    [forgetBtn.titleLabel setFont:kTintFont];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(myPsdEnterView.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(knormalMargin);
        
    }];
    
}

- (void)forgrtBtnClick
{
    ForgetPsdViewController *vc = [[ForgetPsdViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
}
@end
