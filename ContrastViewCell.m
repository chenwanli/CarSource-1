//
//  ContrastViewCell.m
//  CarSource
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ContrastViewCell.h"

@implementation ContrastViewCell
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
    _informationLabel = [[UILabel alloc]init];
    _informationLabel.text = @"商家报价";
    _informationLabel.textAlignment = NSTextAlignmentLeft;
    _informationLabel.textColor = [UIColor grayColor];
    _informationLabel.numberOfLines = 0;
    _informationLabel.font = [UIFont systemFontOfSize:14];
    [_informationLabel sizeToFit];
    [self addSubview:_informationLabel];
    
    _contrastLabel = [[UILabel alloc]init];
    _contrastLabel.text = @"88.88万";
    _contrastLabel.textAlignment = NSTextAlignmentLeft;
    _contrastLabel.textColor = [UIColor colorWithRed:219/255.0 green:54/255.0 blue:0/255.0 alpha:1];
    _contrastLabel.numberOfLines = 0;
    _contrastLabel.font = [UIFont systemFontOfSize:14];
    [_contrastLabel sizeToFit];
    [self addSubview:_contrastLabel];

    _typeLabel = [[UILabel alloc]init];
    _typeLabel.text = @"108.88万";
    _typeLabel.textAlignment = NSTextAlignmentLeft;
    _typeLabel.textColor =  [UIColor colorWithRed:219/255.0 green:54/255.0 blue:0/255.0 alpha:1];
    _typeLabel.numberOfLines = 0;
    _typeLabel.font = [UIFont systemFontOfSize:14];
    [_typeLabel sizeToFit];
    [self addSubview:_typeLabel];

    UIImageView *bottomImage = [[UIImageView alloc]init];
    bottomImage.backgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];
    [self addSubview:bottomImage];

    UIImageView *leftImage = [[UIImageView alloc]init];
    leftImage.backgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];
    [self addSubview:leftImage];

    UIImageView *rightImage = [[UIImageView alloc]init];
    rightImage.backgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];
    [self addSubview:rightImage];

    [_informationLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.size.equalTo(CGSizeMake(80, 60));
    }];

    [_contrastLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@110);
        make.top.equalTo(@0);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - 121)/2, 60));
    }];
    [_typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo((SCREEN_WIDTH - 111)/2 +111);
        make.top.equalTo(@0);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - 122)/2, 60));
    }];
    [bottomImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.equalTo(@1);

    }];

    [leftImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@100);
        make.top.equalTo(@0);
        make.width.equalTo(@1);
        make.height.equalTo(@60);

    }];

    [rightImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo((SCREEN_WIDTH - 100)/2 +100);
        make.top.equalTo(@0);
        make.width.equalTo(@1);
        make.height.equalTo(@60);

    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
