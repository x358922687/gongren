//
//  UserCenterTableViewCell.m
//  FangDaiTong
//
//  Created by yhj on 2017/10/12.
//  Copyright © 2017年 yhj. All rights reserved.
//

#import "UserCenterTableViewCell.h"

@interface UserCenterTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;

@end
@implementation UserCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    self.imgView.image = [UIImage imageNamed:dic[@"image"]];
    self.titleLbl.text = dic[@"title"];
    if ([dic[@"title"] isEqualToString:@"联系我们"]) {
        self.phoneLbl.hidden = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
