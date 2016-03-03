//
//  CarSerieType.m
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//
//获取车系详细信息
#import "CarSerieType.h"
#import "CarSerieTypeModelAllList.h"
#import "CarSerieTypeModelList.h"


@implementation CarSerieType
+ (CarSerieType *)carSerieTypeWithDictionary:(NSDictionary *)dict{
    CarSerieType *carSeries = [[CarSerieType alloc]init];

    NSMutableArray *arr = dict[@"carSeriesTypeModelAllList"];
    carSeries.carSerieTypeModelAllList = [NSMutableArray array];

    for (NSDictionary *typeDict in arr) {
        CarSerieTypeModelAllList *carSerie = [CarSerieTypeModelAllList carSerieTypeModelAllListWithDictionary:typeDict];
        [carSeries.carSerieTypeModelAllList addObject:carSerie];
    }

    NSMutableArray *array = dict[@"carSeriesTypeModelList"];
    carSeries.carSerieTypeModelList = [NSMutableArray array];

    for (NSDictionary *carDict in array) {
        CarSerieTypeModelList *serieType = [CarSerieTypeModelList carSerieTypeModelListWithDictionary:carDict];
        [carSeries.carSerieTypeModelList addObject:serieType];
    }
    carSeries.carSeriesId = dict[@"carSeriesId"];
    carSeries.carSeriesUrlList = dict[@"carSeriesUrlList"];
    carSeries.colourList = dict[@"colourList"];
    return carSeries;
}

@end
