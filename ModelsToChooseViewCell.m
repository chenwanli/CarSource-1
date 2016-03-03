//
//  ModelsToChooseViewCell.m
//  CarSource
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ModelsToChooseViewCell.h"

@implementation ModelsToChooseViewCell
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
    _typeLabel = [[UILabel alloc]init];
    _typeLabel.textColor = [UIColor grayColor];
    _typeLabel.font = [UIFont systemFontOfSize:16];
    _typeLabel.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    _typeLabel.layer.borderWidth = 1.0;
    _typeLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:_typeLabel];

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"milled"];
    [self addSubview:imageView];

    [_typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(self).offset(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@50);
    }];

    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-16);
        make.right.equalTo(self).offset(-10);
        make.size.equalTo(CGSizeMake(15, 18));
    }];
    


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
