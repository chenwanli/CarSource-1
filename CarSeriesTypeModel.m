//
//  CarSeriesTypeModel.m
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//
//获取指定车系中的所有车型
#import "CarSeriesTypeModel.h"

@implementation CarSeriesTypeModel
+ (CarSeriesTypeModel *)carSeriesTypeModelWithDictionary:(NSDictionary *)dict{
    CarSeriesTypeModel *carSeries = [[CarSeriesTypeModel alloc]init];
    carSeries.carSeriesTypeId = dict[@"carSeriesTypeId"];//车型ID
    carSeries.carSeriesTypeName = dict[@"carSeriesTypeName"];//车型名称
    return carSeries;
}

@end
