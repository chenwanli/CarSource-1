//
//  UserDataModel.m
//  CarSource
//
//  Created by apple on 16/1/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserDataModel.h"

@implementation UserDataModel
+ (UserDataModel *)userDataModelWithDictionary:(NSDictionary *)dict{
    UserDataModel *userData = [[UserDataModel alloc]init];
    userData.addressArea = dict[@"addressArea"];
    userData.userType = dict[@"userType"];
    userData.userUrl = dict[@"userUrl"];
    userData.userText = dict[@"userText"];
    userData.userTel = dict[@"userTel"];
    userData.userName = dict[@"userName"];
    userData.company = dict[@"company"];
    userData.companyName = dict[@"companyName"];
    userData.companyPosition = dict[@"companyPosition"];
    return userData;
}

@end
