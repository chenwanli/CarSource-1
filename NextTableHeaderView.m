//
//  NextTableHeaderView.m
//  CarSource
//
//  Created by apple on 15/12/26.
//  Copyright © 2015年 apple. All rights reserved.
//
//个人中心表头
#import "NextTableHeaderView.h"


@interface NextTableHeaderView ()<UITextFieldDelegate>{

    UIButton *_btn;
    UILabel *_nameLabel;
    UITextField *_companyField;
    UITextField *_detailedAddress;
}

@end

@implementation NextTableHeaderView
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
    NSArray *arr = @[@"会员类型",@"公司名称",@"所在地址"];

    for (int i = 0; i<arr.count; i++) {
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 44 *i +14, 16, 16)];
        numberLabel.layer.cornerRadius = 8;
        numberLabel.layer.masksToBounds = YES;
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.font = [UIFont systemFontOfSize:13];
        numberLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
        numberLabel.text = [NSString stringWithFormat:@"%d",i+1];
        [self addSubview:numberLabel];
        
        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(36, 44 *i +7, 60, 30)];
        typeLabel.textColor = [UIColor grayColor];
        typeLabel.font = [UIFont systemFontOfSize:15];
        typeLabel.text = [arr objectAtIndex:i];
        [self addSubview:typeLabel];

        UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44*i +43, SCREEN_WIDTH -20, 1)];

        lineImage.backgroundColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1];
        [self addSubview:lineImage];

    }

    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 7, SCREEN_WIDTH - 120, 30)];
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.text = @"拖车";
    [self addSubview:_nameLabel];

    _companyField = [[UITextField alloc]initWithFrame:CGRectMake(110, 51, SCREEN_WIDTH - 120, 30)];
    _companyField.font = [UIFont systemFontOfSize:14];
    _companyField.placeholder = @"请填写所在公司名称";
    _companyField.delegate = self;
    _companyField.textColor = [UIColor grayColor];
    [_companyField setReturnKeyType : UIReturnKeyDone ];
    _companyField.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:_companyField];

    UIImageView *companyImage = [[UIImageView alloc]initWithFrame:CGRectMake(110, 81, SCREEN_WIDTH -120, 1)];
    companyImage.backgroundColor = [UIColor colorWithRed:209/255.0 green:211/255.0 blue:211/255.0 alpha:1];
    [self addSubview:companyImage];

    UIButton *areaButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    areaButton.frame = CGRectMake(110, 95, SCREEN_WIDTH -120, 30);
    [areaButton setTitle:@"区域" forState:UIControlStateNormal];
    areaButton.titleLabel.font = [UIFont systemFontOfSize:14];
    areaButton.backgroundColor = [UIColor colorWithRed:224/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    [areaButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    [areaButton addTarget:self action:@selector(areaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:areaButton];

    _detailedAddress = [[UITextField alloc]initWithFrame:CGRectMake(36, 135, SCREEN_WIDTH - 46, 30)];
    _detailedAddress.font = [UIFont systemFontOfSize:14];
    _detailedAddress.placeholder = @"补充您的详细地址";
    _detailedAddress.delegate = self;
    _detailedAddress.textColor = [UIColor grayColor];
    [_detailedAddress setReturnKeyType : UIReturnKeyDone ];
    _detailedAddress.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:_detailedAddress];

    UIImageView *detailedImage = [[UIImageView alloc]initWithFrame:CGRectMake(36, 165, SCREEN_WIDTH -46, 1)];
    detailedImage.backgroundColor = [UIColor colorWithRed:209/255.0 green:211/255.0 blue:211/255.0 alpha:1];
    [self addSubview:detailedImage];

    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44*3 +43, SCREEN_WIDTH -20, 1)];

    lineImage.backgroundColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1];
    [self addSubview:lineImage];


}
- (void)areaButtonClick:(UIButton *)button{

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
