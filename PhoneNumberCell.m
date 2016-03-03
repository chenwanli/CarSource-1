//
//  PhoneNumberCell.m
//  CarSource
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PhoneNumberCell.h"

@implementation PhoneNumberCell
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
    self.phoneLabel = [[UILabel alloc]init];
    self.phoneLabel.textAlignment = NSTextAlignmentCenter;
    self.phoneLabel.font = [UIFont systemFontOfSize:16];
    self.phoneLabel.textColor = [UIColor grayColor];
    self.phoneLabel.layer.cornerRadius = 5;
    self.phoneLabel.layer.masksToBounds = YES;
    self.phoneLabel.backgroundColor = [UIColor colorWithRed:227/255.0 green:241/255.0 blue:255/255.0 alpha:1];
    [self addSubview:self.phoneLabel];

    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 49, SCREEN_WIDTH -20, 1)];
    lineImage.backgroundColor = GRAY;
    [self addSubview:lineImage];


    [self.phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(170, 30));
    }];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
