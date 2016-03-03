//
//  WalletView.m
//  CarSource
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "WalletView.h"
@interface WalletView ()<UIScrollViewDelegate>{
    UILabel *_changeLabel;
}

@end
@implementation WalletView
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

    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    //    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];

    UIImageView *bgImage = [[UIImageView alloc]init];
    bgImage.backgroundColor = [UIColor colorWithRed:224/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    [self addSubview:bgImage];

    UIImageView *walletImage = [[UIImageView alloc]init];
    walletImage.image = [UIImage imageNamed:@"flat"];
    [self addSubview:walletImage];

    UILabel *changeLabel = [[UILabel alloc]init];
    changeLabel.textAlignment = NSTextAlignmentCenter;
    changeLabel.textColor = [UIColor grayColor];
    changeLabel.font = [UIFont systemFontOfSize:16];
    changeLabel.text = @"我的零钱";
    [self addSubview:changeLabel];

    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    _changeLabel = [[UILabel alloc]init];
    _changeLabel.textAlignment = NSTextAlignmentCenter;
    _changeLabel.textColor = [UIColor grayColor];
    _changeLabel.font = [UIFont systemFontOfSize:20];
    _changeLabel.text = [NSString stringWithFormat:@"%@",login.userMoney];
    [self addSubview:_changeLabel];

    int totalloc = 2;
    CGFloat appvieww=(SCREEN_WIDTH)/2;
    CGFloat appviewh=110;
    CGFloat margin=((SCREEN_WIDTH) -totalloc*appvieww)/(totalloc+1);
//    NSArray *arr = [[NSArray alloc]initWithObjects:@"充值",@"提现",@"绑卡",@"展厅推广", nil];

     NSArray *arr = [[NSArray alloc]initWithObjects:@"充值",@"提现", nil];
    for (int i = 0; i < arr.count; i++) {

        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        CGFloat appviewx=margin+(margin+appvieww)*loc;
        CGFloat appviewy=margin+(margin+appviewh)*row;

        UIView  *bgView = [[UIView alloc]initWithFrame:CGRectMake(appviewx, appviewy +140, (SCREEN_WIDTH)/2, 110)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
        bgView.layer.borderWidth = 1.0;
        [self addSubview:bgView];

        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageButton.frame = CGRectMake(bgView.frame.size.width/2-25, 15, 50, 50);
        [imageButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"TV%d",i +1]] forState:UIControlStateNormal];
        [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.tag = i +1 ;
        [bgView addSubview:imageButton];

        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, bgView.frame.size.width, 30)];
        textLabel.textColor = [UIColor grayColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
//        textLabel.backgroundColor =[UIColor colorWithRed:224/255.0 green:241/255.0 blue:254/255.0 alpha:1];
        textLabel.font = [UIFont systemFontOfSize:18];
        textLabel.text = [arr objectAtIndex:i];
        [bgView addSubview:textLabel];


    }

    UILabel *passwordLabel = [[UILabel alloc]init];
    passwordLabel.textColor = [UIColor grayColor];
    passwordLabel.backgroundColor =[UIColor colorWithRed:224/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    passwordLabel.font = [UIFont systemFontOfSize:16];
    passwordLabel.text = @"  设置密码";
    [self addSubview:passwordLabel];

    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [setButton addTarget:self action:@selector(setButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:setButton];

    UIImageView *passwordImage = [[UIImageView alloc]init];
    passwordImage.image = [UIImage imageNamed:@"milled"];
    [self addSubview:passwordImage];

    [bgImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@140);
    }];
    [walletImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2-25);
        make.top.equalTo(@20);
        make.size.equalTo(CGSizeMake(50, 50));
    }];

    [changeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@120);
        make.top.equalTo(@70);
        make.right.equalTo(self).offset(-120);
        make.height.equalTo(@30);
    }];

    [_changeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@90);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@40);
    }];

    [passwordLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@260);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@44);
    }];


    [setButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@260);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@44);
    }];

    [passwordImage makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(@270);
        make.size.equalTo(CGSizeMake(15, 20));
    }];

}

- (void)imageButtonClick:(UIButton *)button{

    self.wallet(button.tag);

}
- (void)setButtonClick:(UIButton *)button{
    self.set(nil);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
