//
//  findCarModel.m
//  CarSource
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "findCarModel.h"

@implementation findCarModel
+ (findCarModel *)findCarModelWithDictionary:(NSDictionary *)dict{
    findCarModel *findCar = [[findCarModel alloc]init];
    findCar.searchCarId = dict[@"searchCarId"];//寻车ID
    findCar.searchCarText = dict[@"searchCarText"];//寻车发布内容
    findCar.searchCarTime = dict[@"searchCarTime"];//寻车发布时间
    return findCar;
}

@end
