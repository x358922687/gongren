//
//  PersonViewController.m
//  FangDaiTong
//
//  Created by yhj on 2017/10/14.
//  Copyright © 2017年 yhj. All rights reserved.
//

#import "PersonViewController.h"
#import "ChangePsdViewController.h"

@interface PersonViewController ()
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
- (IBAction)headClick;
- (IBAction)nameClcik;
- (IBAction)accountClcik;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)headClick {
}

- (IBAction)nameClcik {
}

- (IBAction)accountClcik {
    ChangePsdViewController *vc = [[ChangePsdViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
