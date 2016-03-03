//
//  CarSerieModel.m
//  CarSource
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 apple. All rights reserved.
//
//获取指定品牌的所有车系

#import "CarSerieModel.h"

@implementation CarSerieModel
+ (CarSerieModel *)carSerieModelWithDictionary:(NSDictionary *)dict{
    CarSerieModel *serie = [[CarSerieModel alloc]init];
    serie.carSerieId = dict[@"carSeriesId"];//车型ID
    serie.carSerieName = dict[@"carSeriesName"];//车型名称
    serie.carSeriePrice = dict[@"carSeriesPrice"];//车型价格
    return serie;
}

@end
