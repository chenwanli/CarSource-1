//
//  LatestBelowViewCell.m
//  CarSource
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LatestBelowViewCell.h"

@implementation LatestBelowViewCell
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

    UIImageView *bgIamge = [[UIImageView alloc]init];
    bgIamge.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgIamge];

    self.belowIamge = [[UIImageView alloc]init];
//    self.belowIamge.image = [UIImage imageNamed:@"Aventador"];
    [self addSubview:self.belowIamge];

    self.carLabel = [[UILabel alloc]init];
    //    self.carLabel.textAlignment = NSTextAlignmentRight;
    self.carLabel.numberOfLines = 0;
//    self.carLabel.text = @"15款奔驰CLE200";
    self.carLabel.textColor = COLOR;
    self.carLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.carLabel];

    self.priceLabel = [[UILabel alloc]init];
    //    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel.numberOfLines = 0;
//    self.priceLabel.text = @"美规 现车 黑／白66.88万";
    self.priceLabel.textColor = [UIColor grayColor];
    self.priceLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.priceLabel];

    self.detailedLabel = [[UILabel alloc]init];
    //    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.detailedLabel.numberOfLines = 0;
//    self.detailedLabel.text = @"5系4356 德系黑马 手续全 销往内蒙5系4356 内蒙5系4356 德系黑马 手续全 销往内蒙5系4356 内蒙5系4356 ";
    self.detailedLabel.textColor = [UIColor grayColor];
    self.detailedLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.detailedLabel];


    [bgIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@130);
    }];


    [self.belowIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@20);
        make.right.equalTo(self).offset(-(SCREEN_WIDTH/2+10));
        make.height.equalTo(@110);
    }];

    [self.carLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(@15);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@40);
    }];

    [self.priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(@50);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];

    [self.detailedLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(@80);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@55);
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
