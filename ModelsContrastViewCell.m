//
//  ModelsContrastViewCell.m
//  CarSource
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ModelsContrastViewCell.h"

@implementation ModelsContrastViewCell
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

//    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"highlighted"] forState:UIControlStateNormal];
//    [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"for"] forState:UIControlStateSelected];
//    [self addSubview:_deleteBtn];

    _deleteImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 15, 15)];
    [self addSubview:_deleteImage];

    _modelsLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, SCREEN_WIDTH -20, 24)];

    _modelsLabel.text = @"奥迪Q7    3.5L   豪华版   2015款";
    _modelsLabel.textAlignment = NSTextAlignmentLeft;
    _modelsLabel.textColor = [UIColor grayColor];
    _modelsLabel.numberOfLines = 0;
    _modelsLabel.font = [UIFont systemFontOfSize:15];
    [_modelsLabel sizeToFit];
    [self addSubview:_modelsLabel];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 43, SCREEN_WIDTH-20, 1)];
    image.backgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];
    [self addSubview:image];

//    [_deleteImage makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@10);
//        make.top.equalTo(@13);
//        make.size.equalTo(CGSizeMake(15, 15));
//    }];
//
//
//    [_modelsLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(10);
//        make.top.equalTo(@0);
//        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-20, 44));
//    }];
//
//    [image makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(10);
//        make.bottom.equalTo(self).offset(@0);
//        make.right.equalTo(self).offset(-10);
//        make.height.equalTo(@1);
//    }];

}
- (void)modelsContrastViewCell{
//    [_modelsLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(40);
//        make.top.equalTo(@0);
//        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-50, 44));
//    }];
    _modelsLabel.frame = CGRectMake(40, 0, SCREEN_WIDTH - 45, 44);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
