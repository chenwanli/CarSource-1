//
//  ExteriorColorModel.m
//  CarSource
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 apple. All rights reserved.
//
//获取所有车型的外观颜色集合
#import "ExteriorColorModel.h"

@implementation ExteriorColorModel
+ (ExteriorColorModel *)exteriorColorModelWithDictionary:(NSDictionary *)dict{
    ExteriorColorModel *exterior = [[ExteriorColorModel alloc]init];
    exterior.modelsExteriorColorCodes = dict[@"modelsExteriorColorCodes"];//外观颜色类
    exterior.modelsExteriorColourId = dict[@"modelsExteriorColourId"];//外观颜色ID
    exterior.modelsExteriorColourName = dict[@"modelsExteriorColourName"];//外观颜色名称
    return exterior;
}

@end
