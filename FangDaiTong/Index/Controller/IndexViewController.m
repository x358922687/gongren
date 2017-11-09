//
//  IndexViewController.m
//  FangDaiTong
//
//  Created by yhj on 2017/9/27.
//  Copyright © 2017年 yhj. All rights reserved.
//

#import "IndexViewController.h"
#import "YSCollectionView.h"
#import "BuyOrderViewController.h"

@interface IndexViewController ()
@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) CGFloat scacle;
@end

@implementation IndexViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"商家首页";

    
    [self creatMapView];
    [self creatBtn];
   
}

- (void)creatMapView
{
    mapImageView = [[UIImageView alloc] init];
    if (IS_IPHONE_X) {
//        mapImageView.image = [UIImage imageNamed:@"indexX_02"];
        mapImageView.image = [UIImage imageNamed:@"index1"];
    }else
    {
         mapImageView.image = [UIImage imageNamed:@"index1"];
    }
    [self.view addSubview:mapImageView];
//    CGFloat imgHeight = IS_IPHONE_X ? 362.5 : HJHeightValue(303);
//    CGFloat bottomMargin = IS_IPHONE_X ? 83 : 49;
    CGFloat imgHeight = HJHeightValue(303);
    CGFloat bottomMargin = 49;
    [mapImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.size.offset(CGSizeMake(SCREEN_WEIGHT, imgHeight));
        make.bottom.equalTo(self.view).offset(-bottomMargin);
    }];
}

- (void)creatBtn{

    UIButton *creatBtn1 = [UIButton buttonForNormalWithFrame:CGRectMake(MAXWEIGHT - circleBtnMargin - 20, self.view.height - 120 -(circleBtnMargin+10)*4, circleBtnMargin, circleBtnMargin) title:@"其他"  target:self action:@selector(creatBtn1Action)];
    creatBtn1.layer.cornerRadius = circleBtnMargin/2;
    [self.view addSubview:creatBtn1];
    
    UIButton *creatBtn2 = [UIButton buttonForNormalWithFrame:CGRectMake(MAXWEIGHT - circleBtnMargin - 20, self.view.height - 120 - (circleBtnMargin+10)*3, circleBtnMargin, circleBtnMargin) title:@"下单"  target:self action:@selector(creatBtn2Action)];
    creatBtn2.layer.cornerRadius = circleBtnMargin/2;
    [self.view addSubview:creatBtn2];
    
    UIButton *creatBtn3 = [UIButton buttonForNormalWithFrame:CGRectMake(MAXWEIGHT - circleBtnMargin - 20, self.view.height - 120 - (circleBtnMargin+10)*2, circleBtnMargin, circleBtnMargin) title:@"附近"  target:self action:@selector(creatBtn3Action)];
    creatBtn3.layer.cornerRadius = circleBtnMargin/2;
    [self.view addSubview:creatBtn3];
    
    UIButton *creatBtn4 = [UIButton buttonForNormalWithFrame:CGRectMake(MAXWEIGHT - circleBtnMargin - 20, self.view.height - 120 - (circleBtnMargin+10)*1, circleBtnMargin, circleBtnMargin) title:@"找人"  target:self action:@selector(creatBtn4Action)];
    creatBtn4.layer.cornerRadius = circleBtnMargin/2;
    [self.view addSubview:creatBtn4];
    
}

- (void)creatBtn1Action{
    BuyOrderViewController *personVc = [[BuyOrderViewController alloc]init];
    [self.navigationController pushViewController:personVc animated:YES];
}

- (void)creatBtn2Action{
    BuyOrderViewController *personVc = [[BuyOrderViewController alloc]init];
    [self.navigationController pushViewController:personVc animated:YES];
}

- (void)creatBtn3Action{
    BuyOrderViewController *personVc = [[BuyOrderViewController alloc]init];
    [self.navigationController pushViewController:personVc animated:YES];
}

- (void)creatBtn4Action{
    BuyOrderViewController *personVc = [[BuyOrderViewController alloc]init];
    [self.navigationController pushViewController:personVc animated:YES];
}

-(void)creatBt5Action{
    
}


@end
