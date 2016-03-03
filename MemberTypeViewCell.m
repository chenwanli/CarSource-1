//
//  MemberTypeViewCell.m
//  CarSource
//
//  Created by apple on 16/2/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MemberTypeViewCell.h"

@implementation MemberTypeViewCell
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

    self.memberLabel = [[UILabel alloc]init];
    self.memberLabel.textColor = BLACK;
    self.memberLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.memberLabel];

    UIImageView *image = [[UIImageView alloc]init];
    image.backgroundColor = GRAY;
    [self addSubview:image];


    [self.memberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@44);
    }];

    [image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
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
