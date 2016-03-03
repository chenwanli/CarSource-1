//
//  SearchCarModel.m
//  CarSource
//
//  Created by apple on 16/2/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchCarModel.h"
#import "SearchCarUserModel.h"

@implementation SearchCarModel
+ (SearchCarModel *)searchCarModelWithDictionary:(NSDictionary *)dict{
    SearchCarModel *searchCar = [[SearchCarModel alloc]init];
    searchCar.searchCarId = dict[@"searchCarId"];
    searchCar.searchCarText = dict[@"searchCarText"];
    searchCar.searchCarTime = dict[@"searchCarTime"];
    searchCar.searchCarUser = [NSMutableArray array];
    SearchCarUserModel *carUser = [SearchCarUserModel searchCarUserModelWithDictionary:dict[@"searchCarUser"]];
    [searchCar.searchCarUser addObject:carUser];
    return searchCar;
}
@end
