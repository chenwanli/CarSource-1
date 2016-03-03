//
//  WithdrawalView.m
//  CarSource
//
//  Created by apple on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "WithdrawalView.h"
#import "BankCardView.h"

@interface WithdrawalView ()<UITextFieldDelegate>{

    UILabel *_bankLabel;
    UITextField *_amountField;
    UIImageView *_bankImage;
    UIButton *_payButton;

}
@property (nonatomic,strong)BankCardView *bankView;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)NSMutableArray *array;
@end
@implementation WithdrawalView
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

    UIImageView *bgIamge = [[UIImageView alloc]init];
    bgIamge.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgIamge];

    UIImageView *backIamge = [[UIImageView alloc]init];
    backIamge.backgroundColor = [UIColor whiteColor];
    [self addSubview:backIamge];

    UILabel *cardLabel = [[UILabel alloc]init];
    cardLabel.textColor = [UIColor grayColor];
    cardLabel.font = [UIFont systemFontOfSize:16];
    cardLabel.text = @"银行卡";
    [self addSubview:cardLabel];

    _bankLabel = [[UILabel alloc]init];
    _bankLabel.textColor = [UIColor grayColor];
    _bankLabel.font = [UIFont systemFontOfSize:16];
//    _bankLabel.text = @"选择银行卡";
    [self addSubview:_bankLabel];

    _bankImage = [[UIImageView alloc]init];
    _bankImage.image = [UIImage imageNamed:@"sheep"];
    [self addSubview:_bankImage];

    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_payButton addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_payButton];

    UILabel *detailedLabel = [[UILabel alloc]init];
    detailedLabel.textColor = [UIColor lightGrayColor];
    detailedLabel.font = [UIFont systemFontOfSize:14];
    detailedLabel.text = @"单日交易限额¥5000.00";
    [self addSubview:detailedLabel];

    UILabel *amountLabel = [[UILabel alloc]init];
    amountLabel.textColor = [UIColor grayColor];
    amountLabel.font = [UIFont systemFontOfSize:16];
    amountLabel.text = @"金额（元）";
    [self addSubview:amountLabel];

    _amountField = [[UITextField alloc]init];
    _amountField.font = [UIFont systemFontOfSize:15];
    _amountField.delegate = self;
    _amountField.textColor = [UIColor grayColor];
    [_amountField setReturnKeyType : UIReturnKeyDone ];
    _amountField.clearButtonMode = UITextFieldViewModeAlways;
    _amountField.keyboardType = UIKeyboardTypeDecimalPad;
    [self addSubview:_amountField];

    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.text = @"到账时间正常为3个工作日";
    [self addSubview:timeLabel];


    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"确定提现" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(30,230, SCREEN_WIDTH - 60, 50);
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitButton];


    [bgIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@60);
    }];

    [backIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@70);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@60);
    }];


    [cardLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(50, 40));

    }];
    [detailedLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.top.equalTo(@35);
        make.size.equalTo(CGSizeMake(200, 20));

    }];

    [amountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@80);
        make.size.equalTo(CGSizeMake(90, 40));

    }];
    [_amountField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.top.equalTo(@80);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@40);
    }];

    [timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@130);
        make.size.equalTo(CGSizeMake(200, 40));

    }];

}
- (void)bankViewHeight:(NSInteger)height{
    [_bankView removeFromSuperview];
    [_bgView removeFromSuperview];

    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0.5;
    [self addSubview:_bgView];

    _bankView = [[BankCardView alloc]initWithFrame:CGRectMake(30, 90, SCREEN_WIDTH-60, height)];
    _bankView.layer.cornerRadius = 5;
    _bankView.layer.masksToBounds = YES;
    [self addSubview:_bankView];

    __weak WithdrawalView *topup = self;
    _bankView.deleteBtn = ^(NSString *deleteBtn){
        [topup.bankView removeFromSuperview];
        [topup.bgView removeFromSuperview];

    };

    _bankView.indexRow = ^(NSInteger indexRow){
        [topup.bankView removeFromSuperview];
        [topup.bgView removeFromSuperview];
        [topup initPromptSizeWidthText:[ topup.array objectAtIndex:indexRow]];
        
    };
    
    
}

- (void)payButtonClick{


    if (_array.count*44 + 100 < 5*44 + 100) {
        [self bankViewHeight:_array.count*44 + 100];


    }else{
        [self bankViewHeight:5*44 + 100];


    }
    [_bankView initBankCardViewArray:_array];


}
- (void)initWithdrawalViewArray:(NSMutableArray *)array{
    _array = [[NSMutableArray alloc]initWithObjects:@"农业银行储蓄卡（8989）",@"邮政银行储蓄卡（8989）",@"中国农业银行",@"中国人民银行",@"招商银行储蓄卡（8989）",@"民生银行",@"建设银行",nil];
    _amountField.placeholder = @"当前零钱余额为888.00元";
    [self initPromptSizeWidthText:@"农业银行储蓄卡（8989）"];
}
- (void)initPromptSizeWidthText:(NSString *)text{

    CGSize promptSize = STRING_SIZE_FONT(SCREEN_WIDTH-110, text, 16);
    _bankLabel.text = text;

    _bankLabel.frame = CGRectMake(70, 5, promptSize.width +10, 30);
    _bankImage.frame = CGRectMake(promptSize.width +70, 15, 16, 12);
    _payButton.frame = CGRectMake(promptSize.width +50, 0, 60, 50);


}

- (void)submitButtonClick:(UIButton *)button{

    self.submit(nil);

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
