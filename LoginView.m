//
//  LoginView.m
//  CarSource
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginView.h"
#import "NSString+MD5.h"

@interface LoginView ()<UITextFieldDelegate>{
    UITextField *_passwordField;
    UITextField *_textField;
}

@end
@implementation LoginView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    UIImageView *bgImage = [[UIImageView alloc]init];
    bgImage.image = [UIImage imageNamed:@"login_bg.jpg"];
    [self addSubview:bgImage];

    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"登陆";
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:titleLabel];

//    UIImageView *returnImage = [[UIImageView alloc]init];
//    returnImage.image = [UIImage imageNamed:@"return"];
//    [self addSubview:returnImage];
//    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [returnBtn addTarget:self action:@selector(returnButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:returnBtn];
//
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-120, SCREEN_WIDTH-60, 100)];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.alpha = 0.3;
    [self addSubview:bgView];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-120, SCREEN_WIDTH-60, 240)];
    [self addSubview:view];

    UIImageView *nameImage = [[UIImageView alloc]init];
    nameImage.image = [UIImage imageNamed:@"of"];
    [view addSubview:nameImage];

    UIImageView *passwordImage = [[UIImageView alloc]init];
    passwordImage.image = [UIImage imageNamed:@"what"];
    [view addSubview:passwordImage];

    UIImageView *image = [[UIImageView alloc]init];
    image.backgroundColor = [UIColor whiteColor];
    [view addSubview:image];

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor whiteColor];
    [view addSubview:imageView];

    UIImageView *lineImage = [[UIImageView alloc]init];
    lineImage.backgroundColor = GRAY;
    [view addSubview:lineImage];


    _textField = [[UITextField alloc]init];
    _textField.font = [UIFont systemFontOfSize:15];
    //    textField.placeholder = @"输入你要找的车型、车号、价格";
    _textField.delegate = self;
//    _textField.text = @"13420902160";
//    _textField.text = @"13138181348";
    _textField.text = @"18689620485";
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.textColor = [UIColor whiteColor];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    [_textField setReturnKeyType : UIReturnKeyDone ];
    _textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"输入您的手机号" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} ];
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    [view addSubview:_textField];

    _passwordField = [[UITextField alloc]init];
    _passwordField.font = [UIFont systemFontOfSize:15];
    //    textField.placeholder = @"输入你要找的车型、车号、价格";
    _passwordField.delegate = self;
//    _passwordField.text = @"111111";
    _passwordField.text = @"123456";
    _passwordField.secureTextEntry = YES;
    _passwordField.leftViewMode = UITextFieldViewModeAlways;
    _passwordField.textColor = [UIColor whiteColor];
    [_passwordField setReturnKeyType : UIReturnKeyDone ];
    _passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    _passwordField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"输入您的账号密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} ];
    _passwordField.clearButtonMode = UITextFieldViewModeAlways;
    [view addSubview:_passwordField];

   UIButton *registeredBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registeredBtn setTitle:@"注册" forState:UIControlStateNormal];
    registeredBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    registeredBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [registeredBtn addTarget:self action:@selector(registeredButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:registeredBtn];

    UIButton *passwordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
     passwordBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    passwordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [passwordBtn addTarget:self action:@selector(passwordButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:passwordBtn];

    UIImageView *submitImage = [[UIImageView alloc]init];
    submitImage.backgroundColor = COLOR;
    submitImage.layer.cornerRadius = 5;
    submitImage.layer.masksToBounds = YES;
    submitImage.alpha = 0.5;
    [view addSubview:submitImage];

    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"登陆" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
       //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
//    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:submitButton];


    [bgImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.bottom.equalTo(@0);
    }];

    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.top.equalTo(@15);
        make.right.equalTo(self).offset(-70);
        make.height.equalTo(@40);
    }];

//    [returnImage makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@20);
//        make.top.equalTo(@30);
//        make.size.equalTo(CGSizeMake(15, 18));
//
//    }];
//
//    [returnBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@0);
//        make.top.equalTo(@0);
//        make.size.equalTo(CGSizeMake(60, 64));
//
//    }];

    [lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@50);
        make.right.equalTo(view).offset(@0);
        make.height.equalTo(@1);
    }];

    [nameImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@15);
        make.size.equalTo(CGSizeMake(20, 20));

    }];

    [passwordImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@65);
        make.size.equalTo(CGSizeMake(20, 20));

    }];

    [image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(1, 30));

    }];
    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(@60);
        make.size.equalTo(CGSizeMake(1, 30));

    }];
    
    [_textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.top.equalTo(@10);
        make.right.equalTo(view).offset(-10);
        make.height.equalTo(@30);
    }];

    [_passwordField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.top.equalTo(@60);
        make.right.equalTo(view).offset(-10);
        make.height.equalTo(@30);
    }];

    [registeredBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@100);
        make.size.equalTo(CGSizeMake(60, 40));

    }];
    [passwordBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-10);
        make.top.equalTo(@100);
        make.size.equalTo(CGSizeMake(100, 40));

    }];


    [submitImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@170);
        make.right.equalTo(view).offset(-10);
        make.height.equalTo(@40);
    }];


    [submitButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@170);
        make.right.equalTo(view).offset(-10);
        make.height.equalTo(@40);
    }];

    
}
- (void)submitButtonClick{
    if (_textField.text == nil || [_textField.text isEqualToString:@""]) {
        SHOW_ALERT(@"请输入手机号码");
        return;
    }
    if (_textField.text.length != 11) {
        SHOW_ALERT(@"请输入正确的手机号码");
        return;
    }
    if (_passwordField.text == nil || [_passwordField.text isEqualToString:@""]) {
        SHOW_ALERT(@"密码不能为空");
        return;
    }
    if (_passwordField.text.length < 6 ||_passwordField.text.length > 13) {
        SHOW_ALERT(@"请输入6-12位数密码")
        return;
    }

    self.submitBtn(_textField.text,[_passwordField.text MD5]);
}
- (void)passwordButtonClick{
    self.password(nil);
}
- (void)registeredButtonClick{
    self.registered(nil);
}
- (void)returnButtonClick{
    self.returnBtn(nil);

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
