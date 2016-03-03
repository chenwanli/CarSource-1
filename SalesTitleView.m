//
//  SalesTitleView.m
//  CarSource
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SalesTitleView.h"
@interface SalesTitleView ()<UITextFieldDelegate>{

    UIButton *_btn;
    UITextField *_textField;
    
}

@end
@implementation SalesTitleView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    self.backgroundColor = GRAY;

    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 30)];
    _textField.font = [UIFont systemFontOfSize:14];
    UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"did"]];
    _textField.leftView = imgv;
    _textField.delegate = self;
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.textColor = [UIColor grayColor];
    _textField.placeholder = @"输入你要查找的车型、车号、价格";
    _textField.backgroundColor = [UIColor whiteColor];
    [_textField setReturnKeyType : UIReturnKeySearch ];
    //    textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"输入你要找的车型、车号、价格" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} ];
    _textField.clearButtonMode = UITextFieldViewModeAlways;

    [self addSubview:_textField];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);

    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];

    NSArray *arr = [[NSArray alloc]initWithObjects:@"选择品牌",@"会员类型",@"所在区域", nil];

    for (int i = 0; i < arr.count; i++) {
        UIButton *brandButton = [UIButton buttonWithType:UIButtonTypeCustom];
        brandButton.frame = CGRectMake(SCREEN_WIDTH/3*i, 50, SCREEN_WIDTH/3, 40);
        [brandButton setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        brandButton.backgroundColor = [UIColor whiteColor];
        [brandButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        brandButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [brandButton setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateSelected];
        brandButton.tag = 10 +i;
        [brandButton addTarget:self action:@selector(brandButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:brandButton];

        if (i != 0) {
            UIImageView *image  = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*i, 52, 1, 36)];
            image.backgroundColor = [UIColor colorWithRed:175/255.0 green:198/255.0 blue:225/255.0 alpha:1];
            [self addSubview:image];
        }

    }
    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 89, SCREEN_WIDTH, 1)];
    lineImage.backgroundColor = LIGHTBLUE;
    [self addSubview:lineImage];
}
- (void)initText:(NSString *)text{
    _textField.text = text;
}
- (void)provincesStr:(NSString *)provincesStr{
    UIButton *provincesBtn = (UIButton *)[self viewWithTag:12];
    [provincesBtn setTitle:provincesStr forState:UIControlStateNormal];

}

- (void)memberTypeStr:(NSString *)memberTypeStr{
    UIButton *provincesBtn = (UIButton *)[self viewWithTag:11];
    [provincesBtn setTitle:memberTypeStr forState:UIControlStateNormal];

}
- (void)vehicleStr:(NSString *)vehicleStr{
    UIButton *provincesBtn = (UIButton *)[self viewWithTag:10];
    [provincesBtn setTitle:vehicleStr forState:UIControlStateNormal];

}



- (void)brandButtonClick:(UIButton *)button{
    _btn.selected = NO;
    button.selected = YES;
    _btn = button;

    self.brandBtn(button.tag);

}
//搜索
- (void)buttonClick{
    self.search(nil);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
