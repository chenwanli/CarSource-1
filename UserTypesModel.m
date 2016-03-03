//
//  UserTypesModel.m
//  CarSource
//
//  Created by apple on 16/2/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserTypesModel.h"

@implementation UserTypesModel
+ (UserTypesModel *)userTypesModelWithDictionary:(NSDictionary *)dict{
    UserTypesModel *user = [[UserTypesModel alloc]init];
    user.userTypeId = dict[@"userTypeId"];
    user.usetTypeName = dict[@"userTypeName"];
    return user;
}

@end
