//
//  RecentlySecuredModel.m
//  CarSource
//
//  Created by apple on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RecentlySecuredModel.h"
#import "UserInformation.h"

@implementation RecentlySecuredModel
+ (RecentlySecuredModel *)recentlySecuredModelWithDictionary:(NSDictionary *)dict{
    RecentlySecuredModel *recently = [[RecentlySecuredModel alloc]init];
    recently.guaranteeCarName = dict[@"guaranteeCarName"];//担保车名称
    recently.guaranteeCarPrice = dict[@"guaranteeCarPrice"];//担保车价格
    recently.guaranteeDepositPrice = dict[@"guaranteeDepositPrice"];//保证金
    recently.guaranteeName = dict[@"guaranteeName"];//发起担保人
    recently.guaranteeStatus = dict[@"guaranteeStatus"];//交易状态
    recently.guaranteeTime = dict[@"guaranteeTime"];//担保时间
    recently.userInformation = [NSMutableArray array]; //用户信息re
    UserInformation *user = [UserInformation userInformationWithDictionary:dict[@"userInformation"]];
    [recently.userInformation addObject:user];
    return recently;
}
@end
