//
//  EnterTextFiledView.h
//  FangDaiTong
//
//  Created by yhj on 2017/10/10.
//  Copyright © 2017年 yhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterTextFiledView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filedRightConstraint;
+ (instancetype)EnterTextFiledViewWithTitle:(NSString *)title WithsecureTextEntry:(BOOL)isSecureTextEntry;

- (NSString *)getEnterText;
@end
