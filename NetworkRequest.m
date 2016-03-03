//
//  NetworkRequest.m
//  CarSource
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NetworkRequest.h"
#import "AFNetworking.h"
#import "ExhibitionModel.h"
#import "ShowCarModel.h"
#import "TransactionVehicles.h"
#import "ShowDetailsModel.h"
#import "ForDetailsModel.h"
#import "BrandModel.h"
#import "SpecificationModel.h"
#import "CarSerieModel.h"
#import "ExteriorColorModel.h"
#import "InteriorColorModel.h"
#import "CarSeriesTypeModel.h"
#define RESULTCODE @"0"

@implementation NetworkRequest

#pragma --
#pragma mark// 获取首页信息
+ (void)postForInformationOnTheHomepageRequestWithUserId:(NSString *)userId request:(request)request{
    NSDictionary *parameters = @{@"userId":userId};
    //        NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@browse/show",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            request(nil,nil,nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }

        }else{
            
//            NSMutableArray *informationsArr = data[@"data"][@"informationsList"];
            NSMutableArray *modelsArr = data[@"data"][@"modelsList"];
            NSMutableArray *promotionArr = data[@"data"][@"promotionList"];
            NSMutableArray *trailerArr = data[@"data"][@"userTrailerList"];

            request(nil,modelsArr,promotionArr,trailerArr,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            request(nil,nil,nil,nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark// 我的展厅
+ (void)postMyShowroomRequestWithUserId:(NSString *)userId  showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId};
    //        NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/ger_user_showroom",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
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

            NSMutableArray *exhibitionArray = [NSMutableArray array];
            ExhibitionModel *exhibition = [ExhibitionModel exhibitionModelWithDictionary:data[@"data"]];
            [exhibitionArray addObject:exhibition];

            showCarList(exhibitionArray,data[@"data"][@"showrooId"], string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark// 获取展厅信息
+ (void)postExhibitionInformationRequestWithUserId:(NSString *)userId showroomId:(NSString *)showroomId Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId":userId,@"showroomId":showroomId};
    //        NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@showroom/get_showroom",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            completion(nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }

        }else{

            NSMutableArray *exhibitionArray = [NSMutableArray array];
            ExhibitionModel *exhibition = [ExhibitionModel exhibitionModelWithDictionary:data[@"data"]];
            [exhibitionArray addObject:exhibition];

            completion(exhibitionArray,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            completion(nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark// 修改展厅
+ (void)postModifyTheShowroomRequestWithUserId:(NSString *)userId showroomId:(NSString *)showroomId  introduction:(NSString *)introduction address:(NSString *)address empirical:(NSString *)empirical Completion:(requestComplete)completion{

    NSDictionary *parameters = @{@"userId":userId,@"showroomId":showroomId,@"introduction":introduction,@"address":address,@"empirical":empirical};
//            NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@showroom/set_showroom",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            completion(nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"修改资料失败" zoom:NO shadow:NO];
            }

        }else{
            completion(nil,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            completion(nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark// 车展列表信息
+ (void)postShowAListOfInformationRequestWithUserId:(NSString *)userId showroomId:(NSString *)showroomId  page:(NSString *)page showCarList:(showCarList)showCarList{

    NSDictionary *parameters = @{@"userId":userId,@"showroomId":showroomId,@"page":page};

    //        NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@showroom/get_show_car_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
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
            NSMutableArray *showArray = data[@"data"][@"showCarList"];
            NSMutableArray *showCarArray = [NSMutableArray array];

            for (NSDictionary *dict in showArray) {
                ShowCarModel *show = [ShowCarModel showCarModelWithDictionary:dict];

                [showCarArray addObject:show];
            }

            showCarList(showCarArray,data[@"data"][@"userStatus"],string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil,nil);
        }
        
    }];
}
#pragma --
#pragma mark// 查看指定车展信息
+ (void)postViewTheInformationSpecifiedMotorShowRequestWithShowCarId:(NSString *)showCarId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"showCarId":showCarId};
    //        NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@showroom/get_show_car",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
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
            NSMutableArray *showCarArray = [NSMutableArray array];

            ShowDetailsModel *show = [ShowDetailsModel showDetailsModelWithDictionary:data[@"data"]];

            [showCarArray addObject:show];

            showCarList(showCarArray,nil,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark// 删除指定用户车展信息
+ (void)postDeleteTheSpecifiedUserShowInformationRequestWithUserId:(NSString *)userId showroomId:(NSString *)showroomId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"showCarIdList":showroomId};
    //        NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@showroom/delete_show_car",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
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
                [LCCoolHUD showFailure:@"删除车展信息失败" zoom:NO shadow:NO];
            }
        }else{
            showCarList(nil,nil,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark// 交车列表信息
+ (void)postPayTheCarListInformationRequestWithUserId:(NSString *)userId showroomId:(NSString *)showroomId  page:(NSString *)page showCarList:(showCarList)showCarList{

    NSDictionary *parameters = @{@"userId":userId,@"showroomId":showroomId,@"page":page};

    //        NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@showroom/get_transaction_vehicles_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
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
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }

        }else{
            NSMutableArray *showArray = data[@"data"][@"transactionVehiclesList"];
            NSMutableArray *showCarArray = [NSMutableArray array];

            for (NSDictionary *dict in showArray) {
                TransactionVehicles *show = [TransactionVehicles transactionVehiclesWithDictionary:dict];

                [showCarArray addObject:show];
            }
            showCarList(showCarArray,data[@"data"][@"userStatus"],string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark// 删除交车记录
+ (void)postDeleteCarRecordsRequestWithUserId:(NSString *)userId transactionVehiclesId:(NSString *)transactionVehiclesId Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId":userId,@"transactionVehiclesIdList":transactionVehiclesId};
//            NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@showroom/delete_transaction_vehicles",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            completion(nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"删除交车信息失败" zoom:NO shadow:NO];
            }

        }else{

            completion(nil,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            completion(nil,nil);
        }
        
    }];
}
#pragma --
#pragma mark// 交车信息详情
+ (void)postForDetailsInformationRequestWithUserId:(NSString *)userId transactionVehiclesId:(NSString *)transactionVehiclesId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"transactionVehiclesId":transactionVehiclesId,@"userId":userId};
    //        NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@showroom/get_transaction_vehicles",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
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
            NSMutableArray *showCarArray = [NSMutableArray array];

            ForDetailsModel *show = [ForDetailsModel forDetailsModelWithDictionary:data[@"data"]];

            [showCarArray addObject:show];

            showCarList(showCarArray,nil,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark// 添加车展信息
+ (void)postAddTheShowInformationRequestWithUserId:(NSString *)userId modelsId:(NSString *)modelsId  interiorColourId:(NSString *)interiorColourId exteriorColourId:(NSString *)exteriorColourId  price:(NSString *)price introduction:(NSString *)introduction urlArr:(NSString *)urlArr showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"modelsId":modelsId,@"userId":userId};
    //        NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@showroom/get_transaction_vehicles",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
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
            NSMutableArray *showCarArray = [NSMutableArray array];

            ForDetailsModel *show = [ForDetailsModel forDetailsModelWithDictionary:data[@"data"]];

            [showCarArray addObject:show];

            showCarList(showCarArray,nil,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark//获取所有品牌集合
+ (void)postGetAllTheBrandCollectionsRequestWithUserId:(NSString *)userId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId};
//            NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@configuration/brand_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
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
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *brandArray ;
             BrandModel *brand = [[BrandModel alloc] init];
            brandArray = [brand storeForDictionary:data];
            showCarList(brandArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//获取所有规格集合
+ (void)postGetAllTheSpecificationsSetRequestWithUserId:(NSString *)userId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId};
    //            NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@configuration/specification_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
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
            NSMutableArray *specificationArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *dict in array) {
                SpecificationModel *specification = [SpecificationModel specificationModelWithDictionary:dict];
                [specificationArray addObject:specification];
            }
            showCarList(specificationArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}

#pragma --
#pragma mark//获取指定规格品牌
+ (void)postSpecifyTheSpecificationsBrandRequestWithUserId:(NSString *)userId specificationId:(NSString *)specificationId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"specificationId":specificationId};
    //            NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@configuration/brand_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
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
            NSMutableArray *brandArray ;
            BrandModel *brand = [[BrandModel alloc] init];
            brandArray = [brand storeForDictionary:data];
            showCarList(brandArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//指定规格品牌
+ (void)postSpecificationsBrandRequestWithBrandId:(NSString *)brandId specificationId:(NSString *)specificationId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"brandId":brandId,@"specificationId":specificationId};
    //            NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@configuration/get_car_series_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
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
            NSMutableArray *serieArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *dict in array) {
                CarSerieModel *serie = [CarSerieModel carSerieModelWithDictionary:dict];
                [serieArray addObject:serie];
            }
            showCarList(serieArray,nil, string);

        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}

#pragma --
#pragma mark//获取指定品牌的所有车系
+ (void)postSpecifiedBrandForAllCarsRequestWithBrandId:(NSString *)brandId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"brandId":brandId};
    //            NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@configuration/get_car_series_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
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
            NSMutableArray *serieArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *dict in array) {
                CarSerieModel *serie = [CarSerieModel carSerieModelWithDictionary:dict];
                [serieArray addObject:serie];
            }
            showCarList(serieArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}
#pragma --
#pragma mark//获取指定车系中的所有车型
+ (void)postAccessToSpecifyAllTheModelsInTheCarsRequestWithCarSeriesId:(NSString *)carSeriesId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"carSeriesId":carSeriesId};
    //            NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@configuration/get_car_series_type",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);
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
                [LCCoolHUD showFailure:@"获取信息失败" zoom:NO shadow:NO];
            }
        }else{
            NSMutableArray *serieArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *dict in array) {
                CarSeriesTypeModel *serie = [CarSeriesTypeModel carSeriesTypeModelWithDictionary:dict];
                [serieArray addObject:serie];
            }
            showCarList(serieArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }

    }];
}

#pragma --
#pragma mark//获取所有车型的外观颜色集合
+ (void)postGetAllTheModelsTheAppearanceOfTheColorSetRequestWithCarUserId:(NSString *)userId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId};
    //            NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@configuration/get_car_exterior_color_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
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
            NSMutableArray *exteriorArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *dict in array) {
                ExteriorColorModel *exterior = [ExteriorColorModel exteriorColorModelWithDictionary:dict];
                [exteriorArray addObject:exterior];
            }
            showCarList(exteriorArray,nil, string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            showCarList(nil,nil, nil);
        }
        
    }];
}

#pragma --
#pragma mark//获取所有车型的内饰颜色集合
+ (void)postGetAllTheModelsOfInteriorColorSetRequestWithCarUserId:(NSString *)userId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId};
    //            NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@configuration/get_car_interior_color_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
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
            NSMutableArray *interiorArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *dict in array) {
                InteriorColorModel *interior = [InteriorColorModel interiorColorModelWithDictionary:dict];
                [interiorArray addObject:interior];
            }
            showCarList(interiorArray,nil, string);
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
