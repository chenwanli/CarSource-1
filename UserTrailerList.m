//
//  UserTrailerList.m
//  CarSource
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserTrailerList.h"

@implementation UserTrailerList
+ (UserTrailerList *)userTrailerListWithDictionary:(NSDictionary *)dict{
    UserTrailerList *list = [[UserTrailerList alloc]init];
    list.userCompanyName = dict[@"userCompanyName"];
    list.userName = dict[@"userName"];
    list.userServiceType = dict[@"userServiceType"];
    list.userTrailerId = dict[@"userTrailerId"];
    list.userTrailerUrl = dict[@"userTrailerUrl"];
    list.usetTrailerTel = dict[@"usetTrailerTel"];
    list.authenticateList = dict[@"authenticateList"];
    return list;
}
@end
