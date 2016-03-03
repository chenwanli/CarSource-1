//
//  TradingView.m
//  CarSource
//
//  Created by apple on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TradingView.h"

@interface TradingView (){

}

@end

@implementation TradingView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    UIButton *depositButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [depositButton setTitle:@"发起定金担保" forState:UIControlStateNormal];
    depositButton.titleLabel.font = [UIFont systemFontOfSize:16];
    depositButton.layer.cornerRadius = 5;
    depositButton.layer.masksToBounds = YES;
    //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    depositButton.backgroundColor = COLOR;
    [depositButton addTarget:self action:@selector(depositButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:depositButton];

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"there"];
    [self addSubview:imageView];

    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.textColor = [UIColor lightGrayColor];
    textLabel.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    textLabel.layer.borderWidth = 1.0;
    textLabel.backgroundColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.text = @"  确保资金安全，提高交易效率";
    [self addSubview:textLabel];

    UIImageView *milledImage = [[UIImageView alloc]init];
    milledImage.image = [UIImage imageNamed:@"milled"];
    [self addSubview:milledImage];

    UIButton *detailedBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailedBtn setTitle:@"查看详细" forState:UIControlStateNormal];
    detailedBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [detailedBtn setTitleColor:COLOR forState:UIControlStateNormal];
    [detailedBtn addTarget:self action:@selector(detailedButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:detailedBtn];

    UILabel *recentlyLabel = [[UILabel alloc]init];
    recentlyLabel.textColor = [UIColor grayColor];
    recentlyLabel.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    recentlyLabel.layer.borderWidth = 1.0;
    recentlyLabel.backgroundColor = [UIColor whiteColor];
    recentlyLabel.font = [UIFont systemFontOfSize:16];
    recentlyLabel.text = @"  最近交易";
    [self addSubview:recentlyLabel];



    [depositButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.top.equalTo(@20);
        make.right.equalTo(self).offset(- 50);
        make.height.equalTo(@50);
    }];

    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@90);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@100);
    }];

    [textLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@200);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@50);
    }];

    [milledImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@215);
        make.right.equalTo(self).offset(- 10);
        make.size.equalTo(CGSizeMake(15, 18));
    }];

    [detailedBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@200);
        make.right.equalTo(self).offset(- 30);
        make.size.equalTo(CGSizeMake(70, 50));
    }];

    [recentlyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@260);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@50);
    }];

}
- (void)detailedButtonClick{

    self.detailed(nil);

}
- (void)depositButtonClick{

    self.depositBtn(nil);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
