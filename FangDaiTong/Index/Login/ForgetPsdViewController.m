//
//  ForgetPsdViewController.m
//  FangDaiTong
//
//  Created by yhj on 2017/10/11.
//  Copyright © 2017年 yhj. All rights reserved.
//

#import "ForgetPsdViewController.h"
#import "EnterTextFiledView.h"

@interface ForgetPsdViewController ()
//验证码登录
@property(nonatomic, strong)UIView *codeLoginView;
@property(nonatomic, strong) EnterTextFiledView *codePhoneEnterView;
@property(nonatomic, strong) EnterTextFiledView *codeCodeEnterView;
@property(nonatomic, strong) EnterTextFiledView *passWordEnterView;

@property(nonatomic, strong) UIButton *authCodeBtn;
@property(nonatomic, strong)NSTimer *timer;//定时器
@property(nonatomic, assign)int timeCount;//倒计时
@property(nonatomic, assign)BOOL isClick;//验证码按钮是否已点击状态


@end

@implementation ForgetPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleStr = @"忘记密码";
    [self creatCodeLoginView];
   
}

- (void)creatCodeLoginView
{
    UIView *codeLoginView = [[UIView alloc] init];
    codeLoginView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:codeLoginView];
    self.codeLoginView = codeLoginView;
    [codeLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(80);
        make.left.equalTo(self.view);
        make.size.equalTo(CGSizeMake(SCREEN_WEIGHT, textViewHeight * 3));
        
    }];
    EnterTextFiledView *codePhoneEnterView = [EnterTextFiledView EnterTextFiledViewWithTitle:@"手机号" WithsecureTextEntry:NO];
    [codeLoginView addSubview:codePhoneEnterView];
    self.codePhoneEnterView = codePhoneEnterView;
    [codePhoneEnterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(codeLoginView);
        make.height.offset(textViewHeight);
    }];
    EnterTextFiledView *codeCodeEnterView = [EnterTextFiledView EnterTextFiledViewWithTitle:@"验证码" WithsecureTextEntry:NO];
    codeCodeEnterView.filedRightConstraint.constant = 100;
    [codeLoginView addSubview:codeCodeEnterView];
    self.codeCodeEnterView = codeCodeEnterView;
    [codeCodeEnterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(codeLoginView);
        make.height.offset(textViewHeight);
        make.top.equalTo(codePhoneEnterView.mas_bottom);
    }];
    UIButton *codeBtn = [UIButton buttonWithFrame:CGRectZero title:@"获取验证码" image:nil titleColor:kBgColor target:self action:@selector(getCodeClick)];
    [codeBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    codeBtn.layer.cornerRadius = 5.0;
    codeBtn.layer.borderColor = kBgColor.CGColor;
    codeBtn.layer.borderWidth = 0.5;
    self.authCodeBtn = codeBtn;
    [codeCodeEnterView addSubview:codeBtn];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(codeCodeEnterView).offset(-18);
        make.centerY.equalTo(codeCodeEnterView).offset(5);
        make.size.equalTo(CGSizeMake(77, 26));
    }];
    EnterTextFiledView *passWordEnterView = [EnterTextFiledView EnterTextFiledViewWithTitle:@"密码" WithsecureTextEntry:YES];
    
    [codeLoginView addSubview:passWordEnterView];
    self.passWordEnterView = passWordEnterView;
    [passWordEnterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(codeCodeEnterView);
        make.height.offset(textViewHeight);
        make.top.equalTo(codeCodeEnterView.mas_bottom);
    }];
    
    
    UIButton *loginBtn = [UIButton buttonForNormalWithFrame:CGRectMake(20, passWordEnterView.bottom + 45, SCREEN_WEIGHT - 40, knormalBtnHeight) title:@"确定"  target:self action:@selector(confirmClcik)];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(knormalMargin);
        make.top.equalTo(passWordEnterView.mas_bottom).offset(30);
        make.size.offset(CGSizeMake(SCREEN_WEIGHT - 2 * knormalMargin, knormalBtnHeight));
    }];
}
- (void)confirmClcik
{
    if (![[self.codePhoneEnterView getEnterText] isMatchWithRegexString:REGEX_mobile]) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if ([[self.codeCodeEnterView getEnterText] isEmptyOrWhitespace]) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if ([[self.passWordEnterView getEnterText] isEmptyOrWhitespace]) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //请求订单号
//    parameters[@"mobile"] = [self.codePhoneEnterView getEnterText];
//    parameters[@"name"] = [self.nameEnterView getEnterText];
//    parameters[@"verify"] = [self.codeCodeEnterView getEnterText];
}
/**
 获取验证码
 */
- (void)getCodeClick
{
    if (![[self.codePhoneEnterView getEnterText] isMatchWithRegexString:REGEX_mobile]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    [self timerBegin];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //请求订单号
    parameters[@"mobile"] = [self.codePhoneEnterView getEnterText];
    
    
    [HttpTool postWithPath:@"User/yzmSend" params:parameters success:^(id responseObj) {
        
        if (![responseObj isSuccess]) {
            [responseObj showErrorMesg];
            [self stopTimer];
        }
    } failure:^(NSError *error) {
        [self stopTimer];
    }];
}

#pragma mark - 定时器
/**
 *  倒计时完毕时页面的显示
 */
-(void)updateAction
{
    NSString *string = [NSString stringWithFormat:@"%d秒",codeminute - self.timeCount];
    [self.authCodeBtn setTitle:string forState:UIControlStateNormal];
    if (self.timeCount >= codeminute)
    {
        
        [self stopTimer];
    }
    else
    {
        self.timeCount += 1;
    }
}

/**
 *  停止Nstimer
 */
- (void)stopTimer
{
    self.timeCount = 0;
    [self.authCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    self.authCodeBtn.userInteractionEnabled = YES;
    if (self.timer && self.timer.isValid)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)timerBegin
{
    self.authCodeBtn.userInteractionEnabled = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateAction) userInfo:nil repeats:YES];
}
@end
