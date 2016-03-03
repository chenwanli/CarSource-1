//
//  ExhibitionModel.m
//  CarSource
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ExhibitionModel.h"
#import "CustomerServiceUserList.h"
#import "ShowCarModel.h"
#import "TransactionVehicles.h"

@implementation ExhibitionModel
+ (ExhibitionModel *)exhibitionModelWithDictionary:(NSDictionary *)dict{
    ExhibitionModel *exhibition = [[ExhibitionModel alloc]init];
    exhibition.brandUrlList = dict[@"brandUrlList"];//经营品牌
    exhibition.customerServiceUserList =[NSMutableArray array];//客服列表
    NSMutableArray *array = dict[@"customerServiceUserList"];
    for (NSDictionary *dictonary in array) {
        CustomerServiceUserList *customer = [CustomerServiceUserList customerServiceUserListWithDictionary:dictonary];
        [exhibition.customerServiceUserList addObject:customer];

    }

    exhibition.score = dict[@"score"];//评分

    exhibition.showCar = [NSMutableArray array];//展车
    ShowCarModel *showCar = [ShowCarModel showCarModelWithDictionary:dict[@"showCar"]];
    [exhibition.showCar addObject:showCar];

    exhibition.showrooAddress = dict[@"showrooAddress"];//展厅用户地址
    exhibition.showrooUrl = dict[@"showrooUrl"];//展厅背景图
    exhibition.showrooUserId = dict[@"showrooUserId"];//展厅用户ID
    exhibition.showrooUserName = dict[@"showrooUserName"];//展厅用户昵称
    exhibition.showrooUserTel = dict[@"showrooUserTel"];//展厅用户手机号
    exhibition.showrooUserUrl = dict[@"showrooUserUrl"];//展厅用户头像
    exhibition.showroomBriefIntroduction = dict[@"showroomBriefIntroduction"];//展厅简介
    exhibition.showroomEmpirical = dict[@"showroomEmpirical"];//经验
    exhibition.showroomShowCarQuantity = dict[@"showroomShowCarQuantity"];//展厅展车台数
    exhibition.showroomViews = dict[@"showroomViews"];//展厅浏览次数
    exhibition.transactionVehiclesQuantity = dict[@"transactionVehiclesQuantity"];//交车台数

    exhibition.transactionVehicles = [NSMutableArray array];//交车
    TransactionVehicles *transaction = [TransactionVehicles transactionVehiclesWithDictionary:dict[@"transactionVehicles"]];
    [exhibition.transactionVehicles addObject:transaction];
    
    exhibition.userStatus = dict[@"userStatus"];//是否为用户本人
    return exhibition;
}
@end
