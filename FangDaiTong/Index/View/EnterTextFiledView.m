//
//  EnterTextFiledView.m
//  FangDaiTong
//
//  Created by yhj on 2017/10/10.
//  Copyright © 2017年 yhj. All rights reserved.
//

#import "EnterTextFiledView.h"

@interface EnterTextFiledView ()
@property (weak, nonatomic) IBOutlet UITextField *enterTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *eyesBtn;
- (IBAction)eyesBtnClick:(UIButton *)sender;


@end

@implementation EnterTextFiledView

+ (instancetype)EnterTextFiledViewWithTitle:(NSString *)title WithsecureTextEntry:(BOOL)isSecureTextEntry
{
    EnterTextFiledView *myview =  [[[NSBundle mainBundle] loadNibNamed:@"EnterTextFiledView" owner:nil options:nil] firstObject];
    myview.enterTextFiled.placeholder = title;
    myview.enterTextFiled.secureTextEntry = isSecureTextEntry;
    myview.eyesBtn.hidden = !isSecureTextEntry;
    myview.enterTextFiled.returnKeyType = UIReturnKeyDone;
    
    return myview;
}

- (NSString *)getEnterText
{
    return self.enterTextFiled.text;
}

//sign by tan为什么不收键盘

- (BOOL)textFieldShouldReturn:(UITextField *)enterTextFiled {
    
    [enterTextFiled resignFirstResponder];//取消第一响应者
    
    return YES;
}

//- (IBAction)enterTextFiled:(UITextField *)sender {
//    sender.selected = !sender.selected;
//    self.enterTextFiled.secureTextEntry = !sender.selected;
//}

- (IBAction)eyesBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.enterTextFiled.secureTextEntry = !sender.selected;
}
@end
