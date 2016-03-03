//
//  DetailsHeaderView.m
//  CarSource
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DetailsHeaderView.h"
@interface DetailsHeaderView ()<UITextFieldDelegate>{
    UIButton *_typeButton;
}

@end

@implementation DetailsHeaderView
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

    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.text = @"选择对象";
    textLabel.textColor = [UIColor grayColor];
    textLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:textLabel];

    _typeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_typeButton setTitle:@"我的好友" forState:UIControlStateNormal];
    _typeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_typeButton setTitleColor:COLOR forState:UIControlStateNormal];
    [_typeButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_typeButton];

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"milled"];
    [self addSubview:imageView];

    UITextField *textField = [[UITextField alloc]init];
    textField.font = [UIFont systemFontOfSize:14];
    textField.placeholder = @"请输入担保对象账号";
    textField.delegate = self;
    textField.layer.borderColor = [UIColor colorWithRed:95/255.0 green:198/255.0 blue:248/255.0 alpha:1].CGColor;
    textField.layer.cornerRadius = 5;
    textField.layer.masksToBounds = YES;
    textField.layer.borderWidth = 1.0;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textColor = [UIColor grayColor];
    [textField setReturnKeyType : UIReturnKeyDone ];
    textField.clearButtonMode = UITextFieldViewModeAlways;

    [self addSubview:textField];

    UIButton *determineBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [determineBtn setTitle:@"确定" forState:UIControlStateNormal];
    determineBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    determineBtn.layer.cornerRadius = 5;
    determineBtn.layer.masksToBounds = YES;
    determineBtn.backgroundColor = COLOR;
    [determineBtn addTarget:self action:@selector(determineButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:determineBtn];


    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44, SCREEN_WIDTH-20, 1)];
    image.backgroundColor = LIGHTBLUE;
    [self addSubview:image];


    UIImageView *grayImage = [[UIImageView alloc]init];
    grayImage.backgroundColor = GRAY;
    [self addSubview:grayImage];


    [textLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.size.equalTo(CGSizeMake(70, 44));
    }];


    [_typeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(80);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@44);
    }];

    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@12);
        make.size.equalTo(CGSizeMake(15, 18));
    }];

    [textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(@51);
        make.right.equalTo(self).offset(-70);
        make.height.equalTo(@30);
    }];

    [determineBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@51);
        make.right.equalTo(self).offset(-10);
        make.size.equalTo(CGSizeMake(50, 30));
    }];

    [grayImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@10);
    }];




}
- (void)determineButtonClick:(UIButton *)button{

    [self endEditing:YES];


}
- (void)typeButtonClick:(UIButton *)button{

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
