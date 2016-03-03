//
//  SpecifiedBrandViewCell.m
//  CarSource
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SpecifiedBrandViewCell.h"

@implementation SpecifiedBrandViewCell
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
    _carSerieName = [[UILabel alloc]init];
    _carSerieName.textAlignment = NSTextAlignmentLeft;
    _carSerieName.textColor = BLACK;
    _carSerieName.numberOfLines = 0;
    _carSerieName.font = [UIFont systemFontOfSize:16];
    [self addSubview:_carSerieName];

    _carSeriePrice = [[UILabel alloc]init];
    _carSeriePrice.textAlignment = NSTextAlignmentLeft;
    _carSeriePrice.textColor = [UIColor grayColor];
    _carSeriePrice.numberOfLines = 0;
    _carSeriePrice.font = [UIFont systemFontOfSize:14];
    [self addSubview:_carSeriePrice];

    UIImageView *image = [[UIImageView alloc]init];
    image.backgroundColor = GRAY;
    [self addSubview:image];

    [_carSerieName makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];

    [_carSeriePrice makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@30);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@20);
    }];

    [image makeConstraints:^(MASConstraintMaker *make) {
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
