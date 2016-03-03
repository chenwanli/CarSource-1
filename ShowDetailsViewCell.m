//
//  ShowDetailsViewCell.m
//  CarSource
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShowDetailsViewCell.h"

@implementation ShowDetailsViewCell
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
    self.showImage = [[UIImageView alloc]init];
    [self addSubview:self.showImage];

//    [self.showImage makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@10);
//        make.top.equalTo(@10);
//        make.right.equalTo(self).offset(-10);
//        make.height.equalTo(@200);
//    }];
}

-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
