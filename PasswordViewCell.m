//
//  PasswordViewCell.m
//  CarSource
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "PasswordViewCell.h"

@implementation PasswordViewCell
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


    _passwordLabel = [[UILabel alloc]init];
    _passwordLabel.textColor = [UIColor grayColor];
    _passwordLabel.backgroundColor =[UIColor whiteColor];
    _passwordLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_passwordLabel];

    UIImageView *passwordImage = [[UIImageView alloc]init];
    passwordImage.image = [UIImage imageNamed:@"milled"];
    [self addSubview:passwordImage];


    UIImageView *topImage = [[UIImageView alloc]init];
    topImage.backgroundColor = [UIColor colorWithRed:236/255.0 green:245/255.0 blue:255/255.0 alpha:1];
    [self addSubview:topImage];

    UIImageView *bottomImage = [[UIImageView alloc]init];
    bottomImage.backgroundColor = [UIColor colorWithRed:236/255.0 green:245/255.0 blue:255/255.0 alpha:1];
    [self addSubview:bottomImage];

    [_passwordLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@44);
    }];


    [passwordImage makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(@22);
        make.size.equalTo(CGSizeMake(15, 18));

    }];

    [topImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@1);
    }];


    [bottomImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(self).offset(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@1);
    }];



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
