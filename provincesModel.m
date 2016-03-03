//
//  provincesModel.m
//  CarSource
//
//  Created by apple on 16/2/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "provincesModel.h"

@implementation provincesModel
+ (provincesModel *)provincesModelWithDictionary:(NSDictionary *)dict{
    provincesModel *provinces = [[provincesModel alloc]init];
    provinces.cityCoding = dict[@"cityCoding"];
    provinces.cityId = dict[@"cityId"];
    provinces.cityName = dict[@"cityName"];
    return provinces;
}
@end
