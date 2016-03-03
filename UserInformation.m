//
//  UserInformation.m
//  CarSource
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserInformation.h"

@implementation UserInformation
+ (UserInformation *)userInformationWithDictionary:(NSDictionary *)dict{
    UserInformation *information = [[UserInformation alloc]init];
    information.userName = dict[@"userName"];//用户昵称
    information.userTel = dict[@"userTel"];//用户手机号
    information.userUrl = dict[@"userUrl"];//用户头像
    information.userAuthenticateList = dict[@"userAuthenticateList"];//用户认证集
    return information;
}
@end
