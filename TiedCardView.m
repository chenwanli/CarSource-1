//
//  TiedCardView.m
//  CarSource
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TiedCardView.h"
@interface TiedCardView()<UITextFieldDelegate>
{
    UITextField *_nameText;
    UITextField *_numberText;
}

@end
@implementation TiedCardView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    self.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];

    UILabel *promptLabel = [[UILabel alloc]init];
    promptLabel.textColor = [UIColor lightGrayColor];
    promptLabel.font = [UIFont systemFontOfSize:14];
    promptLabel.text = @"为方便支付，请绑定个人有效的银行卡";
    [self addSubview:promptLabel];

    UIImageView *bgIamge = [[UIImageView alloc]init];
    bgIamge.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgIamge];

    UIImageView *backIamge = [[UIImageView alloc]init];
    backIamge.backgroundColor = [UIColor whiteColor];
    [self addSubview:backIamge];


    UILabel *cardLabel = [[UILabel alloc]init];
    cardLabel.textColor = [UIColor grayColor];
    cardLabel.font = [UIFont systemFontOfSize:17];
    cardLabel.text = @"持卡人";
    [self addSubview:cardLabel];

    UILabel *cardNumber = [[UILabel alloc]init];
    cardNumber.textColor = [UIColor grayColor];
    cardNumber.font = [UIFont systemFontOfSize:17];
    cardNumber.text = @"卡号";
    [self addSubview:cardNumber];

    _nameText = [[UITextField alloc]init];
    _nameText.font = [UIFont systemFontOfSize:15];
    _nameText.delegate = self;
    _nameText.placeholder = @"姓名";
    _nameText.textColor = [UIColor grayColor];
    [_nameText setReturnKeyType : UIReturnKeyDone ];
    _nameText.clearButtonMode = UITextFieldViewModeAlways;
//    _nameText.keyboardType = UIKeyboardTypeDecimalPad;
    [self addSubview:_nameText];

    _numberText = [[UITextField alloc]init];
    _numberText.font = [UIFont systemFontOfSize:15];
    _numberText.delegate = self;
    _numberText.placeholder = @"银行卡号";
    _numberText.textColor = [UIColor grayColor];
    [_numberText setReturnKeyType : UIReturnKeyDone ];
    _numberText.clearButtonMode = UITextFieldViewModeAlways;
    _numberText.keyboardType = UIKeyboardTypeDecimalPad;
    [self addSubview:_numberText];

    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"确定提现" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitButton];

    [promptLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];

    [bgIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@50);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@60);
    }];

    [backIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@130);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@60);
    }];


    [cardLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@60);
        make.size.equalTo(CGSizeMake(55, 40));
    }];


    [cardNumber makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@140);
        make.size.equalTo(CGSizeMake(50, 40));
    }];
    

    [_nameText makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@60);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@40);
    }];
    

    [_numberText makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@140);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@40);
    }];
    

    [submitButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(@230);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@50);
    }];
    


    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}

//这个函数的最后一个参数text代表你每次输入的的那个字，所以：
- (BOOL)textView:(UITextField *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }

    return YES;
}

- (void)submitButtonClick:(UIButton *)button{
    [self endEditing:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
