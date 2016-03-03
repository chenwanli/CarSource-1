//
//  MemberView.m
//  CarSource
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MemberView.h"

@interface MemberView ()<UITextFieldDelegate,UIScrollViewDelegate>{
    UIImageView *_forImage;
    UIScrollView *_scroll;
    NSString *_type;
    UIButton *_btn;
}
@end
@implementation MemberView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{


    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scroll.delegate = self;
    _scroll.bounces = NO;
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH, 770);
    _scroll.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scroll];

    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 770)];
    bgImage.image = [UIImage imageNamed:@"login_bg.jpg"];
    [_scroll addSubview:bgImage];

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 15, SCREEN_WIDTH-140, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"会员类型";
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:20];
    [_scroll addSubview:titleLabel];

    UIImageView *returnImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 15, 18)];
    returnImage.image = [UIImage imageNamed:@"return"];
    [_scroll addSubview:returnImage];
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 0, 60, 64);
    [returnBtn addTarget:self action:@selector(returnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:returnBtn];

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 70, 100, 140, 60)];
    imageView.image = [UIImage imageNamed:@"source"];
    [_scroll addSubview:imageView];

    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 190, SCREEN_WIDTH-60, 40)];
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.text = @"提示：请选择您的职业的会员类型，一经选择不能更改";
    promptLabel.numberOfLines = 0;
    promptLabel.font = [UIFont systemFontOfSize:15];
    [_scroll addSubview:promptLabel];

    NSArray *array = [[NSArray alloc]initWithObjects:@"个人",@"展厅",@"港口",@"资源",@"4S店",@"物流拖车", nil];

    NSArray *arr = [[NSArray alloc]initWithObjects:@"",@"（汽贸-名车店 二级经销商）",@"（贸易公司）",@"",@"(汽车集团)",@"", nil];

    for (int i = 0; i < array.count; i++) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(30,60 *i +230, SCREEN_WIDTH - 60, 50)];
        bgView.layer.cornerRadius = 5;
        bgView.layer.masksToBounds = YES;
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.alpha = 0.3;
        [_scroll addSubview:bgView];


        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[array objectAtIndex:i]forState:UIControlStateNormal];
        button.frame = CGRectMake(30,60 *i +230, SCREEN_WIDTH - 60, 50);
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        [button setBackgroundImage:[UIImage imageNamed:@"obvious"] forState:UIControlStateSelected];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.tag = i +2;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scroll addSubview:button];

        if (i == 1 || i == 2 || i == 4) {
            UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH -30)/2+40, 60 *i + 240, (SCREEN_WIDTH -30)/2 -40, 30)];
            textLabel.textAlignment = NSTextAlignmentLeft;
            textLabel.textColor = [UIColor whiteColor];
            textLabel.text = [arr objectAtIndex:i];
            textLabel.numberOfLines = 0;
            textLabel.font = [UIFont systemFontOfSize:10];
            [_scroll addSubview:textLabel];

        }

    }

    UIImageView *submitImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 620, SCREEN_WIDTH-60, 50)];
    submitImage.backgroundColor = COLOR;
    submitImage.layer.cornerRadius = 5;
    submitImage.layer.masksToBounds = YES;
    submitImage.alpha = 0.4;
    [_scroll addSubview:submitImage];

    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(30, 620, SCREEN_WIDTH-60, 50);
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
    //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    //    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:submitButton];

}
- (void)submitButtonClick{

    if (_type == nil ||[_type isEqualToString:@""]) {
        SHOW_ALERT(@"请选择会员类型")
        return;
    }
    self.submit(_type);

}
- (void)buttonClick:(UIButton *)button{
    _btn.selected = NO;
    button.selected = YES;
    _btn = button;

    _type = [NSString stringWithFormat:@"%ld",button.tag];
    NSLog(@" --- %@",_type);

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
