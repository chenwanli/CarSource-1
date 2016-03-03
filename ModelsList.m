//
//  ModelsList.m
//  CarSource
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//
//车型类
#import "ModelsList.h"

@implementation ModelsList
+ (ModelsList *)modelsListWithDictionary:(NSDictionary *)dict{
    ModelsList *list = [[ModelsList alloc]init];
    list.modelsId = dict[@"modelsId"];
    list.modelsName = dict[@"modelsName"];
    list.modelsPrice = dict[@"modelsPrice"];
    list.modelsUrl = dict[@"modelsUrl"];
    return list;
}

@end
