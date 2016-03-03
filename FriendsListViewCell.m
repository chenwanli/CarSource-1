//
//  FriendsListViewCell.m
//  CarSource
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FriendsListViewCell.h"

@implementation FriendsListViewCell
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
    // Initialization codeassvaaebageREGERR
    self.userImage = [[UIImageView alloc]init];
    self.userImage.layer.cornerRadius = 20;
    self.userImage.layer.masksToBounds = YES;
    [self addSubview:self.userImage];

    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    self.nameLabel.numberOfLines = 0;
//    self.nameLabel.text = @"深圳车老大";
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.nameLabel];

    UIImageView *image = [[UIImageView alloc]init];
    image.backgroundColor = GRAY;
    [self addSubview:image];


    [self.userImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(40, 40));
    }];

    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.top.equalTo(@15);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
        
    }];
    [image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.bottom.equalTo(@10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@1);

    }];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
