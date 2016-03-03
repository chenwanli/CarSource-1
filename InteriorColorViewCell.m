//
//  InteriorColorViewCell.m
//  CarSource
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "InteriorColorViewCell.h"

@implementation InteriorColorViewCell
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
    _colorImage = [[UIImageView alloc]init];
    [self addSubview:_colorImage];
    _colorlabel = [[UILabel alloc]init];
    _colorlabel.font = [UIFont systemFontOfSize:16];
    _colorlabel.textColor = [UIColor grayColor];
    [self addSubview:_colorlabel];

    UIImageView *image = [[UIImageView alloc]init];
    image.backgroundColor = LIGHTBLUE;
    [self addSubview:image];

    [_colorImage makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-10);
        make.left.equalTo(@10);
        make.size.equalTo(CGSizeMake(30, 30));
    }];

    [_colorlabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.bottom.equalTo(self).offset(@0);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@50);
    }];

    [image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.bottom.equalTo(self).offset(@0);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@1);
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
