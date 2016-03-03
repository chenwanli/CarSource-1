//
//  DriverView.m
//  CarSource
//
//  Created by apple on 15/12/26.
//  Copyright © 2015年 apple. All rights reserved.
//
//  个人中心表头
#import "DriverView.h"
@interface DriverView ()<UITextFieldDelegate>{

    UITextField *_nameText;
    UITextField *_certificateText;
    UITextField *_phoneText;
}

@end


@implementation DriverView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    self.backgroundColor = [UIColor whiteColor];
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 14, 16, 16)];
    numberLabel.layer.cornerRadius = 8;
    numberLabel.layer.masksToBounds = YES;
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.font = [UIFont systemFontOfSize:13];
    numberLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
    numberLabel.text = @"4";
    [self addSubview:numberLabel];

    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(36, 7, 60, 30)];
    addLabel.textColor = [UIColor grayColor];
    addLabel.font = [UIFont systemFontOfSize:15];
    addLabel.text = @"添加司机";
    [self addSubview:addLabel];

    for (int i = 0; i <3; i++) {
        UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44*i +43, SCREEN_WIDTH -20, 1)];
        lineImage.backgroundColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1];
        [self addSubview:lineImage];

    }
    _nameText = [[UITextField alloc]init];
    _nameText.font = [UIFont systemFontOfSize:14];
    _nameText.placeholder = @"姓名";
    _nameText.delegate = self;
    _nameText.borderStyle = UITextBorderStyleRoundedRect;
    _nameText.textColor = [UIColor grayColor];
    _nameText.backgroundColor = [UIColor colorWithRed:224/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    [_nameText setReturnKeyType : UIReturnKeyDone ];
//    _nameText.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:_nameText];

    _certificateText = [[UITextField alloc]init];
    _certificateText.font = [UIFont systemFontOfSize:14];
    _certificateText.placeholder = @"证件号码";
    _certificateText.delegate = self;
    _certificateText.backgroundColor =[UIColor colorWithRed:224/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    _certificateText.borderStyle = UITextBorderStyleRoundedRect;
    _certificateText.textColor = [UIColor grayColor];
    [_certificateText setReturnKeyType : UIReturnKeyDone ];
//    _certificateText.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:_certificateText];

    _phoneText = [[UITextField alloc]init];
    _phoneText.font = [UIFont systemFontOfSize:14];
    _phoneText.placeholder = @"手机号码";
    _phoneText.delegate = self;
    _phoneText.backgroundColor = [UIColor colorWithRed:224/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    _phoneText.borderStyle = UITextBorderStyleRoundedRect;
    _phoneText.textColor = [UIColor grayColor];
    [_phoneText setReturnKeyType : UIReturnKeyDone ];
    _phoneText.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:_phoneText];

    UIButton *addButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [addButton setTitleColor:COLOR forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];

    [_nameText makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(@51);
        make.size.equalTo(CGSizeMake(80, 30));
    }];

    [_phoneText makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@126);
        make.top.equalTo(@51);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];

    [_certificateText makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(@95);
        make.right.equalTo(self).offset(-70);
        make.height.equalTo(@30);
    }];

    [addButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@95);
        make.size.equalTo(CGSizeMake(50, 30));
    }];


}
- (void)addButtonClick:(UIButton *)button{

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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
