//
//  ChangeThePassword.m
//  CarSource
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChangeThePassword.h"
#import "NSString+MD5.h"

@interface ChangeThePassword ()<UITextFieldDelegate>
{
    UITextField *_newField;
    UITextField *_oldField;
}
@end
@implementation ChangeThePassword
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{


    UILabel *oldLabel = [[UILabel alloc]init];
    oldLabel.text = @"旧密码：";
    oldLabel.font = [UIFont systemFontOfSize:16];
    oldLabel.textColor = BLACK;
    [self addSubview:oldLabel];

    UILabel *newLabel = [[UILabel alloc]init];
    newLabel.text = @"新密码：";
    newLabel.font = [UIFont systemFontOfSize:16];
    newLabel.textColor = BLACK;
    [self addSubview:newLabel];

    _oldField = [[UITextField alloc]init];
    _oldField.font = [UIFont systemFontOfSize:15];
    _oldField.placeholder = @"请输入您的旧密码";
    _oldField.delegate = self;
    _oldField.secureTextEntry = YES;
    _oldField.borderStyle = UITextBorderStyleRoundedRect;
    _oldField.leftViewMode = UITextFieldViewModeAlways;
    _oldField.textColor = [UIColor grayColor];
    _oldField.keyboardType = UIKeyboardTypeASCIICapable;
    [_oldField setReturnKeyType : UIReturnKeyDone ];
    _oldField.clearButtonMode = UITextFieldViewModeAlways;
    [self  addSubview:_oldField];

    _newField = [[UITextField alloc]init];
    _newField.font = [UIFont systemFontOfSize:15];
    _newField.placeholder = @"请输入您的新密码";
    _newField.delegate = self;
    _newField.secureTextEntry = YES;
    _newField.leftViewMode = UITextFieldViewModeAlways;
    _newField.textColor = [UIColor grayColor];
    _newField.borderStyle = UITextBorderStyleRoundedRect;
    _newField.keyboardType = UIKeyboardTypeASCIICapable;
    [_newField setReturnKeyType : UIReturnKeyDone ];
    _newField.clearButtonMode = UITextFieldViewModeAlways;
    [self  addSubview:_newField];

    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(30, 220, SCREEN_WIDTH-60, 50);
    [submitButton setTitle:@"确认修改" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
    submitButton.backgroundColor = COLOR;
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitButton];

    [oldLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@50);
        make.size.equalTo(CGSizeMake(70, 40));
    }];

    [newLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@110);
        make.size.equalTo(CGSizeMake(70, 40));
    }];


    [_oldField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.top.equalTo(@50);
        make.right.equalTo(self).offset(-15);
        make.height.equalTo(@40);
    }];


    [_newField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.top.equalTo(@110);
        make.right.equalTo(self).offset(-15);
        make.height.equalTo(@40);
    }];

}
- (void)submitButtonClick{
    if (_oldField.text == nil || [_oldField.text isEqualToString:@""]) {
        SHOW_ALERT(@"旧密码不能为空");
        return;
    }
    if (_oldField.text.length < 6 ||_oldField.text.length > 13) {
        SHOW_ALERT(@"请输入6-12位数旧密码")
        return;
    }

    if (_newField.text == nil || [_newField.text isEqualToString:@""]) {
        SHOW_ALERT(@"新密码不能为空");
        return;
    }
    if (_newField.text.length < 6 ||_newField.text.length > 13) {
        SHOW_ALERT(@"请输入6-12位数新密码")
        return;
    }

    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [LCCoolHUD showLoading:@"正在修改，请稍等" inView:self];

    [RequestClass postChangeThePasswordRequestWithUserId:login.userId password:[_oldField.text MD5] newPassword:[_newField.text MD5] Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {

        [LCCoolHUD hideInView:self];
        if ([errorMessage isEqualToString:@"0"] ) {

            [LCCoolHUD showSuccess:@"修改密码成功" zoom:YES shadow:YES];
        }

    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
