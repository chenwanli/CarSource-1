//
//  LookingOptionsViewCell.m
//  CarSource
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LookingOptionsViewCell.h"

@interface LookingOptionsViewCell ()

@end
@implementation LookingOptionsViewCell

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

    self.lookingLabel = [[UILabel alloc]init];
    self.lookingLabel.textColor = BLACK;
    self.lookingLabel.font = [UIFont systemFontOfSize:15];
    self.lookingLabel.numberOfLines = 0;
    [self addSubview:self.lookingLabel];

    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.timeLabel];

    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(@0);
        make.size.equalTo(CGSizeMake(120, 30));
    }];
    
    UIImageView *lineImage = [[UIImageView alloc]init];
    lineImage.backgroundColor = GRAY;
    [self addSubview:lineImage];

    [lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.bottom.equalTo(self).offset(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@1);
    }];


    
}
- (void)lookingOptionsViewCellHeight:(CGFloat)height{
    self.lookingLabel.frame = CGRectMake(10, 10, SCREEN_WIDTH -20, height);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
