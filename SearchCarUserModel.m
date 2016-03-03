//
//  SearchCarUserModel.m
//  CarSource
//
//  Created by apple on 16/2/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchCarUserModel.h"

@implementation SearchCarUserModel
+ (SearchCarUserModel *)searchCarUserModelWithDictionary:(NSDictionary *)dict{
    SearchCarUserModel *searchCar = [[SearchCarUserModel alloc]init];
    searchCar.userAuthenticateList = dict[@"userAuthenticateList"];
    searchCar.userCity = dict[@"userCity"];
    searchCar.userName = dict[@"userName"];
    searchCar.userTel = dict[@"userTel"];
    searchCar.userUrl = dict[@"userUrl"];
    return searchCar;
}
@end
