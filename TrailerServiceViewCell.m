//
//  TrailerServiceViewCell.m
//  CarSource
//
//  Created by apple on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "TrailerServiceViewCell.h"

@implementation TrailerServiceViewCell
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

//    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor whiteColor];
//    [self addSubview:view];

    _trailerImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"trailer1.jpg"]];
    _trailerImage.layer.cornerRadius = 30;
    _trailerImage.layer.masksToBounds = YES;
    [self addSubview:_trailerImage];

//    _userImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"h1.jpg"]];
//    _userImage.layer.cornerRadius = 30;
//    _userImage.layer.masksToBounds = YES;
//
//    [self addSubview:_userImage];
    _cityLabel = [[UILabel alloc]init];

    _cityLabel.text = @"深圳XXX拖车";
    _cityLabel.textAlignment = NSTextAlignmentLeft;
    _cityLabel.textColor = BLACK;
    _cityLabel.numberOfLines = 0;
    _cityLabel.font = [UIFont systemFontOfSize:15];
//    [_cityLabel sizeToFit];
    [self addSubview:_cityLabel];

    UIImageView *rightcertification = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"certification"]];

    [self addSubview:rightcertification];

    _typeLabel = [[UILabel alloc]init];
    _typeLabel.text = @"大小板";
    _typeLabel.textAlignment = NSTextAlignmentLeft;
    _typeLabel.textColor = COLOR;
    _typeLabel.numberOfLines = 0;
    _typeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_typeLabel];

    _nameLabel = [[UILabel alloc]init];
    _nameLabel.text = @"广东深圳市龙岗区龙翔大道缤纷世纪A座二楼226号";
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_nameLabel];


    _phoneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    _phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [_phoneBtn setTitle:@"18689620485" forState:UIControlStateNormal];
//    _phoneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"cat"] forState:UIControlStateNormal];
    [self addSubview:_phoneBtn];

//    UIImageView *phoneImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phone"]];
//
//    [self addSubview:phoneImage];
//    [view makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@10);
//        make.top.equalTo(@0);
//        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-20, 100));
//
//    }];

    [_trailerImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@15);
        make.size.equalTo(CGSizeMake(60, 60));

    }];

//    [_userImage makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(SCREEN_WIDTH/2 +5);
//        make.top.equalTo(@10);
//        make.size.equalTo(CGSizeMake(30, 30));
//
//    }];

    [_cityLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@5);
        make.right.equalTo(self).offset(-60);
        make.height.equalTo(@25);
    }];

    [rightcertification makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@170);
        make.top.equalTo(@36);
        make.size.equalTo(CGSizeMake(30, 12));

    }];

    [_typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@30);
        make.size.equalTo(CGSizeMake(60, 20));
    }];

    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@50);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@40);
    }];
//    [phoneImage makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(SCREEN_WIDTH/2 +10);
//        make.top.equalTo(@58);
//        make.size.equalTo(CGSizeMake(20, 30));
//    }];

    [_phoneBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(40, 40));

    }];


    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
