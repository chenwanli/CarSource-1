//
//  RequestClass.m
//  CarSource
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RequestClass.h"
#import "AFNetworking.h"
#import "LoginModel.h"
#import "UserDataModel.h"
#import "UserAddress.h"
#import "SalasTelModel.h"
#import "UserBankAccount.h"

#define RESULTCODE @"0"
@implementation RequestClass
#pragma --
#pragma mark// 手机短信验证
+ (void)postSMSVerificationRequestWithTel:(NSString *)tel type:(NSString *)type  Completion:(requestComplete)completion{
    NSString *string;

    NSDictionary * parameters = @{@"tel": tel };
    if (type != nil) {
        //         注册验证接口
        string = @"users/sms";
    }else{
        //        用户修改密码验证接口
        string = @"users/set_password_sms";
    }

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@%@",HTTPREQUEST,string] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

//        NSLog(@"%@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
             completion(nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取验证码失败" zoom:NO shadow:NO];
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
#pragma mark// 注册
+ (void)postRegisteredRequestWithTel:(NSString *)tel type:(NSString *)type password:(NSString *)password  code:(NSString *)code Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"tel": tel ,@"type": type,@"password": password,@"code": code};
//    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/registered",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

//        NSLog(@"%@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
             completion(nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"提交失败" zoom:NO shadow:NO];
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
#pragma mark// 登陆
+ (void)postLoginRequestWithTel:(NSString *)tel password:(NSString *)password  Completion:(requestComplete)completion{
    NSDictionary * parameters = @{@"tel": tel, @"password": password };
//    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/login",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

//        NSLog(@"%@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {


            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"登录失败" zoom:NO shadow:NO];
            }

            completion(nil,string);
        }else{
            NSMutableArray *loginArray = [NSMutableArray array];
            LoginModel *login = [[LoginModel alloc]init];
            login.userText = data[@"data"][@"userText"];//用户签名
            login.userTel = data[@"data"][@"userTel"];//用户手机号
            login.userName = data[@"data"][@"userName"];//用户名称
            login.userId = data[@"data"][@"userId"];//用户ID
            login.userUrl = data[@"data"][@"userUrl"];//用户头像
            login.userMoney = data[@"data"][@"userMoney"];//用户金额
            login.userTypeId = data[@"data"][@"userTypeId"];//用户类型
            login.userBackGround = data[@"data"][@"userBackGround"];//用户背景图
            [loginArray removeAllObjects];
            [loginArray addObject:login];
             completion(loginArray,string);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            completion(nil,nil);
        }

    }];
}
#pragma --
#pragma mark// 找回用户密码
+ (void)postUserPasswordBackRequestWithTel:(NSString *)tel password:(NSString *)password code:(NSString *)code Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"tel": tel ,@"newPassword": password,@"code": code};
//    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/retrieve_password",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

//        NSLog(@"%@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
             completion(nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"找回密码失败" zoom:NO shadow:NO];
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
#pragma mark// 修改用户头像
+ (void)postModifyTheUserHeadRequestWithUserId:(NSString *)userId image:(UIImage *)image Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId": userId};
//    NSLog(@"%@",parameters );

    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@users/set_user_url",HTTPREQUEST] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } error:nil];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSProgress *progress = nil;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {

    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
//        NSLog(@"32423423==%@",responseObject);
        NSMutableArray *dictArray = [responseObject objectForKey:@"code"];
        NSMutableArray *dctArray = [responseObject objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE]) {
            completion(nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"上传失败" zoom:NO shadow:NO];
            }
        }else{
            LoginModel *login = [[LoginModel alloc]init];
            login.userUrl = responseObject[@"data"];
            [array removeAllObjects];
            [array addObject:login];
            completion(array,string);
        }

        if (error)
        {
            [self checkNetWorkStatus];
        }


    }];
    [uploadTask resume];
}

#pragma --
#pragma mark// 修改用户背景图
+ (void)postModifyTheUserBackgroundRequestWithUserId:(NSString *)userId image:(UIImage *)image Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId":userId};
//    NSLog(@"%@",parameters );

    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@users/set_user_background",HTTPREQUEST] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } error:nil];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //    NSProgress *progress = nil;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {

    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
//        NSLog(@"32423423==%@",responseObject);
        NSMutableArray *dictArray = [responseObject objectForKey:@"code"];
        NSMutableArray *dctArray = [responseObject objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE]) {
            completion(nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"上传失败" zoom:NO shadow:NO];
            }
        }else{
            LoginModel *login = [[LoginModel alloc]init];
            login.userBackGround = responseObject[@"data"];
            [array removeAllObjects];
            [array addObject:login];
            completion(array,string);
        }

        if (error)
        {
            [self checkNetWorkStatus];
        }
        
        
    }];
    [uploadTask resume];
}

#pragma --
#pragma mark// 根据用户ID获取用户资料
+ (void)postUserDataRequestWithUserId:(NSString *)userId Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId":userId };
    //    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/show",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

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
                [LCCoolHUD showFailure:@"获取资料失败" zoom:NO shadow:NO];
            }

        }else{


            NSDictionary *userDict = data[@"data"];
            NSMutableArray *userArray = [NSMutableArray array];
            UserDataModel *store = [UserDataModel userDataModelWithDictionary:userDict];
            [userArray addObject:store];
//            NSLog(@"userArray = %@",userArray);
            completion(userArray,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self checkNetWorkStatus];
            completion(nil,nil);
        }
        
    }];
}

#pragma --
#pragma mark// 修改用户资料接口
+ (void)postModifyTheUserDataInterfaceRequestWithUserId:(NSString *)userId userName:(NSString *)userName userText:(NSString *)userText  companyPosition:(NSString *)companyPosition companyName:(NSString *)companyName addressArea:(NSString *)addressArea Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId": userId ,@"userName":userName ,@"userText":userText ,@"companyPosition": companyPosition,@"companyName": companyName,@"addressArea": addressArea};
//    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/set_user",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

        //        NSLog(@"%@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",data);
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
#pragma mark// 修改密码
+ (void)postChangeThePasswordRequestWithUserId:(NSString *)userId password:(NSString *)password newPassword:(NSString *)newPassword Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId": userId ,@"password":password,@"newPassword":newPassword };
    //    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/set_password",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

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
                [LCCoolHUD showFailure:@"修改密码失败" zoom:NO shadow:NO];
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
#pragma mark// 我的服务
+ (void)postMyServiceRequestWithUserId:(NSString *)userId request:(request)request{
    NSDictionary *parameters = @{@"userId":userId};
    //    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/get_user_service",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

        //        NSLog(@"%@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" data = %@",data);
        NSMutableArray *dictArray = [data objectForKey:@"code"];
        NSMutableArray *dctArray = [data objectForKey:@"msg"];
        NSString *string = [NSString stringWithFormat:@"%@",dictArray];
        NSString *resultMessage = [NSString stringWithFormat:@"%@",dctArray];
        if (![string isEqualToString:RESULTCODE] ) {
            request(nil,nil,nil,nil,string);
            if (![resultMessage isEqualToString:@"(null)"]) {
                SHOW_ALERT( resultMessage)
            }else{
                [LCCoolHUD showFailure:@"获取资料失败" zoom:NO shadow:NO];
            }

        }else{

//            NSMutableArray *addressArray = [NSMutableArray array];
            NSMutableArray *salasArray = data[@"data"][@"salesTel"];
            NSMutableArray *bankArray = [NSMutableArray array];
//            NSMutableArray *typeArray = [NSMutableArray array];
            NSMutableArray *bankArr = data[@"data"][@"userBankAccountlist"];

            for (NSDictionary *bankDict in bankArr) {
                UserBankAccount *userBank = [UserBankAccount userBankAccountModelWithDictionary:bankDict];
                [bankArray addObject:userBank];
            }

            request(nil,nil,salasArray,bankArray,string);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            request(nil,nil,nil,nil,nil);
            [self checkNetWorkStatus];

        }
        
    }];
}
#pragma --
#pragma mark// 绑定销售用户
+ (void)postBindingSalesUsersdRequestWithUserId:(NSString *)userId salasTel:(NSString *)salasTel Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId":userId ,@"salesTel":salasTel};
//        NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/add_sales_user",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
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
                [LCCoolHUD showFailure:@"添加失败" zoom:NO shadow:NO];
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
#pragma mark//添加或修改企业银行卡
+ (void)postEnterpriseBankCardRequestWithUserId:(NSString *)userId bankAccountNumber:(NSString *)bankAccountNumber bankAccountName:(NSString *)bankAccountName bankAccountText:(NSString *)bankAccountText  Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId":userId ,@"bankAccountNumber":bankAccountNumber,@"bankAccountName":bankAccountName,@"bankAccountText":bankAccountText};
    //        NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/add_bank_card_account",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
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
                [LCCoolHUD showFailure:@"添加失败" zoom:NO shadow:NO];
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
#pragma mark// 删除绑定的销售用户
+ (void)postRemoveTheBindingSalesUsersRequestWithUserId:(NSString *)userId salasTel:(NSString *)salasTel Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId":userId ,@"salesTel":salasTel};
    //        NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/delete_sales_user",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
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
#pragma mark// 删除用户企业银行卡信息
+ (void)postDeleteUserBusinessCardInformationRequestWithUserId:(NSString *)userId bankAccountId:(NSString *)bankAccountId Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId":userId ,@"bankAccountId":bankAccountId};
    //        NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@users/delete_bank_card_account",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
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
