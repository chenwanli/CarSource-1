//
//  ForDetailsView.m
//  CarSource
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ForDetailsView.h"
#import "ForDetailsModel.h"

@implementation ForDetailsView
- (id)initWithFrame:(CGRect)frame array:(NSMutableArray *)array height:(NSInteger)height
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNibArray:array height:height];
    }
    return self;
}
- (void)awakeFromNibArray:(NSMutableArray *)array height:(NSInteger)height {

    ForDetailsModel *details = [array objectAtIndex:0];
    NSArray *arr = [[NSArray alloc]initWithObjects:@"交车车型", @"交车日期",@"交车说明",nil];

    for (int i = 0; i < arr.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 50*i, 70, 50)];
        label.textColor = BLACK;
        label.text = [arr objectAtIndex:i];
        label.font = [UIFont systemFontOfSize:16];
        [self addSubview:label];
        if (i != 2) {
            UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 50 *i, SCREEN_WIDTH - 90, 50)];

            typeLabel.textAlignment = NSTextAlignmentRight;
            typeLabel.font = [UIFont systemFontOfSize:15];
            typeLabel.numberOfLines = 0;
            [self addSubview:typeLabel];
            if (i == 0) {
                typeLabel.textColor = COLOR;
                typeLabel.text = [NSString stringWithFormat:@"%@",details.transactionVehiclesModels];
            }else{
                typeLabel.textColor = [UIColor grayColor];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",details.transactionVehiclesTime] doubleValue] / 1000];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                NSString *dateString = [dateFormat stringFromDate:date];
                 typeLabel.text = dateString;
            }
        }

        UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50*i + 50, SCREEN_WIDTH -20, 1)];
        lineImage.backgroundColor = LIGHTBLUE;
        [self addSubview:lineImage];
    }

    UILabel *introduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, SCREEN_WIDTH - 20, height +10)];
    introduceLabel.textColor = [UIColor grayColor];
    introduceLabel.text = [NSString stringWithFormat:@"%@",details.transactionVehiclesIntroduction];
    introduceLabel.font = [UIFont systemFontOfSize:14];
    introduceLabel.numberOfLines = 0;
    [self addSubview:introduceLabel];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
