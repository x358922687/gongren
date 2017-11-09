//
//  AccountBaseViewController.m
//  FangDaiTong
//
//  Created by yhj on 2017/10/12.
//  Copyright © 2017年 yhj. All rights reserved.
//

#import "AccountBaseViewController.h"

@interface AccountBaseViewController ()

@property (nonatomic, strong) UILabel *titleLbl;
@end

@implementation AccountBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitleView];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)creatTitleView
{
    UILabel *titleLbl = [UILabel labelWithFrame:CGRectZero textColor:kTitleColor font:kNormalFont];
    titleLbl.text = self.titleStr;
    self.titleLbl = titleLbl;
    [self.view addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(self.view);
        make.top.offset(45);
    }];
    UIButton *backBtn = [UIButton buttonWithFrame:CGRectZero image:[UIImage imageNamed:@"ic_close_nor"] target:self action:@selector(backClick:)];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleLbl).offset(-5);
        make.left.offset(knormalMargin - 10);
        make.size.offset(CGSizeMake(35, 35));
        
    }];
}

- (void)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    self.titleLbl.text = titleStr;
}
@end
