//
//  MyProfileViewCell.m
//  CarSource
//
//  Created by apple on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyProfileViewCell.h"

@implementation MyProfileViewCell
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
//    UIImageView *image = [[UIImageView alloc]init];
//    image.backgroundColor = LIGHTBLUE;
//    [self addSubview:image];

//    UIImageView *lineImage = [[UIImageView alloc]init];
//    lineImage.backgroundColor = LIGHTBLUE;
//    [self addSubview:lineImage];
//
    _pofileImage = [[UIImageView alloc]init];

    [self addSubview:_pofileImage];
    _pofileLabel = [[UILabel alloc]init];
    _pofileLabel.textAlignment = NSTextAlignmentLeft;
    _pofileLabel.textColor = BLACK;

    _pofileLabel.numberOfLines = 0;
    _pofileLabel.font = [UIFont systemFontOfSize:17];
    [_pofileLabel sizeToFit];
    [self addSubview:_pofileLabel];

    _balanceLabel = [[UILabel alloc]init];
    _balanceLabel.textAlignment = NSTextAlignmentRight;
    _balanceLabel.textColor = [UIColor grayColor];
    _balanceLabel.numberOfLines = 0;
    _balanceLabel.font = [UIFont systemFontOfSize:14];
    [_balanceLabel sizeToFit];
    [self addSubview:_balanceLabel];

    UIImageView *bottomImage = [[UIImageView alloc]init];
    bottomImage.backgroundColor = GRAY;
    [self addSubview:bottomImage];


    [_pofileImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@13);
        make.size.equalTo(CGSizeMake(25, 25));
    }];


    [_pofileLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(50);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(150, 30));
    }];

    [_balanceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(100);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@30);

    }];


//    [image makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@0);
//        make.bottom.equalTo(self).offset(@0);
//        make.right.equalTo(self).offset(@0);
//        make.height.equalTo(@50);
//    }];
//
//    [lineImage makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@10);
//        make.right.equalTo(self).offset(0);
//        make.left.equalTo(@0);
//        make.height.equalTo(@1);
//    }];
//
//
//
    [bottomImage makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.right.equalTo(self).offset(-1);
        make.left.equalTo(@10);
        make.height.equalTo(@1);
    }];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
