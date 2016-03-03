//
//  CarSeriesViewCell.m
//  CarSource
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CarSeriesViewCell.h"

@implementation CarSeriesViewCell
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
    _typeLabel = [[UILabel alloc]init];
    _typeLabel.textColor = BLACK;
    _typeLabel.font = [UIFont systemFontOfSize:15];
    _typeLabel.numberOfLines = 0;
    [self addSubview:_typeLabel];

    self.guideLabel = [[UILabel alloc]init];
    self.guideLabel.text = @"指导价：";
    self.guideLabel.textColor = [UIColor grayColor];
    self.guideLabel.font = [UIFont systemFontOfSize:13];
    self.guideLabel.numberOfLines = 0;
    [self addSubview:self.guideLabel];

    _priceLabel = [[UILabel alloc]init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.numberOfLines = 0;
    [self addSubview:_priceLabel];

    UIImageView *image = [[UIImageView alloc]init];
    image.backgroundColor = LIGHTBLUE;
    [self addSubview:image];

    [_typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];

    [self.guideLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(@30);
        make.size.equalTo(CGSizeMake(60, 20));
    }];

    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(70);
        make.top.equalTo(@30);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@20);
    }];

    [image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
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
