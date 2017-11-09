//
//  UserViewController.m
//  FangDaiTong
//
//  Created by yhj on 2017/9/27.
//  Copyright © 2017年 yhj. All rights reserved.
//
#define KcellHeight 44
#import "UserViewController.h"
#import "UserCenterTableViewCell.h"
#import "LoginViewController.h"
#import "PersonViewController.h"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)UIButton *loginBtn;
@property(nonatomic, strong)UILabel *nameLbl;

@property(nonatomic, strong)NSArray *dataArray;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTopView];
    [self loadTableview];
    
}


- (void)loadTableview
{
    NSArray *array = @[
                       @{@"title" : @"我的信息", @"image" : @"ic_manager_nor",@"tag" :@1},
                       @{@"title" : @"邀请好友", @"image" : @"ic_shareborrower_nor",@"tag" :@2},
                       @{@"title" : @"关于我们", @"image" : @"ic_about_nor",@"tag" :@3},
                       @{@"title" : @"联系我们", @"image" : @"ic_contact_nor",@"tag" :@4},
                       ];
    self.dataArray = [NSArray arrayWithArray:array];
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = CGRectMake(0, 150, SCREEN_WEIGHT, KcellHeight * array.count);
    tableView.scrollEnabled = NO;//不需要滑动
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    
    
    [self.view addSubview:tableView];
    [self.tableView reloadData];
}
- (void)creatTopView
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, 150)];
    topView.backgroundColor = kBgColor;
    [self.view addSubview:topView];
    
    UIButton *headBtn = [UIButton buttonForcornerRadius:34 target:self action:@selector(headBtnClick)];
    [headBtn  sd_setImageWithURL:nil forState:UIControlStateNormal placeholderImage:nil];
    [topView addSubview:headBtn];
    [headBtn setBackgroundColor:[UIColor yellowColor]];
    [headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.offset(CGSizeMake(68, 68));
        make.centerX.equalTo(topView);
        make.top.offset(10);
    }];
    UIButton *loginBtn = [UIButton  buttonForBorderColor:[UIColor whiteColor] title:@"请登录" font:kTintFont target:self action:@selector(loginBtnClick)];
    [topView addSubview:loginBtn];
    self.loginBtn = loginBtn;
   // [loginBtn setBackgroundColor:[UIColor yellowColor]];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.offset(CGSizeMake(70, 22));
        make.centerX.equalTo(topView);
        make.top.equalTo(headBtn.mas_bottom).offset(15);
    }];
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectZero textColor:[UIColor whiteColor] font:kTintFont];
    if(!1){
        nameLbl.text = @"砾途户外大家都爱";
    }//未登陆状态
    self.nameLbl = nameLbl;
    [topView addSubview:nameLbl];
    [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
      make.top.equalTo(headBtn.mas_bottom).offset(15);
        
    }];
}
- (void)headBtnClick
{
    PersonViewController *personVc = [[PersonViewController alloc]init];
    [self.navigationController pushViewController:personVc animated:YES];
}
- (void)loginBtnClick
{
    LoginViewController *logVc = [[LoginViewController alloc] init];
    [self presentViewController:logVc animated:YES completion:nil];
    
}
#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return  self.dataArray.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCenterTableViewCell"];
    if (!cell) {
        
        cell=[[[NSBundle mainBundle]loadNibNamed:@"UserCenterTableViewCell" owner:nil options:nil]firstObject];
        
    }
    cell.dic = self.dataArray[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    int tag = [self.dataArray[indexPath.row][@"tag"] intValue];
    switch (tag) {
        case 1:
            //我的信贷经理
            DLog(@"我的信贷");
            break;
        case 2:
            //邀请好友
            break;
        case 3:
            //关于我们
            break;
        case 4:
            //联系我们
            break;
        case 5:
            
            break;
            
        default:
            break;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KcellHeight;
}

@end
