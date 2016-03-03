//
//  MyEntrustViewCell.m
//  CarSource
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyEntrustViewCell.h"

@implementation MyEntrustViewCell
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


    _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _userButton.layer.cornerRadius = 25;
    _userButton.layer.masksToBounds = YES;
    [_userButton setBackgroundImage:[UIImage  imageNamed:@"ww.jpg"] forState:UIControlStateNormal];
    [self addSubview:_userButton];


    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [_nameLabel sizeToFit];
    [self addSubview:_nameLabel];

    _searchLabel = [[UILabel alloc]init];
    _searchLabel.textAlignment = NSTextAlignmentLeft;
    _searchLabel.textColor = [UIColor colorWithRed:246/255.0 green:67/255.0 blue:25/255.0 alpha:1];
    _searchLabel.numberOfLines = 0;
    _searchLabel.font = [UIFont systemFontOfSize:18];
    [_searchLabel sizeToFit];
    [self addSubview:_searchLabel];

    _configuration = [[UILabel alloc]init];
    _configuration.textAlignment = NSTextAlignmentLeft;
    _configuration.textColor = [UIColor grayColor];
    _configuration.numberOfLines = 0;
    _configuration.font = [UIFont systemFontOfSize:16];
    [_configuration sizeToFit];
    [self addSubview:_configuration];

    _depositLabel = [[UILabel alloc]init];
    _depositLabel.textAlignment = NSTextAlignmentCenter;
    _depositLabel.textColor = [UIColor whiteColor];
    _depositLabel.backgroundColor = [UIColor colorWithRed:200/255.0 green:128/255.0 blue:45/255.0 alpha:1];
    _depositLabel.numberOfLines = 0;
    _depositLabel.text = @"定金";
    _depositLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_depositLabel];

    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = COLOR;
    _timeLabel.numberOfLines = 0;
    _timeLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_timeLabel];

    [_userButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@15);
        make.size.equalTo(CGSizeMake(50, 50));

    }];

    [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(-10);
        make.size.equalTo(CGSizeMake(70, 20));
    }];

    [_searchLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.top.equalTo(@35);
        make.size.equalTo(CGSizeMake(60, 30));

    }];

    [_configuration makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(@65);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@50);
    }];

}
- (void)initMyEntrustViewCellText:(NSString *)text{

    CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH -170, text, 16);

    _nameLabel.frame = CGRectMake(70, 10, size.width +10, 30);
    _depositLabel.frame = CGRectMake(size.width +80, 18, 30, 15);
    _nameLabel.text = text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
