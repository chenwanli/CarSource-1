//
//  CarPicturesViewCell.m
//  CarSource
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarPicturesViewCell.h"

@implementation CarPicturesViewCell
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
    _carImage = [[UIImageView alloc]init];

    [self addSubview:_carImage];
    _carLabel = [[UILabel alloc]init];
//    _carLabel.text = @"兰博基尼Huracan";
    _carLabel.textAlignment = NSTextAlignmentLeft;
    _carLabel.textColor = BLACK;

    _carLabel.numberOfLines = 0;
    _carLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_carLabel];

//    UIImageView *image = [[UIImageView alloc]init];
//    image.backgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];
//    [self addSubview:image];

    [_carImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(40, 40));
    }];


    [_carLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(60);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-80, 40));
    }];

//    [image makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(10);
//        make.bottom.equalTo(self).offset(@0);
//        make.right.equalTo(self).offset(-15);
//        make.height.equalTo(@1);
//    }];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
