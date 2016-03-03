//
//  SetUpView.m
//  CarSource
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SetUpView.h"

@implementation SetUpView
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

//    UIView *bgView = [[UIView alloc]init];
//    bgView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:bgView];
//
//
//    UIImageView *topImage = [[UIImageView alloc]init];
//
//    topImage.backgroundColor = [UIColor colorWithRed:215/255.0 green:234/255.0 blue:255/255.0 alpha:1];
//    [self addSubview:topImage];
//
//
//    UILabel *serviceLabel = [[UILabel alloc]init];
//    serviceLabel.text = @"联系客服";
//    serviceLabel.textColor = [UIColor grayColor];
//    serviceLabel.font = [UIFont systemFontOfSize:18];
//    [self addSubview:serviceLabel];
//
//
//    UIImageView *lineImage = [[UIImageView alloc]init];
//
//    lineImage.backgroundColor = [UIColor colorWithRed:215/255.0 green:234/255.0 blue:255/255.0 alpha:1];
//    [self addSubview:lineImage];
//
//    for (int i = 0; i< 3; i++) {
//        UIView *bgImage = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 20)/3 *i+10, 60, (SCREEN_WIDTH - 20)/3-10, 80)];
//        bgImage.backgroundColor = [UIColor colorWithRed:241/255.0 green:251/255.0 blue:255/255.0 alpha:1];
//        [self addSubview:bgImage];
//
//       UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        userButton.frame = CGRectMake(10, 10, 40, 40);
//        userButton.layer.cornerRadius = 20;
//        userButton.layer.masksToBounds = YES;
//        [userButton setBackgroundImage:[UIImage  imageNamed:@"ww.jpg"] forState:UIControlStateNormal];
//        [bgImage addSubview:userButton];
//
//        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, bgImage.frame.size.width -40, 30)];
//        nameLabel.textAlignment = NSTextAlignmentCenter;
//        nameLabel.numberOfLines = 0;
//        nameLabel.text = @"爱美丽";
//        nameLabel.textColor = [UIColor grayColor];
//        nameLabel.font = [UIFont systemFontOfSize:14];
//        [bgImage addSubview:nameLabel];
//
//        UIButton *informationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        informationBtn.frame = CGRectMake(bgImage.frame.size.width -40, 10, 40, 35);
//
//        [informationBtn setBackgroundImage:[UIImage  imageNamed:@"park"] forState:UIControlStateNormal];
//        [bgImage addSubview:informationBtn];
//
//        UIButton *telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        telBtn.frame = CGRectMake(bgImage.frame.size.width -35, 50, 25, 25);
//
//        [telBtn setBackgroundImage:[UIImage  imageNamed:@"phone"] forState:UIControlStateNormal];
//        [bgImage addSubview:telBtn];
//
//    }

    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(30, 30, SCREEN_WIDTH-60, 50);
    [submitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:20];
    submitButton.backgroundColor = COLOR;
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitButton];


//    [topImage makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(0);
//        make.top.equalTo(@10);
//        make.right.equalTo(self).offset(@0);
//        make.height.equalTo(@1);
//    }];
//    [bgView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@0);
//        make.top.equalTo(@10);
//        make.right.equalTo(self).offset(@0);
//        make.height.equalTo(@140);
//    }];
//
//    [serviceLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@10);
//        make.top.equalTo(@10);
//        make.size.equalTo(CGSizeMake(150, 40));
//    }];
//
//    [lineImage makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(0);
//        make.top.equalTo(@50);
//        make.right.equalTo(self).offset(@0);
//        make.height.equalTo(@1);
//    }];


}
- (void)submitButtonClick{

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
