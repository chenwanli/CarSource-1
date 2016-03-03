


//
//  NavView.m
//  CarSource
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NavView.h"

@implementation NavView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{
    self.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 15, 18)];
    image.image = [UIImage imageNamed:@"return"];
    [self addSubview:image];
    _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _returnBtn.frame = CGRectMake(0, 0, 60, 64);
//        returnBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [_returnBtn setBackgroundImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [_returnBtn addTarget:self action:@selector(returnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_returnBtn];

    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 15, SCREEN_WIDTH - 100, 40)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:_titleLabel];

}

- (void)returnButtonClick{
    self.returnButton(nil);
}
@end
