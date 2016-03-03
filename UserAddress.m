//
//  UserAddress.m
//  CarSource
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserAddress.h"

@implementation UserAddress
+ (UserAddress *)userAddressModelWithDictionary:(NSDictionary *)dict{
    UserAddress *address = [[UserAddress alloc]init];
    address.addressArea = dict[@"addressArea"];
    address.addressCounties = dict[@"addressCounties"];
    address.addressProvince = dict[@"addressProvince"];
    address.addressDetailed = dict[@"addressDetailed"];
    return address;
}

@end
