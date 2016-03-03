//
//  BankCardViewCell.m
//  CarSource
//
//  Created by apple on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BankCardViewCell.h"

@implementation BankCardViewCell
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

    _bankImage = [[UIImageView alloc]init];
    [self addSubview:_bankImage];

    _bankLabel = [[UILabel alloc]init];
    _bankLabel.textColor = [UIColor grayColor];
    _bankLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_bankLabel];

    [_bankImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(15);
        make.size.equalTo(CGSizeMake(15, 15));
    }];
    [_bankLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.top.equalTo(@7);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
