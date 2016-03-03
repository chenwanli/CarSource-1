//
//  AppearanceOfInteriorViewCell.m
//  CarSource
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppearanceOfInteriorViewCell.h"

@implementation AppearanceOfInteriorViewCell
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

    UIImageView *image = [[UIImageView alloc]init];
    image.backgroundColor = [UIColor colorWithRed:254/255.0 green:228/255.0 blue:150/255.0 alpha:1];
    image.layer.borderColor = [UIColor colorWithRed:193/255.0 green:136/255.0 blue:71/255.0 alpha:1].CGColor;
    image.layer.borderWidth = 1.0;
    [self addSubview:image];

    UIImageView *angleImage = [[UIImageView alloc]init];
    angleImage.image = [UIImage imageNamed:@"not"];
    [self addSubview:angleImage];

    self.appearanceLabel = [[UILabel alloc]init];
    self.appearanceLabel.textColor = BLACK;
    self.appearanceLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.appearanceLabel];

    self.moreLabel = [[UILabel alloc]init];
    self.moreLabel.textColor = COLOR;
    self.moreLabel.text = @"更多";
    self.moreLabel.textAlignment = NSTextAlignmentRight;
    self.moreLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.moreLabel];

    [image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@10);
        make.height.equalTo(@5);
        make.right.equalTo(@0);
    }];
    [angleImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@25);
        make.size.equalTo(CGSizeMake(20, 20));

    }];

    [self.appearanceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(@25);
        make.size.equalTo(CGSizeMake(50, 30));
    }];

    [self.moreLabel  makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@25);
        make.size.equalTo(CGSizeMake(40, 30));
    }];

}
- (void)initAppearanceOfInteriorViewCellArray:(NSMutableArray *)array{

    @autoreleasepool {

        UIImageView *image = (UIImageView *)[self viewWithTag:100];
        [image removeFromSuperview];

        int totalloc=2;
        CGFloat appvieww=(SCREEN_WIDTH- 20)/2-5;
        CGFloat appviewh=(SCREEN_WIDTH- 20)/2-75;
        CGFloat margin=((SCREEN_WIDTH- 20) -totalloc*appvieww)/(totalloc+1);

        for (int i = 0; i < 4; i++) {

            int row=i/totalloc;//行号
            //1/3=0,2/3=0,3/3=1;
            int loc=i%totalloc;//列号
            CGFloat appviewx=margin+(margin+appvieww)*loc;
            CGFloat appviewy=margin+(margin+appviewh)*row;

            UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(appviewx +10, appviewy +65, (SCREEN_WIDTH - 20)/2 - 10, (SCREEN_WIDTH - 20)/2 - 80)];
            imageView.image = [UIImage imageNamed:@"h6.jpg"];
            imageView.tag = 100;
            [self addSubview:imageView];
            imageView = nil;

        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
