//
//  SpecificationModel.m
//  CarSource
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 apple. All rights reserved.
//
//获取所有规格集合
#import "SpecificationModel.h"

@implementation SpecificationModel
+ (SpecificationModel *)specificationModelWithDictionary:(NSDictionary *)dict{
    SpecificationModel *specification = [[SpecificationModel alloc]init];
    specification.specificationId = dict[@"specificationId"];//规格ID
    specification.specificationText = dict[@"specificationText"];//规格

    return specification;
}

@end
