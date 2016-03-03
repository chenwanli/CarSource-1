//
//  TransactionVehicles.m
//  CarSource
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 apple. All rights reserved.
//
//交车
#import "TransactionVehicles.h"

@implementation TransactionVehicles
+ (TransactionVehicles *)transactionVehiclesWithDictionary:(NSDictionary *)dict{
    TransactionVehicles *vehicles = [[TransactionVehicles alloc]init];
    vehicles.transactionVehiclesId = dict[@"transactionVehiclesId"];//交车ID
    vehicles.transactionVehiclesIntroduction = dict[@"transactionVehiclesIntroduction"];//交车感言
    vehicles.transactionVehiclesModels = dict[@"transactionVehiclesModels"];//交车车型
    vehicles.transactionVehiclesModelsType = dict[@"transactionVehiclesModelsType"];//交车规格
    vehicles.transactionVehiclesTime = dict[@"transactionVehiclesTime"];//交车时间
    vehicles.transactionVehiclesUrl = dict[@"transactionVehiclesUrl"];//交车首图

    return vehicles;
}


@end
