//
//  MessageViewCell.m
//  CarSource
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MessageViewCell.h"

@implementation MessageViewCell
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
    // Initialization code的SV的 v

    self.userImage = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"ww.jpg"]];
    self.userImage.layer.cornerRadius = 25;
    self.userImage.layer.masksToBounds = YES;
    [self addSubview:self.userImage];

    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.text = @"深圳车老大";
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.nameLabel];

    self.instructions = [[UILabel alloc]init];
    self.instructions.textAlignment = NSTextAlignmentLeft;
    self.instructions.textColor = [UIColor grayColor];
    self.instructions.numberOfLines = 0;
    self.instructions.text = @"你的车怎么卖啊，美女你的车怎么卖啊，美女你的车怎么卖啊，美女";
    self.instructions.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.instructions];


    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.numberOfLines = 0;
    self.timeLabel.text = @"12:30";
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.timeLabel];


    [self.userImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@15);
        make.size.equalTo(CGSizeMake(50, 50));
    }];

    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.top.equalTo(@5);
        make.right.equalTo(self).offset(-70);
        make.height.equalTo(@30);

    }];

    [self.instructions makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.top.equalTo(@30);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@40);

    }];


    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(-10);
        make.size.equalTo(CGSizeMake(60, 20));
    }];




}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
