//
//  ShowDetailsView.m
//  CarSource
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShowDetailsView.h"
#import "ShowDetailsModel.h"

@interface ShowDetailsView (){
    UILabel *_modelsLabel;//车款
    UILabel *_typeLabel;// 车类型
    UILabel *_priceLabel;//车价格
    UILabel *_colorLabel;//车颜色
    UILabel *_introduceLabel;//车型介绍
    UILabel *_timeLabel;//时间
    UIView *_bgView;
}

@end

@implementation ShowDetailsView
- (id)initWithFrame:(CGRect)frame array:(NSMutableArray *)array height:(NSInteger)height
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNibArray:array height:height];
    }
    return self;
}
- (void)awakeFromNibArray:(NSMutableArray *)array height:(NSInteger)height {

    ShowDetailsModel *showDetails = [array objectAtIndex:0];

    _modelsLabel = [[UILabel alloc]init];
    _modelsLabel.textColor = COLOR;
    _modelsLabel.text = [NSString stringWithFormat:@"%@",showDetails.showCarModels];
    _modelsLabel.textAlignment = NSTextAlignmentCenter;
    _modelsLabel.font = [UIFont systemFontOfSize:16];
    _modelsLabel.numberOfLines = 0;
    [self addSubview:_modelsLabel];

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",showDetails.showCarTime] doubleValue] / 1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:date];

    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.text = dateString;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.numberOfLines = 0;
    [self addSubview:_timeLabel];

    _typeLabel = [[UILabel alloc]init];
    _typeLabel.textColor = COLOR;
    _typeLabel.text = [NSString stringWithFormat:@"%@",showDetails.showCarModelsType];
    _typeLabel.textAlignment = NSTextAlignmentRight;
    _typeLabel.font = [UIFont systemFontOfSize:15];
    _typeLabel.numberOfLines = 0;
    [self addSubview:_typeLabel];

    _priceLabel = [[UILabel alloc]init];
    _priceLabel.textColor = COLOR;
    _priceLabel.text = [NSString stringWithFormat:@"%@",showDetails.showCarPrice];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.numberOfLines = 0;
    [self addSubview:_priceLabel];

    _colorLabel = [[UILabel alloc]init];
    _colorLabel.textColor = COLOR;
    _colorLabel.text = [NSString stringWithFormat:@"%@",showDetails.showCarColour];
    _colorLabel.textAlignment = NSTextAlignmentRight;
    _colorLabel.font = [UIFont systemFontOfSize:15];
    _colorLabel.numberOfLines = 0;
    [self addSubview:_colorLabel];

    _introduceLabel = [[UILabel alloc]init];
    _introduceLabel.textColor = [UIColor grayColor];
    _introduceLabel.font = [UIFont systemFontOfSize:14];
    _introduceLabel.text = [NSString stringWithFormat:@"%@",showDetails.showCarIntroduction];
    _introduceLabel.numberOfLines = 0;
    [self addSubview:_introduceLabel];

    NSArray *arr = [[NSArray alloc]initWithObjects:@"车源类型", @"车源价格",@"车型颜色",@"车型介绍",nil];

    for (int i = 0; i < arr.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 50*i + 70, 70, 50)];
        label.textColor = BLACK;
        label.text = [arr objectAtIndex:i];
        label.font = [UIFont systemFontOfSize:16];
        [self addSubview:label];

        UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50*i + 70, SCREEN_WIDTH -20, 1)];
        lineImage.backgroundColor = LIGHTBLUE;
        [self addSubview:lineImage];
    }

    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50*4 + 70, SCREEN_WIDTH -20, 1)];
    lineImage.backgroundColor = LIGHTBLUE;
    [self addSubview:lineImage];

    _bgView = [[UIView alloc]init];
    _bgView.backgroundColor = GRAY;
    _bgView.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    _bgView.layer.borderWidth = 1.0;
    [self addSubview:_bgView];
    
    UILabel *figureLabel = [[UILabel alloc]init];
    figureLabel.textColor = BLACK;
    figureLabel.text = @"   实拍图";
    figureLabel.backgroundColor = [UIColor whiteColor];
    figureLabel.font = [UIFont systemFontOfSize:16];
    [_bgView addSubview:figureLabel];


    [_modelsLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(@5);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@40);
    }];
    [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(@45);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@25);
    }];

    [_typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@70);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@50);
    }];

    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@120);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@50);
    }];

    [_colorLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@170);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@50);
    }];

    [_introduceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@270);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(height + 30);
    }];

    [_bgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(300 + height);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@60);
    }];

    [figureLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@10);
        make.right.equalTo(_bgView).offset(@0);
        make.height.equalTo(@50);
    }];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
