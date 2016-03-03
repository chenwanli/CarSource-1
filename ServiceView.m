//
//  ServiceView.m
//  CarSource
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ServiceView.h"
@interface ServiceView ()<UITextFieldDelegate>{

    UIButton *_btn;
    NSString *_bankAccountNumber;//银行账户 号码
    NSString *_bankAccountName;//银行卡开户人姓名姓名
    NSString *_bankAccountText;//开户银行
}

@end

@implementation ServiceView
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

//    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 17, 16, 16)];
//    numberLabel.layer.cornerRadius = 8;
//    numberLabel.layer.masksToBounds = YES;
//    numberLabel.textAlignment = NSTextAlignmentCenter;
//    numberLabel.textColor = [UIColor whiteColor];
//    numberLabel.font = [UIFont systemFontOfSize:13];
//    numberLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
//    numberLabel.text = @"3";
//    [self addSubview:numberLabel];

    UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 30)];
    typeLabel.textColor = BLACK;
    typeLabel.font = [UIFont systemFontOfSize:16];
    typeLabel.text = @"公司账户";
    [self addSubview:typeLabel];

    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH -20, 1)];
    lineImage.backgroundColor = GRAY;
    [self addSubview:lineImage];

    UIImageView *addImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 40,17, 18, 18)];
    addImage.image = [UIImage imageNamed:@"ten"];
    [self addSubview:addImage];

    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCREEN_WIDTH - 60,10, 50, 50);
    [addBtn addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];

    NSArray *typeArray = @[@"开户名称",@"开户银行",@"开户账号"];
    NSArray *textArray = @[@"请输入开户名称",@"请输入开户银行",@"请输入开户账号"];
    for (int j = 0; j < typeArray.count; j++) {
        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 44 *j +60, 81, 45)];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.textColor = BLACK;
        typeLabel.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
        typeLabel.layer.borderWidth = 1.0;
        typeLabel.font = [UIFont systemFontOfSize:15];
        typeLabel.text = [typeArray objectAtIndex:j];
        [self addSubview:typeLabel];

        UITextField *bankText = [[UITextField alloc]initWithFrame:CGRectMake(90, 44 *j +60, SCREEN_WIDTH -100, 45)];
        bankText.font = [UIFont systemFontOfSize:14];
        bankText.placeholder = [textArray objectAtIndex:j];
        bankText.delegate = self;
        bankText.textAlignment = NSTextAlignmentCenter;
        bankText.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
        bankText.layer.borderWidth = 1.0;
        bankText.tag = j +1;
        bankText.borderStyle = UITextBorderStyleNone;
        bankText.textColor = [UIColor grayColor];
        [bankText setReturnKeyType : UIReturnKeyDone ];
        bankText.clearButtonMode = UITextFieldViewModeAlways;
        [self addSubview:bankText];

        if ( j == 2) {
            bankText.keyboardType = UIKeyboardTypeNumberPad;
        }
    }
}

- (void)addButtonClick:(UIButton *)button{

    [self endEditing:YES];

    if ([_bankAccountName isEqualToString:@""] || _bankAccountName == nil) {
        SHOW_ALERT(@"请您填写开户名称")
        return;
    }

    if ([_bankAccountText isEqualToString:@""] || _bankAccountText == nil) {
        SHOW_ALERT(@"请您填写开户银行")
        return;
    }

    if ([_bankAccountNumber isEqualToString:@""] || _bankAccountNumber == nil) {
        SHOW_ALERT(@"请您填写开户账号")
        return;
    }
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [LCCoolHUD showLoading:@"正在添加" inView:self];

     [RequestClass postEnterpriseBankCardRequestWithUserId:login.userId bankAccountNumber:_bankAccountNumber bankAccountName:_bankAccountName bankAccountText:_bankAccountText Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {

         [LCCoolHUD hideInView:self];
         if ([errorMessage isEqualToString:@"0"]) {
             [LCCoolHUD showSuccess:@"添加成功" zoom:YES shadow:YES];
             self.service(_bankAccountName,_bankAccountText,_bankAccountNumber);
         }

     }];


}
- (void)textFieldDidEndEditing:(UITextField *)textField{

    switch (textField.tag) {
        case 1:
        {
            _bankAccountName = textField.text;
        }
            break;
        case 2:
        {
            _bankAccountText = textField.text;
        }
            break;
        case 3:
        {
            _bankAccountNumber = textField.text;
        }
            break;

        default:
            break;
    }

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
