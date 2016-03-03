//
//  PromoteView.m
//  CarSource
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PromoteView.h"
@interface PromoteView ()<UIScrollViewDelegate>
{
    UIButton *_btn;
}
@end
@implementation PromoteView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    UILabel *promptLabel = [[UILabel alloc]init];
    promptLabel.textColor = [UIColor grayColor];
    promptLabel.backgroundColor = LIGHTBLUE;
    promptLabel.font = [UIFont systemFontOfSize:16];
    promptLabel.text = @"  推广渠道";
    [self addSubview:promptLabel];

    UIImageView *bgIamge = [[UIImageView alloc]init];
    bgIamge.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgIamge];

    UILabel *shufflingLabel = [[UILabel alloc]init];
    shufflingLabel.textColor = [UIColor grayColor];
    shufflingLabel.font = [UIFont systemFontOfSize:16];
    shufflingLabel.textAlignment = NSTextAlignmentCenter;
    shufflingLabel.text = @"首页轮播图推广";
    [self addSubview:shufflingLabel];

    UIImageView *handIamge = [[UIImageView alloc]init];
    handIamge.image = [UIImage imageNamed:@"find"];
    [self addSubview:handIamge];

    UILabel *promoteLabel = [[UILabel alloc]init];
    promoteLabel.textColor = [UIColor grayColor];
    promoteLabel.font = [UIFont systemFontOfSize:14];
    promoteLabel.numberOfLines = 0;
    promoteLabel.text = @"海量用户点击浏览您的展厅，为你的车源交易带来质的飞跃";
    [self addSubview:promoteLabel];

    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.textColor = [UIColor grayColor];
    priceLabel.backgroundColor = LIGHTBLUE;
    priceLabel.font = [UIFont systemFontOfSize:16];
    priceLabel.text = @"  推广价格";
    [self addSubview:priceLabel];

    UIImageView *promoteIamge = [[UIImageView alloc]init];
    promoteIamge.backgroundColor = [UIColor whiteColor];
    [self addSubview:promoteIamge];

    UILabel *numberLabel = [[UILabel alloc]init];
    numberLabel.layer.cornerRadius = 8;
    numberLabel.layer.masksToBounds = YES;
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.font = [UIFont systemFontOfSize:13];
    numberLabel.backgroundColor = COLOR;
    numberLabel.text = @"1";
    [self addSubview:numberLabel];

    UILabel *timingLabel = [[UILabel alloc]init];
    timingLabel.textColor = [UIColor grayColor];
    timingLabel.font = [UIFont systemFontOfSize:16];
    timingLabel.text = @"计时推广";
    [self addSubview:timingLabel];

    UILabel *payLabel = [[UILabel alloc]init];
    payLabel.textColor = [UIColor lightGrayColor];
    payLabel.font = [UIFont systemFontOfSize:14];
    payLabel.text = @"（付费时起算）";
    [self addSubview:payLabel];

    UIImageView *lineIamge = [[UIImageView alloc]init];
    lineIamge.backgroundColor = LIGHTBLUE;
    [self addSubview:lineIamge];

    


    int totalloc=3;
    CGFloat appvieww=(SCREEN_WIDTH- 60)/3;
    CGFloat appviewh=40;
    CGFloat margin=((SCREEN_WIDTH- 60) -totalloc*appvieww)/(totalloc+1);

    NSArray *arr = [[NSArray alloc]initWithObjects:@"时间", @"价格",@"价格",@"24小时",@"240元",@"10/小时",@"3天",@"600元",@"8.3/小时",@"7天",@"840元",@"5元／小时",nil];

    for (int i = 0; i < arr.count; i++) {

        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        CGFloat appviewx=margin+(margin+appvieww)*loc;
        CGFloat appviewy=margin+(margin+appviewh)*row;

        UILabel *label = [[UILabel alloc]initWithFrame: CGRectMake(appviewx +50, appviewy +361, (SCREEN_WIDTH - 60)/3+1, 40)];
        label.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderWidth = 1.0;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.text = [arr objectAtIndex:i];
        [self addSubview:label];
    }

    for (int i = 0; i< 3; i++) {
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, 40 *i + 407 , 25, 25);
        [button setImage:[UIImage imageNamed:@"highlighted"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"for"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];

    }


    UIButton *chooseButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseButton setImage:[UIImage imageNamed:@"highlighted"] forState:UIControlStateNormal];
    [chooseButton setImage:[UIImage imageNamed:@"for"] forState:UIControlStateSelected];
    [chooseButton addTarget:self action:@selector(chooseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:chooseButton];

    UIButton *agreementBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [agreementBtn setTitle:@"展厅推广协议" forState:UIControlStateNormal];
    agreementBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    agreementBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [agreementBtn setTitleColor:[UIColor colorWithRed:205/255.0 green:109/255.0 blue:88/255.0 alpha:1]forState:UIControlStateNormal];
    [agreementBtn addTarget:self action:@selector(agreementButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:agreementBtn];


    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitButton];


    [promptLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@40);
    }];

    [bgIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@40);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@220);
    }];

    [shufflingLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(@40);
        make.right.equalTo(self).offset(-40);
        make.height.equalTo(@30);
    }];
    
    [handIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@227);
        make.size.equalTo(CGSizeMake(25, 25));
    }];

    [promoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@45);
        make.top.equalTo(@220);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@40);
    }];

    [priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@270);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@40);
    }];

    [promoteIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@310);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@220);
    }];

    [numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@322);
        make.size.equalTo(CGSizeMake(16, 16));
    }];

    [timingLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(@310);
        make.size.equalTo(CGSizeMake(70, 40));
    }];

    [payLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@100);
        make.top.equalTo(@310);
        make.size.equalTo(CGSizeMake(130, 40));
    }];

    [lineIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@345);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@1);
    }];

    [chooseButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@25);
        make.top.equalTo(@540);
        make.size.equalTo(CGSizeMake(20, 20));
    }];

    [agreementBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@55);
        make.top.equalTo(@530);
        make.size.equalTo(CGSizeMake(160, 40));
    }];


    [submitButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.bottom.equalTo(self).offset(-30);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@50);
    }];

}
- (void)initPromoteViewArray:(NSMutableArray *)array {

    for (int i = 0; i < array.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-20)/2*i +10, 75, (SCREEN_WIDTH-20)/2-10, 140)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"h%d.jpg",i+1]];
        [self addSubview:imageView];
    }



}
- (void)chooseButtonClick:(UIButton *)button{
    button.selected = !button.selected;

}
- (void)agreementButtonClick:(UIButton *)button{

}
- (void)submitButtonClick:(UIButton *)button{

}

- (void)buttonClick:(UIButton *)button{
        _btn.selected = NO;
        button.selected = YES;
        _btn = button;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
