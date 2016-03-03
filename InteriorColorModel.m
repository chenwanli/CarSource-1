//
//  InteriorColorModel.m
//  CarSource
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 apple. All rights reserved.
//
//获取所有车型的内饰颜色集合
#import "InteriorColorModel.h"

@implementation InteriorColorModel
+ (InteriorColorModel *)interiorColorModelWithDictionary:(NSDictionary *)dict{
    InteriorColorModel *interior = [[InteriorColorModel alloc]init];
    interior.modelsInteriorColorCodes = dict[@"modelsInteriorColorCodes"];//内观颜色类
    interior.modelsInteriorColourId = dict[@"modelsInteriorColourId"];//内观颜色ID
    interior.modelsInteriorColourName = dict[@"modelsInteriorColourName"];//内观颜色名称
    return interior;
}
@end
