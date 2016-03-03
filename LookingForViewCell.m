//
//  LookingForViewCell.m
//  CarSource
//
//  Created by apple on 16/2/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LookingForViewCell.h"

@implementation LookingForViewCell
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
    self.membersLabel  = [[UILabel alloc]init];
    self.membersLabel.textColor = [UIColor grayColor];
    self.membersLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.membersLabel];

    self.typeLabel  = [[UILabel alloc]init];
    self.typeLabel.textColor = COLOR;
    self.typeLabel.textAlignment = NSTextAlignmentRight;
    self.typeLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.typeLabel];

    UIImageView *milledImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 25, 65, 15, 18)];
    milledImage.image = [UIImage imageNamed:@"milled"];
    [self addSubview:milledImage];

    UIImageView *lineImage = [[UIImageView alloc]init];
    lineImage.backgroundColor = [UIColor colorWithRed:175/255.0 green:219/255.0 blue:246/255.0 alpha:1];
    [self addSubview:lineImage];

    [self.membersLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.size.equalTo(CGSizeMake(70, 44));
    }];


    [self.typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(-35);
        make.height.equalTo(@44);
    }];


    [milledImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.right.equalTo(self).offset(-10);
        make.size.equalTo(CGSizeMake(15, 18));
    }];

    [lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.bottom.equalTo(@0);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@1);
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
