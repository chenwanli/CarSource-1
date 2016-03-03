//
//  MyInformationRequest.m
//  CarSource
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyInformationRequest.h"
#import "AFNetworking.h"
#import "MySalesListModel.h"
#import "findCarModel.h"
#import "OtherGuaranteeModel.h"
#import "SalesListModel.h"
#import "RecentlySecuredModel.h"
#define RESULTCODE @"0"

@implementation MyInformationRequest
#pragma --
#pragma mark// 获取我的销售列表
+ (void)postGetMySalesListRequestWithUserId:(NSString *)userId page:(NSString *)page Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId":userId,@"page":page};
    //    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@sales/get_user_sales_car_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

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
                [LCCoolHUD showFailure:@"获取销售信息失败" zoom:NO shadow:NO];
            }

        }else{

            NSMutableArray *salesArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *salesDict in array) {
                SalesListModel *carSerie = [SalesListModel salesListModelWithDictionary:salesDict];
                [salesArray addObject:carSerie];
            }
            completion(salesArray,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            completion(nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark//删除我的销售信息
+ (void)postDeleteMySalesInformationRequestWithUserId:(NSString *)userId salesId:(NSString *)salesId Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId": userId,@"salesId":salesId};
    //    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@sales/delete_sales_car",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            completion(nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"删除失败" zoom:NO shadow:NO];
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
#pragma mark// 获取我的寻车信息列表
+ (void)postIFoundTheCarInformationListRequestWithUserId:(NSString *)userId page:(NSString *)page Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId":userId,@"page":page};
    //    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@search_car/get_user_search_car_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

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
                [LCCoolHUD showFailure:@"获取寻车信息失败" zoom:NO shadow:NO];
            }

        }else{

            NSMutableArray *findArr = data[@"data"];
            NSMutableArray *findArray = [NSMutableArray array];

            for (NSDictionary *dict in findArr) {
                findCarModel *find = [findCarModel findCarModelWithDictionary:dict];
                [findArray addObject:find];
            }
            //            NSLog(@"userArray = %@",userArray);
            completion(findArray,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            completion(nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark//删除我的寻车信息
+ (void)postDeleteMyCarInformationRequestWithUserId:(NSString *)userId salesId:(NSString *)salesId Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId": userId,@"searchCarId":salesId};
    //    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@search_car/delete_user_search_car",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //                        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            completion(nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"删除失败" zoom:NO shadow:NO];
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
#pragma mark// 获取向我发起的担保
+ (void)postGetToMeByGuaranteeRequestWithUserId:(NSString *)userId page:(NSString *)page Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId":userId,@"page":page};
    //    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@guarantee/get_other_side_user_guarantee_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

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
                [LCCoolHUD showFailure:@"获取对方担保信息失败" zoom:NO shadow:NO];
            }

        }else{

            NSMutableArray *guaranteeArr = data[@"data"];
            NSMutableArray *guaranteeArray = [NSMutableArray array];

            for (NSDictionary *dict in guaranteeArr) {
                OtherGuaranteeModel *guarantee = [OtherGuaranteeModel otherGuaranteeModelWithDictionary:dict];
                [guaranteeArray addObject:guarantee];
            }
            //            NSLog(@"userArray = %@",userArray);
            completion(guaranteeArray,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            completion(nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark//删除担保
+ (void)postDeleteTheGuaranteeRequestWithUserId:(NSString *)userId vouchTransactionId:(NSString *)vouchTransactionId Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId": userId,@"vouchTransactionId":vouchTransactionId};
    //    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@guarantee/delete_guarantee",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"%@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                                NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            completion(nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"删除失败" zoom:NO shadow:NO];
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
#pragma mark// 获取我的担保列表
+ (void)postToObtainAListOfMyGuaranteeRequestWithUserId:(NSString *)userId page:(NSString *)page Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId":userId,@"page":page};
    //    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@guarantee/get_user_guarantee_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

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
                [LCCoolHUD showFailure:@"获取我的担保信息失败" zoom:NO shadow:NO];
            }

        }else{

            NSMutableArray *guaranteeArr = data[@"data"];
            NSMutableArray *guaranteeArray = [NSMutableArray array];

            for (NSDictionary *dict in guaranteeArr) {
                OtherGuaranteeModel *guarantee = [OtherGuaranteeModel otherGuaranteeModelWithDictionary:dict];
                [guaranteeArray addObject:guarantee];
            }
            //            NSLog(@"userArray = %@",userArray);
            completion(guaranteeArray,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            completion(nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark// 获取我的最近交易担保列表
+ (void)postToObtainAListOfMyRecentTradingGuaranteeRequestWithCompletion:(requestComplete)completion{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@guarantee/guarantee_list",HTTPREQUEST] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {

        //        NSLog(@"%@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            completion(nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取我的担保信息失败" zoom:NO shadow:NO];
            }

        }else{

            NSMutableArray *recentlyArr = data[@"data"];
            NSMutableArray *recentlyArray = [NSMutableArray array];

            for (NSDictionary *dict in recentlyArr) {
                RecentlySecuredModel *recently = [RecentlySecuredModel recentlySecuredModelWithDictionary:dict];
                [recentlyArray addObject:recently];
            }
            //            NSLog(@"userArray = %@",userArray);
            completion(recentlyArray,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            completion(nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark//添加车展信息
+ (void)postAddTheShowInformationRequestWithUserId:(NSString *)userId carSeriesTypeId:(NSString *)carSeriesTypeId imageArray:(NSMutableArray *)imageArray price:(NSString *)price  introduction:(NSString *)introduction colour:(NSString *)colour specificationId:(NSString *)specificationId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"carSeriesTypeId":carSeriesTypeId,@"price":price,@"introduction":introduction,@"colour":colour,@"specificationId":specificationId};

//        NSLog(@"parameters %@",parameters);

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@showroom/add_show_car",HTTPREQUEST] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
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
                [LCCoolHUD showFailure:@"展车发布失败" zoom:NO shadow:NO];
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
#pragma mark//添加交车
+ (void)postAddInTheCarRequestWithUserId:(NSString *)userId transactionVehiclesTime:(NSString *)transactionVehiclesTime imageArray:(NSMutableArray *)imageArray transactionVehiclesIntroduction:(NSString *)transactionVehiclesIntroduction  transactionVehiclesCarSeriesTypeId:(NSString *)transactionVehiclesCarSeriesTypeId  transactionVehiclesShowroomId:(NSString *)transactionVehiclesShowroomId transactionVehiclesSpecificationId:(NSString *)transactionVehiclesSpecificationId showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"transactionVehiclesTime":transactionVehiclesTime,@"transactionVehiclesIntroduction":transactionVehiclesIntroduction,@"transactionVehiclesCarSeriesTypeId":transactionVehiclesCarSeriesTypeId ,@"transactionVehiclesShowroomId":transactionVehiclesShowroomId,@"transactionVehiclesSpecificationId":transactionVehiclesSpecificationId};

//        NSLog(@"parameters %@",parameters);

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@showroom/add_transaction_vehicles",HTTPREQUEST] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
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
                [LCCoolHUD showFailure:@"交车发布失败" zoom:NO shadow:NO];
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
#pragma mark//添加或修改用户身份信息
+ (void)postToAddOrModifyTheUserIdentityInformationRequestWithUserId:(NSString *)userId identityInformationName:(NSString *)identityInformationName imageArray:(NSMutableArray *)imageArray identityInformationNumber:(NSString *)identityInformationNumber showCarList:(showCarList)showCarList{
    NSDictionary *parameters = @{@"userId":userId,@"identityInformationName":identityInformationName,@"identityInformationNumber":identityInformationNumber};

//            NSLog(@"parameters %@",parameters);

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@users/set_identity_information",HTTPREQUEST] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
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
                [LCCoolHUD showFailure:@"提交信息失败" zoom:NO shadow:NO];
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
