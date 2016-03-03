//
//  CarSeriesType.m
//  CarSource
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CarSeriesType.h"

@implementation CarSeriesType
+ (CarSeriesType *)carSeriesTypeWithDictionary:(NSDictionary *)dict{
    CarSeriesType *series = [[CarSeriesType alloc]init];
    series.carSeriesBrandName = dict[@"carSeriesBrandName"];//车系名称
    series.carSeriesName = dict[@"carSeriesName"];//车品牌名称
    series.carSeriesTypeName = dict[@"carSeriesTypeName"];//车品牌名称
    return series;
}
@end
