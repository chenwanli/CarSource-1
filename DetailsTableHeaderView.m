//
//  DetailsTableHeaderView.m
//  CarSource
//
//  Created by apple on 16/2/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DetailsTableHeaderView.h"
#import "SalesListModel.h"

@implementation DetailsTableHeaderView
- (id)initWithFrame:(CGRect)frame array:(NSMutableArray *)array height:(NSInteger)height
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNibArray:array height:height];
    }
    return self;
}
- (void)awakeFromNibArray:(NSMutableArray *)array height:(NSInteger)height{

    SalesListModel *salesList = [array objectAtIndex:0];

    UILabel * modelsLabel = [[UILabel alloc]init];
    modelsLabel.textAlignment = NSTextAlignmentLeft;
    modelsLabel.textColor = BLACK;
    modelsLabel.numberOfLines = 0;
    modelsLabel.text = [NSString stringWithFormat:@"%@",salesList.carSeriesTypeName];
    modelsLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:modelsLabel];

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",salesList.salesTime] doubleValue] / 1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:date];

    UILabel * timeLabel = [[UILabel alloc]init];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.numberOfLines = 0;
    timeLabel.text = dateString;
    timeLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:timeLabel];

    UILabel * priceLabel = [[UILabel alloc]init];
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.textColor = [UIColor redColor];
    priceLabel.numberOfLines = 0;
    priceLabel.text = [NSString stringWithFormat:@"%@ 万",salesList.modelsPrice];
    priceLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:priceLabel];


    UIImageView *lineImage = [[UIImageView alloc]init];
    lineImage.backgroundColor = GRAY;
    [self addSubview:lineImage];


    [modelsLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@5);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(height +10);
    }];

    [timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.bottom.equalTo(self).offset(@0);
        make.size.equalTo(CGSizeMake(150, 30));

    }];
    [priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self).offset(@0);
        make.size.equalTo(CGSizeMake(130, 30));

    }];

    [lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.bottom.equalTo(self).offset(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@1);

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
