//
//  MyProfileView.m
//  CarSource
//
//  Created by apple on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyProfileView.h"


@interface MyProfileView (){

    UIButton *_btn;
    UIImageView *_userImage;
    UILabel *_nameLabel;
    UILabel *_addressLabel;
    UIImageView *_imageView;

}

@end
@implementation MyProfileView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{


    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,login.userBackGround]] placeholderImage:[UIImage imageNamed:@"next.jpg"]];
    [self addSubview:_imageView];

    _userImage = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"ww.jpg"]];
    _userImage.layer.cornerRadius = 30;
    _userImage.layer.masksToBounds = YES;
    [_userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,login.userUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];

    [self addSubview:_userImage];

    _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _userButton.layer.cornerRadius = 30;
//    _userButton.layer.masksToBounds = YES;
//    [_userButton setBackgroundImage:[UIImage  imageNamed:@"ww.jpg"] forState:UIControlStateNormal];
    [_userButton addTarget:self action:@selector(userButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_userButton];


    UIImageView *lineImage = [[UIImageView alloc]init];
    lineImage.backgroundColor = [UIColor colorWithRed:215/255.0 green:234/255.0 blue:255/255.0 alpha:1];
    [self addSubview:lineImage];

    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.numberOfLines = 0;
    _nameLabel.text = login.userName;
    _nameLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:_nameLabel];


    _addressLabel = [[UILabel alloc]init];
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    _addressLabel.textColor = [UIColor whiteColor];
    _addressLabel.numberOfLines = 0;
    if ([login.userText isEqualToString:@""]) {
        _addressLabel.text = @"签名：说说心情";
    }else{
        _addressLabel.text = login.userText;
    }

    _addressLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_addressLabel];


    UIImageView *nextImage = [[UIImageView alloc]init];
    nextImage.image = [UIImage imageNamed:@"big"];
    nextImage.transform = CGAffineTransformMakeRotation(180*M_PI/180);
    [self addSubview:nextImage];


    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    returnBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    nextBtn.titleLabel.font = [UIFont systemFontOfSize: 18.0];
//    nextBtn.transform = CGAffineTransformMakeRotation(180*M_PI/180);
//    [nextBtn setBackgroundImage: [UIImage imageNamed:@"big"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextBtn];

    UIButton *bgButton  = [UIButton buttonWithType:UIButtonTypeCustom];
//    [loginButton setTitle:@"点击登陆" forState:UIControlStateNormal];
    bgButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [bgButton addTarget:self action:@selector(bgButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgButton];

    

    [_userImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@70);
        make.size.equalTo(CGSizeMake(60, 60));
    }];

    [_userButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@70);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.top.equalTo(@65);
        make.right.equalTo(self).offset(-40);
        make.height.equalTo(@30);
    }];
    [_addressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.top.equalTo(@90);
        make.right.equalTo(self).offset(-40);
        make.height.equalTo(@60);
    }];

    [nextImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@80);
        make.right.equalTo(self).offset(-10);
        make.size.equalTo(CGSizeMake(25, 35));
    }];

    [nextBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@50);
        make.right.equalTo(self).offset(-10);
        make.size.equalTo(CGSizeMake(60, 80));
    }];
    [lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.right.equalTo(self).offset(0);
        make.left.equalTo(@0);
        make.height.equalTo(@1);
    }];

    [bgButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(-100);
        make.height.equalTo(200);
    }];


    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 50)];
    bgView.backgroundColor = COLOR;
    bgView.alpha = 0.15;
    [self addSubview:bgView];
    NSArray *array = [[NSArray alloc]initWithObjects:@"我的车源",@"我的担保",nil];

    for (int i = 0; i < array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH/2*i, 200, SCREEN_WIDTH/2, 49);
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        button.tag = i +1;
        [button setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateSelected];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];

        if (i == 0) {
            button.selected = YES;
            _btn = button;

        }else{
            UIImageView *image  = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 *i, 203, 1, 44)];
            image.backgroundColor = [UIColor whiteColor];
            [self addSubview:image];

        }
    }


    [[SkinManager sharedSkinManager]addObserver:self forKeyPath:@"countTest" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];


}
- (void)initBackgroundImageView{
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

//    NSLog(@"ccc == %@",[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,login.userBackGround]);

    [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,login.userBackGround]] placeholderImage:[UIImage imageNamed:@"next.jpg"]];
}
- (void)bgButtonClick{
    self.bgButton(nil);
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSInteger count = [[change objectForKey:@"new"] integerValue];
    if (count == 1000) {
        [self initUserImage];
    }
}
- (void)initUserImage{

     LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [_userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,login.userUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
    _nameLabel.text = login.userName;
    if ([login.userText isEqualToString:@""]) {
        _addressLabel.text = @"签名：说说心情";
    }else{
        _addressLabel.text = login.userText;
    }


}

- (void)loginButtonClick{
    self.loginBtn(nil);
}

- (void)userButtonClick:(UIButton *)button{
    self.userBtn(nil);
}
- (void)nextButtonClick{

    self.next(nil);

}
- (void)btnClick:(UIButton *)button{
    if(button!=_btn){
        _btn.selected=NO;
        _btn=button;
    }
    _btn.selected=YES;

    self.buttonTag(button.tag);


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
