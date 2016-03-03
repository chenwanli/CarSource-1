//
//  SearchModel.m
//  CarSource
//
//  Created by apple on 16/2/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel
+ (SearchModel *)searchModelWithDictionary:(NSDictionary *)dict{
    SearchModel *searchCar = [[SearchModel alloc]init];
    searchCar.brandName = dict[@"brandName"];
    searchCar.carSeriesName = dict[@"carSeriesName"];
    searchCar.carSeriesTypeName = dict[@"carSeriesTypeName"];
    searchCar.text = dict[@"text"];
    return searchCar;
}

@end
