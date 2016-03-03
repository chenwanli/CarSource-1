//
//  ForgotPasswordView.m
//  CarSource
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ForgotPasswordView.h"

@interface ForgotPasswordView ()<UITextFieldDelegate>{
    NSString *_telStr;
    NSString *_codeStr;
    NSString *_passwordStr;
    NSString *_code;
    UILabel *_verification;
    NSTimer *_countTimer;
    NSInteger _timerCount;
    UILabel *_titleLabel;

}

@end

@implementation ForgotPasswordView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{
    _timerCount = 60;

    UIImageView *bgImage = [[UIImageView alloc]init];
    bgImage.image = [UIImage imageNamed:@"login_bg.jpg"];
    [self addSubview:bgImage];

    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = @"找回密码";
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:_titleLabel];

    UIImageView *returnImage = [[UIImageView alloc]init];
    returnImage.image = [UIImage imageNamed:@"return"];
    [self addSubview:returnImage];
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnBtn addTarget:self action:@selector(returnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:returnBtn];

    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-130, SCREEN_WIDTH-60, 150)];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.alpha = 0.3;
    [self addSubview:bgView];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-130, SCREEN_WIDTH-60, 260)];
    [self addSubview:view];

    NSArray *array = [[NSArray alloc]initWithObjects:@"+86",@"",@"重置密码", nil];
    NSArray *textArray = [[NSArray alloc]initWithObjects:@"请输入您的手机号码", @"请输入验证码", @"请输入新密码",nil];


    for (int i = 0; i < array.count; i++) {
        if (i == 1) {
            _verification  = [[UILabel alloc] initWithFrame:CGRectMake(5, 50*i +15, 70, 25)];
            _verification.backgroundColor = [UIColor whiteColor];
            _verification.textColor = COLOR;
            _verification.text = @"获取验证码";
            _verification.layer.cornerRadius = 10;
            _verification.layer.masksToBounds = YES;
            _verification.textAlignment = NSTextAlignmentCenter;
            _verification.font = [UIFont systemFontOfSize:12];
            [view addSubview:_verification];

        }


        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(5, 50*i +10, 70, 30);
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:button];

        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(85, 50 *i +10, 1, 30)];
        image.backgroundColor = [UIColor whiteColor];
        [view addSubview:image];

        UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50 *(i +1), view.frame.size.width, 1)];
        lineImage.backgroundColor = GRAY;
        [view addSubview:lineImage];

        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(95, 50 * i, view.frame.size.width - 105, 50)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.delegate = self;
        textField.tag = i +1;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.textColor = [UIColor whiteColor];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [textField setReturnKeyType : UIReturnKeyDone ];
        textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:[textArray objectAtIndex:i] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} ];
        textField.clearButtonMode = UITextFieldViewModeAlways;
        [view addSubview:textField];


        switch (i) {
            case 1:
            {
//                button.titleLabel.font = [UIFont systemFontOfSize:12];
//                button.frame = CGRectMake(5, 50*i +15, 70, 25);
//                [button setTitleColor:COLOR forState:UIControlStateNormal];
//                button.backgroundColor = [UIColor whiteColor];
//                button.layer.cornerRadius = 10;
//                button.layer.masksToBounds = YES;
                button.tag = 100;

                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

            }
                break;
            case 2:
            {
                textField.keyboardType = UIKeyboardTypeASCIICapable;
                textField.secureTextEntry = YES;
                lineImage.hidden = YES;
            }
                break;
            default:
                break;
        }

    }

    UIImageView *submitImage = [[UIImageView alloc]init];
    submitImage.backgroundColor = COLOR;
    submitImage.layer.cornerRadius = 5;
    submitImage.layer.masksToBounds = YES;
    submitImage.alpha = 0.4;
    [view addSubview:submitImage];

    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"确定修改" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:submitButton];



    [bgImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.bottom.equalTo(@0);
    }];

    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.top.equalTo(@15);
        make.right.equalTo(self).offset(-70);
        make.height.equalTo(@40);
    }];

    [returnImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@30);
        make.size.equalTo(CGSizeMake(15, 18));

    }];

    [returnBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.size.equalTo(CGSizeMake(60, 64));

    }];

    [submitImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@200);
        make.right.equalTo(view).offset(-10);
        make.height.equalTo(@40);
    }];


    [submitButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@200);
        make.right.equalTo(view).offset(-10);
        make.height.equalTo(@40);
    }];


}
- (void)textFieldDidEndEditing:(UITextField *)textField{

    switch (textField.tag) {
        case 1:
        {
            _telStr = textField.text;
        }
            break;
        case 2:
        {
            _codeStr = textField.text;
        }
            break;
        case 3:
        {
            _passwordStr = textField.text;
        }
            break;
                default:
            break;
    }
    
}


- (void)submitButtonClick{
    [self endEditing:YES];
    if (_telStr == nil || [_telStr isEqualToString:@""]) {
        SHOW_ALERT(@"请输入手机号码");
        return;
    }
    if (_telStr.length != 11) {
        SHOW_ALERT(@"请输入正确的手机号码");
        return;
    }

    if (_codeStr == nil || [_codeStr isEqualToString:@""]) {
        SHOW_ALERT(@"验证码不能为空");
        return;
    }
    
    if (_passwordStr == nil || [_passwordStr isEqualToString:@""]) {
        SHOW_ALERT(@"密码不能为空");
        return;
    }
    if (_passwordStr.length < 6 ||_passwordStr.length > 13) {
        SHOW_ALERT(@"请输入6-12位数密码")
        return;
    }

   [LCCoolHUD showLoading:@"加载中" inView:self];
    [RequestClass postUserPasswordBackRequestWithTel:_telStr password:_passwordStr code:_codeStr Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {

         [LCCoolHUD hideInView:self];
        if ([errorMessage isEqualToString:@"0"]) {
            self.submit(nil);
        }

    }];

}
- (void)agreementButtonClick:(UIButton *)button{


}
- (void)buttonClick:(UIButton *)button{
    [self endEditing:YES];

    if (_telStr == nil ||[_telStr isEqualToString:@""]) {
        SHOW_ALERT(@"请输入手机号码");
        return;
    }

    if (_telStr.length != 11) {
        SHOW_ALERT(@"请输入正确的手机号码");
        return;
    }

    [button setUserInteractionEnabled:NO];
    _countTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCutDown) userInfo:nil repeats:YES];


    [RequestClass postSMSVerificationRequestWithTel:_telStr type:nil Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
        _code = errorMessage;
    }];
    
}

- (void)timeCutDown{
    _timerCount --;
    _verification.font = [UIFont systemFontOfSize:9];
    _verification.text = [NSString stringWithFormat:@"发送验证码(%lds)",(long)_timerCount];
    if (_timerCount == 0) {
        _verification.font = [UIFont systemFontOfSize:12];
        _timerCount = 60;
        _verification.text =  [NSString stringWithFormat:@"重新发送"] ;
        [_countTimer invalidate];

        UIButton *btn = (UIButton *) [self viewWithTag:100];
        [btn setUserInteractionEnabled:YES];
    }
    
}

- (void)returnButtonClick{
    self.returnBtn(nil);

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [LCCoolHUD hideInView:self];
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
