//
//  UserAddress.h
//  CarSource
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 apple. All rights reserved.
//
// 我的服务 用户地址信息
#import <Foundation/Foundation.h>

@interface UserAddress : NSObject
@property (nonatomic,strong)NSString *addressArea,*addressCounties,*addressProvince,*addressDetailed;
+ (UserAddress *)userAddressModelWithDictionary:(NSDictionary *)dict;
@end
