//
//  LoginViewController.m
//  FangDaiTong
//
//  Created by yhj on 2017/10/9.
//  Copyright © 2017年 yhj. All rights reserved.
//



#import "LoginViewController.h"
#import "EnterTextFiledView.h"
#import "ForgetPsdViewController.h"
#import "registerViewController.h"


@interface LoginViewController ()
//是否验证码登录
@property (nonatomic, assign) BOOL isCodeLoginType;
//登录方式view层
@property(nonatomic, strong)UIView *loginTypeView;
@property(nonatomic, strong)UIButton *psdLoginBtn;
@property(nonatomic, strong)UIButton *codeLoginBtn;
@property(nonatomic, strong)UIImageView *scollLineView;
//密码登录
@property(nonatomic, strong)UIView *phoneLoginView;
@property(nonatomic, strong) EnterTextFiledView *psdPhoneEnterView;
@property(nonatomic, strong) EnterTextFiledView *psdPassWordEnterView;

//验证码登录
@property(nonatomic, strong)UIView *codeLoginView;
@property(nonatomic, strong) EnterTextFiledView *codePhoneEnterView;
@property(nonatomic, strong) EnterTextFiledView *codeCodeEnterView;
@property(nonatomic, strong) UIButton *authCodeBtn;
@property(nonatomic, strong)NSTimer *timer;//定时器
@property(nonatomic, assign)int timeCount;//倒计时
@property(nonatomic, assign)BOOL isClick;//验证码按钮是否已点击状态


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self creatTitleView];
    [self creatLoginTypeView];
    [self creatPhoneLoginView];
    [self.view layoutIfNeeded];//不加无法更新约束
    [self creatLoginBtnViews];
     
    
}
//- (void)creatTitleView
//{
//    UILabel *titleLbl = [UILabel labelWithFrame:CGRectZero textColor:kTitleColor font:kNormalFont];
//    titleLbl.text = @"登录";
//    [self.view addSubview:titleLbl];
//    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.offset(31);
//    }];
//}
- (void)creatPhoneLoginView
{
    UIView *phoneLoginView = [[UIView alloc] init];
    [self.view addSubview:phoneLoginView];
    self.phoneLoginView = phoneLoginView;
    [phoneLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginTypeView.mas_bottom).offset(50);
        make.left.offset(0);
        make.size.equalTo(CGSizeMake(SCREEN_WEIGHT, textViewHeight * 2));
        
    }];
    EnterTextFiledView *psdPhoneEnterView = [EnterTextFiledView EnterTextFiledViewWithTitle:@"手机号" WithsecureTextEntry:NO];
    
    [phoneLoginView addSubview:psdPhoneEnterView];
    self.psdPhoneEnterView = psdPhoneEnterView;
    [psdPhoneEnterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(phoneLoginView);
        make.height.offset(textViewHeight);
    }];
    
    EnterTextFiledView *psdPassWordEnterView = [EnterTextFiledView EnterTextFiledViewWithTitle:@"密码" WithsecureTextEntry:YES];
    [phoneLoginView addSubview:psdPassWordEnterView];
    self.psdPassWordEnterView = psdPassWordEnterView;
    [psdPassWordEnterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(phoneLoginView);
        make.height.offset(textViewHeight);
        make.top.equalTo(psdPhoneEnterView.mas_bottom);
    }];
}
- (void)creatCodeLoginView
{
    if (self.codePhoneEnterView) return;
    UIView *codeLoginView = [[UIView alloc] init];
    codeLoginView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:codeLoginView];
    self.codeLoginView = codeLoginView;
    [codeLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginTypeView.mas_bottom).offset(50);
        make.left.offset(-SCREEN_WEIGHT);
        make.size.equalTo(CGSizeMake(SCREEN_WEIGHT, textViewHeight * 2));
        
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
    self.authCodeBtn = codeBtn;
    [codeBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    codeBtn.layer.cornerRadius = 5.0;
    codeBtn.layer.borderColor = kBgColor.CGColor;
    codeBtn.layer.borderWidth = 0.5;
    [codeCodeEnterView addSubview:codeBtn];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(codeCodeEnterView).offset(-18);
        make.centerY.equalTo(codeCodeEnterView).offset(5);
        make.size.equalTo(CGSizeMake(77, 26));
    }];
}
/**
 创建顶部登录模式按钮
 */
- (void)creatLoginTypeView
{
   
    UIView *LoginTypeView = [[UIView alloc] init];
    //LoginTypeView.backgroundColor = [UIColor blackColor];
    self.loginTypeView = LoginTypeView;
    [self.view addSubview:LoginTypeView];
    [LoginTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(107);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(220, 40));
        
    }];
    UIButton *psdLoginBtn = [UIButton buttonWithFrame:CGRectZero title:@"密码登录" textFont:kTintFont bgImage:nil titleColor:k999Color target:self action:@selector(loginTypeBtnClick:)];
    psdLoginBtn.tag = 1;
    [psdLoginBtn setTitleColor:kBgColor forState:UIControlStateSelected];
    psdLoginBtn.selected = YES;
    [LoginTypeView addSubview:psdLoginBtn];
    self.psdLoginBtn = psdLoginBtn;
   // [psdLoginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor yellowColor]] forState:UIControlStateNormal];
   // CGFloat btnWidth = LoginTypeView.size.width * 0.5;
    [psdLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(LoginTypeView).multipliedBy(0.5);
        make.left.and.top.equalTo(LoginTypeView).offset(0);
        make.height.equalTo(LoginTypeView).offset(-2);
        //make.top.equalTo(LoginTypeView);
        
        
    }];

     UIButton *codeLoginBtn = [UIButton buttonWithFrame:CGRectZero title:@"验证码登录" textFont:kTintFont bgImage:nil titleColor:k999Color target:self action:@selector(loginTypeBtnClick:)];
     [codeLoginBtn setTitleColor:kBgColor forState:UIControlStateSelected];
     [LoginTypeView addSubview:codeLoginBtn];
    self.codeLoginBtn = codeLoginBtn;
    [codeLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(LoginTypeView).multipliedBy(0.5);
        make.right.and.top.equalTo(LoginTypeView).offset(0);
        make.height.equalTo(LoginTypeView).offset(-2);
      
        
        
    }];
    UIImageView *lineView = [UIImageView imageViewWithFrame:CGRectZero color:kBgColor];
    self.scollLineView = lineView;
    [LoginTypeView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.width.equalTo(LoginTypeView).multipliedBy(0.5);
        make.bottom.left.equalTo(LoginTypeView).offset(0);
        make.height.offset(1);
    }];
    
    
}

/**
 创建登录 忘记密码 注册 按钮
 */
- (void)creatLoginBtnViews
{
    UIButton *loginBtn = [UIButton buttonForNormalWithFrame:CGRectMake(20, self.phoneLoginView.bottom + 45, SCREEN_WEIGHT - 40, knormalBtnHeight) title:@"登录"  target:self action:@selector(loginBtnClick)];
    [self.view addSubview:loginBtn];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WEIGHT / 2, loginBtn.bottom + 20, 1, 12)];
    lineView.backgroundColor = knormalBtnTextColor;
    [self.view addSubview:lineView];
   
    UIButton *forgetBtn = [UIButton buttonWithFrame:CGRectZero title:@"忘记密码" textFont:kPriceFont bgImage:nil titleColor: [UIColor colorWithHex:@"999999"] target:self action:@selector(forgetPsdClick)];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(lineView);
        make.right.equalTo(lineView.mas_left).offset(-5);
        
    }];
    UIButton *registerBtn = [UIButton buttonWithFrame:CGRectZero title:@"快速注册" textFont:kPriceFont bgImage:nil titleColor: [UIColor colorWithHex:@"999999"] target:self action:@selector(registerClick)];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(lineView);
        make.left.equalTo(lineView.mas_right).offset(5);
        
    }];
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

/**
 登录点击
 */
- (void)loginBtnClick
{
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (self.isCodeLoginType) {
        //验证码登录
        if (![[self.codePhoneEnterView getEnterText] isMatchWithRegexString:REGEX_mobile]) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
            return;
        }
        if([[self.codeCodeEnterView getEnterText] isEmptyOrWhitespace]) {
            [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
            return;
        }
        
        parameters[@"mobile"] = [self.codePhoneEnterView getEnterText];
        parameters[@"verify"] = [self.codeCodeEnterView getEnterText];
        [self loginWithParameters:parameters];
        
    }else
    {
        if (![[self.psdPhoneEnterView getEnterText] isMatchWithRegexString:REGEX_mobile]) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
            return;
        }
        if ([[self.psdPassWordEnterView getEnterText] isEmptyOrWhitespace]) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        parameters[@"mobile"] = [self.psdPhoneEnterView getEnterText];
        parameters[@"password"] = [self.psdPassWordEnterView getEnterText];
        [self loginWithParameters:parameters];
    }
   
}
- (void)loginWithParameters:(NSMutableDictionary *)parameters
{
    [HttpTool postWithPath:@"User/login" params:parameters success:^(id responseObj) {
        
        
        if (![responseObj isSuccess]) {
            [responseObj showErrorMesg];
            return ;
        }
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:kLoadingError];
    }];
}
/**
 忘记密码
 */
- (void)forgetPsdClick
{
    ForgetPsdViewController *forgrtVc = [[ForgetPsdViewController alloc]init];
   // UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:forgrtVc];
   // [self.navigationController pushViewController:forgrtVc animated:YES];
    [self presentViewController:forgrtVc animated:YES completion:nil];
    DLog(@"forgetClick");
}

/**
 快速注
 */
- (void)registerClick
{
    registerViewController *VC = [[registerViewController alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
}
 - (void)loginTypeBtnClick:(UIButton *)sender
 {
     WeakSelf;
     if (sender.selected)  return;
     if (sender.tag == 1) {
         sender.selected = YES;
         self.codeLoginBtn.selected = NO;
         _isCodeLoginType = NO;
         [weakSelf.scollLineView mas_updateConstraints:^(MASConstraintMaker *make) {
             
             make.left.offset(0);
            
         }];
         [weakSelf.codeLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
             
             make.left.offset(-SCREEN_WEIGHT);
             
         }];
         [weakSelf.phoneLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
             
             make.left.offset(0);
             
         }];
     }else
     {
         sender.selected = YES;
         self.psdLoginBtn.selected = NO;
         self.isCodeLoginType = YES;
          [self creatCodeLoginView];
         [self.view layoutIfNeeded];
         //验证码登录
         [weakSelf.scollLineView mas_updateConstraints:^(MASConstraintMaker *make) {

              make.left.offset(weakSelf.scollLineView.size.width);
             make.height.offset(1);

         }];
         [weakSelf.codeLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
             
             make.left.offset(0);
             
         }];
         [weakSelf.phoneLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
             
             make.left.offset(SCREEN_WEIGHT);
             
         }];
        
     }
     [UIView animateWithDuration:0.5 animations:^{
         self.view.userInteractionEnabled = NO;
         [self.view layoutIfNeeded];
     } completion:^(BOOL finished) {
         self.view.userInteractionEnabled = YES;
         [self.view endEditing:YES];
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
