//
//  BankAccountView.m
//  CarSource
//
//  Created by apple on 15/12/26.
//  Copyright © 2015年 apple. All rights reserved.
//
// 个人中心区头 添加银行账号
#import "BankAccountView.h"

@implementation BankAccountView
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
    NSArray *arr = @[@"服务性质",@"银行账号"];
    NSArray *banKArray = @[@"小板车",@"大板车"];

    for (int i = 0; i<arr.count; i++) {
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 44 *i +14, 16, 16)];
        numberLabel.layer.cornerRadius = 8;
        numberLabel.layer.masksToBounds = YES;
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = [UIColor whiteColor];

        numberLabel.font = [UIFont systemFontOfSize:13];
        numberLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
        numberLabel.text = [NSString stringWithFormat:@"%d",i+6];
        [self addSubview:numberLabel];

        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(36, 44 *i +7, 60, 30)];
        typeLabel.textColor = [UIColor grayColor];
        typeLabel.font = [UIFont systemFontOfSize:15];
        typeLabel.text = [arr objectAtIndex:i];
        [self addSubview:typeLabel];

        UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44*i +43, SCREEN_WIDTH -20, 1)];

        lineImage.backgroundColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1];
        [self addSubview:lineImage];

        UIButton *carButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        carButton.frame = CGRectMake(60 *i + SCREEN_WIDTH - 130, 7, 50, 30);
        [carButton setTitle:[banKArray objectAtIndex:i] forState:UIControlStateNormal];
        carButton.layer.cornerRadius = 5;
        carButton.layer.masksToBounds = YES;
        carButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [carButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [carButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

        [carButton setBackgroundImage:[UIImage imageNamed:@"obvious"] forState:UIControlStateSelected];

        [carButton setBackgroundImage:[UIImage imageNamed:@"Reports"] forState:UIControlStateNormal];

        [carButton addTarget:self action:@selector(carButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:carButton];

    }

    UIButton *addButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [addButton setTitleColor:COLOR forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];

    [addButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(@44);
        make.size.equalTo(CGSizeMake(60, 44));
    }];

    NSArray *typeArray = @[@"开户名称",@"开户银行",@"开户账号"];
    NSArray *textArray = @[@"请输入开户名称",@"请输入开户银行",@"请输入开户账号"];
    for (int j = 0; j < typeArray.count; j++) {
        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 44 *j +98, 80, 44)];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.textColor = [UIColor grayColor];
        typeLabel.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
        typeLabel.layer.borderWidth = 1.0;
        typeLabel.font = [UIFont systemFontOfSize:15];
        typeLabel.text = [typeArray objectAtIndex:j];
        [self addSubview:typeLabel];

        UITextField *bankText = [[UITextField alloc]initWithFrame:CGRectMake(90, 44 *j +98, SCREEN_WIDTH -100, 44)];
        bankText.font = [UIFont systemFontOfSize:14];
        bankText.placeholder = [textArray objectAtIndex:j];
        bankText.delegate = self;
        bankText.textAlignment = NSTextAlignmentCenter;
        bankText.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
        bankText.layer.borderWidth = 1.0;
        bankText.borderStyle = UITextBorderStyleNone;
        bankText.textColor = [UIColor grayColor];
        [bankText setReturnKeyType : UIReturnKeyDone ];
        bankText.clearButtonMode = UITextFieldViewModeAlways;
        [self addSubview:bankText];
    }



}
- (void)carButtonClick:(UIButton *)button{
    button.selected = !button.selected;

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
