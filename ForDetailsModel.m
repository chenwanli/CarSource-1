//
//  ForDetailsModel.m
//  CarSource
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ForDetailsModel.h"

@implementation ForDetailsModel
+ (ForDetailsModel *)forDetailsModelWithDictionary:(NSDictionary *)dict{
    ForDetailsModel *details = [[ForDetailsModel alloc]init];
    details.userAddress = dict[@"contactAddress"][@"userAddress"];//交车地址
    details.userAddressTel = dict[@"contactAddress"][@"userAddressTel"];//交车电话
    details.transactionVehiclesId = dict[@"transactionVehiclesId"];//交车记录ID
    details.transactionVehiclesIntroduction = dict[@"transactionVehiclesIntroduction"];//交车型号
    details.transactionVehiclesModels = dict[@"transactionVehiclesModels"];//交车型号
    details.transactionVehiclesModelsType = dict[@"transactionVehiclesModelsType"];//交车型号
    details.transactionVehiclesTime = dict[@"transactionVehiclesTime"];//交车记录时间
    details.transactionVehiclesUrlList = dict[@"transactionVehiclesUrlList"];//交车型号
    return details;
}

@end
