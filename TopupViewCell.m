//
//  TopupViewCell.m
//  CarSource
//
//  Created by apple on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "TopupViewCell.h"
@interface TopupViewCell ()<UITextFieldDelegate>{
    UIButton *_button;
}

@end

@implementation TopupViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self awakeFromNib];

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];

    int totalloc=3;
    CGFloat appvieww=(SCREEN_WIDTH- 30)/3-5;
    CGFloat appviewh= 40;
    CGFloat margin=((SCREEN_WIDTH- 30) -totalloc*appvieww)/(totalloc+1);
    NSArray *amountArray = [[NSArray alloc]initWithObjects:@"20元",@"50元",@"100元",@"200元",@"500元",@"1",nil];

    for (int i = 0; i < amountArray.count; i++) {

        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        CGFloat appviewx=margin+(margin+appvieww)*loc;
        CGFloat appviewy=margin+(margin+appviewh)*row;

        if (i < amountArray.count-1 ) {
            UIButton *amountButton = [UIButton buttonWithType:UIButtonTypeCustom];
            amountButton.frame = CGRectMake(appviewx +20, appviewy + 20, (SCREEN_WIDTH - 46)/3 - 10, 30);
            [amountButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [amountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [amountButton setTitle:[NSString stringWithFormat:@"%@",[amountArray objectAtIndex:i]] forState:UIControlStateNormal];
            amountButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [amountButton setBackgroundImage:[UIImage imageNamed:@"obvious"] forState:UIControlStateSelected];
            [amountButton setBackgroundImage:[UIImage imageNamed:@"Reports"] forState:UIControlStateNormal];

            [amountButton addTarget:self action:@selector(amountButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            amountButton.tag = i +1;
            [self addSubview:amountButton];


        }else{
            UITextField *amountField = [[UITextField alloc]initWithFrame:CGRectMake(appviewx +20, appviewy + 20, (SCREEN_WIDTH - 46)/3 - 10, 30)];
            amountField.font = [UIFont systemFontOfSize:14];
            amountField.delegate = self;
            amountField.tag = 100;
            amountField.layer.borderColor = COLOR.CGColor;
            amountField.layer.borderWidth = 1.0;
            amountField.backgroundColor = [UIColor whiteColor];
            amountField.textAlignment = NSTextAlignmentCenter;
            amountField.textColor = [UIColor grayColor];
            [amountField setReturnKeyType : UIReturnKeyDone ];
            amountField.keyboardType = UIKeyboardTypeDecimalPad;
            amountField.borderStyle = UITextBorderStyleLine;
            amountField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"其他金额" attributes:@{NSForegroundColorAttributeName:COLOR} ];
            [self addSubview:amountField];

        }
        

    }

}
- (void)amountButtonClick:(UIButton *)button{

    _button.selected = NO;
    button.selected = YES;
    _button = button;
    [self endEditing:YES];

    UITextField *textField = (UITextField *)[self viewWithTag:100];
    textField.text = @"";

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    for (int i = 1; i < 6; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i];
        btn.selected = NO;
    }
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
