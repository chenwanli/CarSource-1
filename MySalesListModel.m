
//
//  MySalesListModel.m
//  CarSource
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MySalesListModel.h"

@implementation MySalesListModel
+ (MySalesListModel *)MySalesListModelWithDictionary:(NSDictionary *)dict{
    MySalesListModel *sales = [[MySalesListModel alloc]init];
    sales.carSeriesBrand = dict[@"carSeriesBrand"];//车品牌
    sales.carSeriesName = dict[@"carSeriesName"];//车系名称
    sales.carSeriesTypeName = dict[@"carSeriesTypeName"];// 车型名称
    sales.modelsPrice = dict[@"modelsPrice"];//价格多少W
    sales.salesCarsType = dict[@"salesCarsType"];//销售类型 1现车  2 期货
    sales.salesId = dict[@"salesId"];//销售ID
    sales.salesModelsColour = dict[@"salesModelsColour"];//颜色  格式为 外观/内饰
    sales.salesText = dict[@"salesText"];//销售内容
    sales.salesTime = dict[@"salesTime"];//最后一次修改时间
    sales.specificationText = dict[@"specificationText"]; //规格

    return sales;
}
@end
