//
//  RulesCarViewCell.m
//  CarSource
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RulesCarViewCell.h"

@implementation RulesCarViewCell
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

    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    bgView.layer.borderWidth = 1.0;
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];

    self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 27, 16, 16)];
    self.numberLabel.layer.cornerRadius = 8;
    self.numberLabel.layer.masksToBounds = YES;
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.font = [UIFont systemFontOfSize:13];
    self.numberLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
    [self addSubview:self.numberLabel];

    self.typeLabel = [[UILabel alloc]init];
    self.typeLabel.font = [UIFont systemFontOfSize:16];
    self.typeLabel.textColor = [UIColor grayColor];
    [self addSubview:self.typeLabel];

    self.milledImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 25, 25, 15, 18)];
    self.milledImage.image = [UIImage imageNamed:@"milled"];
    [self addSubview:self.milledImage];

    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(@0);
        make.bottom.equalTo(@0);
    }];

//    [self.numberLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@10);
//        make.top.equalTo(@27);
//        make.size.equalTo(CGSizeMake(16, 16));
//    }];

    [self.typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(@10);
        make.width.equalTo(@70);
        make.bottom.equalTo(@0);
    }];
//
//    [self.milledImage  makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-10);
//        make.bottom.equalTo(self).offset(-18);
//        make.size.equalTo(CGSizeMake(15, 18));
//    }];

}
- (void)initRulesCarViewCell{

    self.numberLabel.frame = CGRectMake(10, 32, 16, 16);
    self.milledImage.frame = CGRectMake(SCREEN_WIDTH-25, 30, 15, 18);
    self.typeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.typeButton.userInteractionEnabled = NO;
    self.typeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.typeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.typeButton setTitleColor:COLOR forState:UIControlStateNormal];
    [self addSubview:self.typeButton];

    self.guidedLabel = [[UILabel alloc]init];
    self.guidedLabel.font = [UIFont systemFontOfSize:14];
    self.guidedLabel.textAlignment = NSTextAlignmentRight;
    self.guidedLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.guidedLabel];

    [self.typeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@110);
        make.top.equalTo(@15);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@30);
    }];

    [self.guidedLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@110);
        make.top.equalTo(@42);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@20);
    }];


}
- (void)initRulesCarViewCellChooseColor{

    self.colorBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.colorBtn.userInteractionEnabled = NO;
    self.colorBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.colorBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.colorBtn setTitleColor:COLOR forState:UIControlStateNormal];
    [self addSubview:self.colorBtn];

    [self.colorBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@110);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@50);
    }];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
