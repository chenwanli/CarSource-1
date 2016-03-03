//
//  NextViewCell.m
//  CarSource
//
//  Created by apple on 15/12/26.
//  Copyright © 2015年 apple. All rights reserved.
//
// 个人中心添加司机的Cell
#import "NextViewCell.h"

@implementation NextViewCell
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

    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 88)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];

    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.layer.cornerRadius = 5;
    _nameLabel.layer.masksToBounds = YES;
    _nameLabel.backgroundColor =[UIColor colorWithRed:224/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.text = @"  壬我行";
    [self addSubview:_nameLabel];
    _certificateLabel = [[UILabel alloc]init];
    _certificateLabel.textColor = [UIColor grayColor];
    _certificateLabel.layer.cornerRadius = 5;
    _certificateLabel.layer.masksToBounds = YES;
    _certificateLabel.backgroundColor =[UIColor colorWithRed:224/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    _certificateLabel.font = [UIFont systemFontOfSize:15];
    _certificateLabel.text = @"  51145569677642665";
    [self addSubview:_certificateLabel];
    
    _phoneLabel = [[UILabel alloc]init];
    _phoneLabel.backgroundColor =[UIColor colorWithRed:224/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    _phoneLabel.textColor = [UIColor grayColor];
    _phoneLabel.layer.cornerRadius = 5;
    _phoneLabel.layer.masksToBounds = YES;
    _phoneLabel.font = [UIFont systemFontOfSize:15];
    _phoneLabel.text = @"  18654326789";
    [self addSubview:_phoneLabel];

//    _deleteBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_deleteBtn setTitleColor:COLOR forState:UIControlStateNormal];
//    [self addSubview:_deleteBtn];


    for (int i = 0; i <3; i++) {
        UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44*i +10, SCREEN_WIDTH -20, 1)];
        lineImage.backgroundColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1];
        [self addSubview:lineImage];

    }
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(@17);
        make.size.equalTo(CGSizeMake(80, 30));
    }];

    [_phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@126);
        make.top.equalTo(@17);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];

    [_certificateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(@61);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];

//    [_deleteBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-10);
//        make.top.equalTo(@61);
//        make.size.equalTo(CGSizeMake(50, 30));
//    }];
//
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
