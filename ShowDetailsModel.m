//
//  ShowDetailsModel.m
//  CarSource
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//
//展车详情
#import "ShowDetailsModel.h"

@implementation ShowDetailsModel
+ (ShowDetailsModel *)showDetailsModelWithDictionary:(NSDictionary *)dict{
    ShowDetailsModel *details = [[ShowDetailsModel alloc]init];
    details.showCarColour = dict[@"showCarColour"];//车身颜色/内饰颜色
    details.showCarId = dict[@"showCarId"];//展车ID
    details.showCarIntroduction = dict[@"showCarIntroduction"];//简介
    details.showCarModels = dict[@"showCarModels"];//展车型
    details.showCarModelsType = dict[@"showCarModelsType"];//展车规格类型
    details.showCarPrice = dict[@"showCarPrice"];//展车价格
    details.showCarTime = dict[@"showCarTime"];//展车发布时间
    details.showCarUrl = dict[@"showCarUrl"];//展车图片集合
    details.showCarUserTel = dict[@"showCarUserTel"];//展车主人手机号
    details.showroomArea = dict[@"showroomArea"];//展厅地址

    return details;
}

@end
