//
//  SearchViewCell.m
//  CarSource
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchViewCell.h"

@implementation SearchViewCell
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
    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 49, SCREEN_WIDTH, 1)];
    lineImage.backgroundColor = GRAY;
    [self addSubview:lineImage];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
