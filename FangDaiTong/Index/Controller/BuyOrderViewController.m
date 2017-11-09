//
//  BuyOrderViewController.m
//  FangDaiTong
//
//  Created by Terry on 2017/10/30.
//  Copyright © 2017年 yhj. All rights reserved.
//

#import "BuyOrderViewController.h"

@interface BuyOrderViewController ()

@end

@implementation BuyOrderViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"下单";
    
    [self creatOrderView];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)creatOrderView{
    
    orderImageView = [[UIImageView alloc] init];
    if (IS_IPHONE_X) {
        orderImageView.image = [UIImage imageNamed:@"Image"];
    }else
    {
        orderImageView.image = [UIImage imageNamed:@"Image"];
    }
    [self.view addSubview:orderImageView];
    //    CGFloat imgHeight = IS_IPHONE_X ? 362.5 : HJHeightValue(303);
    //    CGFloat bottomMargin = IS_IPHONE_X ? 83 : 49;
    CGFloat imgHeight = HJHeightValue(303);
    CGFloat bottomMargin = 49;
    [orderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.size.offset(CGSizeMake(SCREEN_WEIGHT, imgHeight));
        make.bottom.equalTo(self.view).offset(-bottomMargin);
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
