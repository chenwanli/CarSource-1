//
//  InformationsList.m
//  CarSource
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//
//公告信息类
#import "InformationsList.h"

@implementation InformationsList
+ (InformationsList *)informationsListWithDictionary:(NSDictionary *)dict{
    InformationsList *list = [[InformationsList alloc]init];
    list.informationText = dict[@"informationText"];
    list.informationTime = dict[@"informationTime"];
    list.informationUserId = dict[@"informationUserId"];
    return list;
}
@end
