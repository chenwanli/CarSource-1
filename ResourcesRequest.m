//
//  ResourcesRequest.m
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ResourcesRequest.h"
#import "AFNetworking.h"
#import "CarSerieType.h"
#import "SalesListModel.h"
#import "provincesModel.h"
#import "UserTypesModel.h"
#import "SearchCarModel.h"
#import "SearchModel.h"
#define RESULTCODE @"0"

@implementation ResourcesRequest
#pragma --
#pragma mark//获取车系详细信息
+ (void)postForCarsThatDetailedInformationRequestWithCarSeriesId:(NSString *)carSeriesId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"carSeriesId":carSeriesId};
    //            NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@configuration/get_car_series_detail",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *carArray = [NSMutableArray array];
            CarSerieType *carSerie = [CarSerieType carSerieTypeWithDictionary:data[@"data"]];
            [carArray addObject:carSerie];
            showCarList(carArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}
#pragma --
#pragma mark//发布销售车辆列表
+ (void)postListReleasedSalesVehiclesRequestWithCarUserId:(NSString *)userId city:(NSString *)city area:(NSString *)area  page:(NSString *)page userITyped:(NSString *)userITyped specificationId:(NSString *)specificationId  brandId:(NSString *)brandId text:(NSString *)text showCarList:(showCarList)showCarList{

    NSDictionary *parameters = @{@"userId":userId,@"city":city,@"area":area,@"userITyped":userITyped,@"specificationId":specificationId,@"brandId":brandId,@"text":text,@"page":page};
    //                NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@sales/get_search_for",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SalesListModel *carSerie = [SalesListModel salesListModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//获取发布销售车辆列表
+ (void)postGetMySalesListRequestWithCarUserId:(NSString *)userId page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"page":page};
//                NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@sales/get_sales_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SalesListModel *carSerie = [SalesListModel salesListModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}

#pragma --
#pragma mark//获取城市中 省 列表
+ (void)postListForProvinceInTheCityWithCarShowCarList:(showCarList)showCarList{
//    NSDictionary *parameters = @{@"userId":userId,@"page":page};
    //                NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@configuration/get_province_city_list",HTTPREQUEST] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *provincesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                provincesModel *carSerie = [provincesModel provincesModelWithDictionary:salesDict];
                [provincesArray addObject:carSerie];
            }
            showCarList(provincesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//根据用户所在区域获取发布销售车辆列表
+ (void)postAccordingToTheUsersAreaToObtainAListReleasedSalesVehiclesWithUserId:(NSString *)userId city:(NSString *)city area:(NSString *)area page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"city":city,@"area":area,@"page":page};
//                    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@sales/get_city_sales_car_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SalesListModel *carSerie = [SalesListModel salesListModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//获取用户类型
+ (void)postGetTheUserTypesRequestWithShowCarList:(showCarList)showCarList{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/user_type",HTTPREQUEST] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *userArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *userDict in array) {

                UserTypesModel *carSerie = [UserTypesModel userTypesModelWithDictionary:userDict];
                [userArray addObject:carSerie];
            }
            showCarList(userArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//根据用户会员类型获取发布销售车辆列表
+ (void)postDependingOnTheTypeOfUserMembersToObtainAListReleasedSalesVehiclesReleasedSalesVehiclesWithUserId:(NSString *)userId userITyped:(NSString *)userITyped  page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"userITyped":userITyped,@"page":page};
    //                    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@sales/get_sales_userType_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SalesListModel *carSerie = [SalesListModel salesListModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}

#pragma --
#pragma mark//根据车品牌获取发布销售车辆列表
+ (void)postAccordingToTheCarBrandToObtainAListReleasedSalesVehiclesWithUserId:(NSString *)userId specificationId:(NSString *)specificationId  brandId:(NSString *)brandId page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"specificationId":specificationId,@"brandId":brandId, @"page":page};
    //                    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@sales/get_sales_brand_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败"zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SalesListModel *carSerie = [SalesListModel salesListModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//获取默认寻车列表
+ (void)postGetTheDefaultSearchListRequestWithPage:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"page":page};
    //                NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@search_car/get_search_car_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SearchCarModel *carSerie = [SearchCarModel searchCarModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//获取寻车列表
+ (void)postToObtainAListForCarRequestWithUserId:(NSString *)userId brandId:(NSString *)brandId specificationId:(NSString *)specificationId city:(NSString *)city area:(NSString *)area  page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"brandId":brandId,@"specificationId":specificationId,@"city":city,@"area":area,@"page":page};
    //                NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@search_car/search_for_search_car_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SearchCarModel *carSerie = [SearchCarModel searchCarModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}


#pragma --
#pragma mark//获取指定地区 寻车列表
+ (void)postToObtainAListSpecifiedAreasForCarRequestWithCity:(NSString *)city area:(NSString *)area page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"city":city,@"area":area,@"page":page};
    //                NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@search_car/get_city_search_car_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SearchCarModel *carSerie = [SearchCarModel searchCarModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}

#pragma --
#pragma mark//获取指定品牌寻车列表
+ (void)postToObtainAListSpecifiedBrandForTheCarRequestWithBrandId:(NSString *)brandId specificationId:(NSString *)specificationId page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"brandId":brandId,@"specificationId":specificationId,@"page":page};
    //                NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@search_car/get_brand_search_car_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SearchCarModel *carSerie = [SearchCarModel searchCarModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            showCarList(salesArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}


#pragma --
#pragma mark//添加寻车
+ (void)postAddRulesFoundInCarsRequestWithUserId:(NSString *)userId text:(NSString *)text userTypeId:(NSString *)userTypeId seriesTypeId:(NSString *)seriesTypeId specificationId:(NSString *)specificationId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"text":text,@"userTypeIdList":userTypeId,@"seriesTypeId":seriesTypeId,@"specificationId":specificationId};
//                    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@search_car/add_inlet_search_car",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"添加信息失败" zoom:NO shadow:NO];
            }
        }else{
            showCarList(nil,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}
#pragma --
#pragma mark//发布普通销售车辆
+ (void)postIssuedOrdinarySalesVehiclesRequestWithUserId:(NSString *)userId text:(NSString *)text imageArray:(NSMutableArray *)imageArray brandId:(NSString *)brandId userTypeId:(NSString *)userTypeId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"text":text,@"brandId":brandId,@"userTypeIdList":userTypeId};

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@sales/add_ordinary_sales",HTTPREQUEST] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < imageArray.count; i++ ) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:[imageArray objectAtIndex:i] name:@"file" fileName:fileName mimeType:@"image/png"];
        }

    } error:nil];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //    NSProgress *progress = nil;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {

    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                NSLog(@"32423423==%@",responseObject);
        NSMutableArray *dictArray = [responseObject objectForKey:@"code"];
        NSMutableArray *dctArray = [responseObject objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE]) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"上传失败" zoom:NO shadow:NO];
            }
        }else{

            showCarList(nil,nil,string);
        }

        if (error)
        {
            [self checkNetWorkStatus];
        }


    }];
    [uploadTask resume];

}

#pragma --
#pragma mark//发布平行进口销售车辆
+ (void)postParallelImportSalesVehiclesRequestWithUserId:(NSString *)userId salesText:(NSString *)salesText imageArray:(NSMutableArray *)imageArray carsSalesModelsId:(NSString *)carsSalesModelsId  salesCarsType:(NSString *)salesCarsType colour:(NSString *)colour salesSpecificationId:(NSString *)salesSpecificationId salesShelfNumber:(NSString *)salesShelfNumber salesImportedCarsPrice:(NSString *)salesImportedCarsPrice showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"salesText":salesText,@"carSalesModelsId":carsSalesModelsId,@"salesCarsType":salesCarsType,@"colour":colour,@"salesSpecificationId":salesSpecificationId,@"salesShelfNumber":salesShelfNumber,@"salesImportedCarsPrice":salesImportedCarsPrice};

//    NSLog(@"parameters %@",parameters);

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@sales/add_import_sales",HTTPREQUEST] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < imageArray.count; i++ ) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:[imageArray objectAtIndex:i] name:@"file" fileName:fileName mimeType:@"image/png"];
        }

    } error:nil];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //    NSProgress *progress = nil;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {

    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                        NSLog(@"32423423==%@",responseObject);
        NSMutableArray *dictArray = [responseObject objectForKey:@"code"];
        NSMutableArray *dctArray = [responseObject objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE]) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"上传失败" zoom:NO shadow:NO];
            }
        }else{
                showCarList(nil,nil,string);
        }

        if (error)
        {
            [self checkNetWorkStatus];
        }
        
        
    }];
    [uploadTask resume];
    
}

#pragma --
#pragma mark//发起担保
+ (void)postAGuaranteeRequestWithUserId:(NSString *)userId vouchTransactionCarSeriesTypeId:(NSString *)vouchTransactionCarSeriesTypeId imageArray:(NSMutableArray *)imageArray vouchTransactionColour:(NSString *)vouchTransactionColour  vouchTransactionDealPrice:(NSString *)vouchTransactionDealPrice vouchTransactionGuaranteeDepositPrice:(NSString *)vouchTransactionGuaranteeDepositPrice vouchTransactionText:(NSString *)vouchTransactionText  tel:(NSString *)tel showCarList:(showCarList)showCarList{

    NSDictionary *parameters = @{@"userId":userId,@"vouchTransactionCarSeriesTypeId":vouchTransactionCarSeriesTypeId,@"vouchTransactionColour":vouchTransactionColour,@"vouchTransactionDealPrice":vouchTransactionDealPrice,@"vouchTransactionGuaranteeDepositPrice":vouchTransactionGuaranteeDepositPrice,@"vouchTransactionText":vouchTransactionText,@"tel":tel};

//        NSLog(@"parameters %@",parameters);

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@guarantee/add_guarantee",HTTPREQUEST] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < imageArray.count; i++ ) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:[imageArray objectAtIndex:i] name:@"file" fileName:fileName mimeType:@"image/png"];
        }

    } error:nil];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //    NSProgress *progress = nil;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {

    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                                NSLog(@"32423423==%@",responseObject);
        NSMutableArray *dictArray = [responseObject objectForKey:@"code"];
        NSMutableArray *dctArray = [responseObject objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE]) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"上传失败" zoom:NO shadow:NO];
            }
        }else{

            showCarList(nil,nil,string);
        }

        if (error)
        {
            [self checkNetWorkStatus];
        }


    }];
    [uploadTask resume];
    
}

#pragma --
#pragma mark//搜索
+ (void)postSearchRequestWithText:(NSString *)text page:(NSString *)page showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"text":text,@"page":page};
    //                NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@sales/get_complete_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //                NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            showCarList(nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *searchArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *searchDict in array) {
                SearchModel *carSerie = [SearchModel searchModelWithDictionary:searchDict];
                [searchArray addObject:carSerie];
            }
            showCarList(searchArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}

+ (void)checkNetWorkStatus{
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
     */
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            //            NSLog(@"网络连接已断开，请检查您的网络！");
            SHOW_ALERT( @"网络连接已断开，请检查您的网络！")
        }else{
            SHOW_ALERT( @"服务器异常")
        }
    }];
    
}

@end
