//
//  ShowCarModel.m
//  CarSource
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 apple. All rights reserved.
//
//展车
#import "ShowCarModel.h"

@implementation ShowCarModel
+ (ShowCarModel *)showCarModelWithDictionary:(NSDictionary *)dict{
    ShowCarModel *show = [[ShowCarModel alloc]init];
    show.showCarColour = dict[@"showCarColour"];//车身颜色/内饰颜色
    show.showCarId = dict[@"showCarId"];//展车ID
    show.showCarIntroduction = dict[@"showCarIntroduction"];//简介
    show.showCarModels = dict[@"showCarModels"];//展车型
    show.showCarModelsType = dict[@"showCarModelsType"];// 展车规格类型
    show.showCarPrice = dict[@"showCarPrice"];//展车价格
    show.showCarTime = dict[@"showCarTime"];//展车发布时间
    show.showCarUrl = dict[@"showCarUrl"];//展车首图

    return show;
}

@end
