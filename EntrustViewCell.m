//
//  EntrustViewCell.m
//  CarSource
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "EntrustViewCell.h"

@implementation EntrustViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _typeStr = @"";
        _userStr = @"";

//        [self awakeFromNib];
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"voice"]];

        [self addSubview:image];
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 37, 70, 10)];
        _timeLabel.text = @"12-12 18:30";
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_timeLabel];

        [image makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@5);
            make.top.equalTo(@10);
            make.size.equalTo(CGSizeMake(30, 25));
        }];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
