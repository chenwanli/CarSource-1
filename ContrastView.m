//
//  ContrastView.m
//  CarSource
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ContrastView.h"

@implementation ContrastView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    _contrastView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 100)];
    _contrastView.backgroundColor = [UIColor colorWithRed:239/255.0 green:247/255.0 blue:254/255.0 alpha:1];
    [self addSubview:_contrastView];

    UIButton *hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hiddenBtn.frame = CGRectMake(10, 20, 60, 60);
    [hiddenBtn setBackgroundImage:[UIImage imageNamed:@"eay.png"] forState:UIControlStateNormal];
    [hiddenBtn setBackgroundImage:[UIImage imageNamed:@"sey.png"] forState:UIControlStateSelected];
    hiddenBtn.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
    [hiddenBtn addTarget:self action:@selector(hiddenButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_contrastView addSubview:hiddenBtn];


}
- (void)initContrastViewArray:(NSMutableArray *)array{

    for (int i = 0 ; i < 2; i++ ) {

        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(((SCREEN_WIDTH- 85)/2 )*i+ 80, 10, (SCREEN_WIDTH- 95)/2, 80)];
        view.backgroundColor = [UIColor colorWithRed:218/255.0 green:237/255.0 blue:254/255.0 alpha:1];
        [_contrastView addSubview:view];

        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, view.frame.size.width-20 , 40)];
        typeLabel.text = @"奥迪Q5 40TFSI 进取型";
        typeLabel.textColor = [UIColor grayColor];
        typeLabel.numberOfLines = 0;
        typeLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:typeLabel];
        UILabel *guidedLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 55, 55 , 25)];
        guidedLabel.text = @"指导价：";
        guidedLabel.textColor = [UIColor lightGrayColor];
        guidedLabel.numberOfLines = 0;
        guidedLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:guidedLabel];

        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 55, view.frame.size.width-50 , 25)];
        priceLabel.text = @"8866.88万";
        priceLabel.textColor = [UIColor colorWithRed:219/255.0 green:54/255.0 blue:0/255.0 alpha:1];
        priceLabel.numberOfLines = 0;
        priceLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:priceLabel];
    }
    

}

- (void)hiddenButtonClick:(UIButton *)button{

    button.selected = !button.selected;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
