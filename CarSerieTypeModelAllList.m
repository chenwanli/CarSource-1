//
//  CarSerieTypeModelAllList.m
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CarSerieTypeModelAllList.h"

@implementation CarSerieTypeModelAllList
+ (CarSerieTypeModelAllList *)carSerieTypeModelAllListWithDictionary:(NSDictionary *)dict{
    CarSerieTypeModelAllList *carSeries = [[CarSerieTypeModelAllList alloc]init];
    carSeries.carSerieTypeId = dict[@"carSeriesTypeId"];//车型ID
    carSeries.carSerieTypeName = dict[@"carSeriesTypeName"];//车型名称
    carSeries.carSerieTypePrice = dict[@"carSeriesTypePrice"];//车型价格
    return carSeries;
}

@end
