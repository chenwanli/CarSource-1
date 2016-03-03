//
//  LicensePlateViewCell.m
//  CarSource
//
//  Created by apple on 15/12/26.
//  Copyright © 2015年 apple. All rights reserved.
//
// 个人中心添加车牌号的cell
#import "LicensePlateViewCell.h"

@implementation LicensePlateViewCell
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
    _licenseLabel = [[UILabel alloc]init];
    _licenseLabel.textColor = [UIColor grayColor];
    _licenseLabel.layer.cornerRadius = 5;
    _licenseLabel.layer.masksToBounds = YES;
    _licenseLabel.backgroundColor =[UIColor colorWithRed:224/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    _licenseLabel.font = [UIFont systemFontOfSize:15];
    _licenseLabel.text = @"  粤B16688";
    [self addSubview:_licenseLabel];

    UIImageView *lineImage = [[UIImageView alloc]init];

    lineImage.backgroundColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1];
    [self addSubview:lineImage];


//    _deleteButton  = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
//    _deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_deleteButton setTitleColor:COLOR forState:UIControlStateNormal];
//    [self addSubview:_deleteButton];

    [_licenseLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(@7);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];
//    [_deleteButton makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(0);
//        make.top.equalTo(@7);
//        make.size.equalTo(CGSizeMake(35, 30));
//    }];
    [lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.bottom.equalTo(@0);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@1);
    }];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
