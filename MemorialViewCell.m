//
//  MemorialViewCell.m
//  CarSource
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MemorialViewCell.h"

@implementation MemorialViewCell
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

    self.memorialImage = [[UIImageView alloc]init];
//    self.memorialImage.image = [UIImage imageNamed:@"Aventador"];
    [self addSubview:self.memorialImage];

    UILabel *typeLabel = [[UILabel alloc]init];
    typeLabel.numberOfLines = 0;
    typeLabel.text = @"车型：";
    typeLabel.textColor = [UIColor grayColor];
    typeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:typeLabel];

    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.numberOfLines = 0;
    timeLabel.text = @"日期：";
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:timeLabel];

    self.carLabel = [[UILabel alloc]init];
    //    self.carLabel.textAlignment = NSTextAlignmentRight;
    self.carLabel.numberOfLines = 0;
    [self.carLabel sizeToFit];
    //    self.carLabel.text = @"15款奔驰CLE200";
    self.carLabel.textColor = COLOR;
    self.carLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.carLabel];

    self.priceLabel = [[UILabel alloc]init];
    //    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel.numberOfLines = 0;
    //    self.priceLabel.text = @"2015-12-12";
    self.priceLabel.textColor = COLOR;
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
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@130);
    }];


    [self.memorialImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(-(SCREEN_WIDTH/2+10));
        make.height.equalTo(@110);
    }];

    [typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(@5);
        make.size.equalTo(CGSizeMake(45, 30));
    }];
    [timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(@38);
        make.size.equalTo(CGSizeMake(45, 30));
    }];

    [self.carLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2+45);
        make.top.equalTo(@5);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@35);
    }];

    [self.priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2+45);
        make.top.equalTo(@38);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];

    [self.detailedLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(@65);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@60);
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
