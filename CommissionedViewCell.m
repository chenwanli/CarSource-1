//
//  CommissionedViewCell.m
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CommissionedViewCell.h"

@implementation CommissionedViewCell
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
    _carImage = [[UIImageView alloc]init];

    [self addSubview:_carImage];
    _typeImage = [[UIImageView alloc]init];

    [self addSubview:_typeImage];
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.backgroundColor = [UIColor colorWithRed:253/255.0 green:241/255.0 blue:194/255.0 alpha:1];
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [_nameLabel sizeToFit];
    [self addSubview:_nameLabel];
    _typeLabel = [[UILabel alloc]init];
    _typeLabel.backgroundColor = [UIColor colorWithRed:253/255.0 green:241/255.0 blue:194/255.0 alpha:1];
    _typeLabel.textColor = [UIColor grayColor];
    _typeLabel.numberOfLines = 0;
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    _typeLabel.font = [UIFont systemFontOfSize:14];
    [_typeLabel sizeToFit];
    [self addSubview:_typeLabel];

//    _resultsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_resultsBtn setBackgroundImage:[UIImage imageNamed:@"results"] forState:UIControlStateNormal];
//    [self addSubview:_resultsBtn];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bubble"]];

    [self addSubview:image];

    UIImageView *pkImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pk"]];

    [self addSubview:pkImage];

    [_carImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-12, 120));
    }];


    [_typeImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2+5);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-13, 120));
    }];

    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@130);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-12, 30));
    }];


    [_typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2+5);
        make.top.equalTo(@130);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-13, 30));
    }];

    [image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2-70);
        make.top.equalTo(@175);
        make.size.equalTo(CGSizeMake(140, 20));
    }];

//    [image makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(100);
//        make.top.equalTo(@175);
//        make.right.equalTo(self).offset(-100);
//        make.height.equalTo(@20);
//    }];

    [pkImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2-20);
        make.top.equalTo(@45);
        make.size.equalTo(CGSizeMake(40, 40));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
