//
//  BankAccountViewCell.m
//  CarSource
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BankAccountViewCell.h"

@implementation BankAccountViewCell
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

    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];

    NSArray *typeArray = @[@"开户名称",@"开户银行",@"开户账号"];
    for (int j = 0; j < typeArray.count; j++) {
        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 44 *j +10, 80, 44)];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.textColor = [UIColor grayColor];
        typeLabel.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
        typeLabel.layer.borderWidth = 1.0;
        typeLabel.font = [UIFont systemFontOfSize:15];
        typeLabel.text = [typeArray objectAtIndex:j];
        [self addSubview:typeLabel];
    }

    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    _nameLabel.layer.borderWidth = 1.0;
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.text = @"芹香雨";
    [self addSubview:_nameLabel];

    _bankLabel = [[UILabel alloc]init];
    _bankLabel.textAlignment = NSTextAlignmentCenter;
    _bankLabel.textColor = [UIColor grayColor];
    _bankLabel.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    _bankLabel.layer.borderWidth = 1.0;
    _bankLabel.font = [UIFont systemFontOfSize:15];
    _bankLabel.text = @"工商银行";
    [self addSubview:_bankLabel];

    _accountLabel = [[UILabel alloc]init];
    _accountLabel.textAlignment = NSTextAlignmentCenter;
    _accountLabel.textColor = [UIColor grayColor];
    _accountLabel.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    _accountLabel.layer.borderWidth = 1.0;
    _accountLabel.font = [UIFont systemFontOfSize:15];
    _accountLabel.text = @"56354864938289214844";
    [self addSubview:_accountLabel];


    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(-0);
        make.height.equalTo(@132);
    }];
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@44);
    }];


    [_bankLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.top.equalTo(@54);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@44);
    }];


    [_accountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.top.equalTo(@98);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@44);
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
