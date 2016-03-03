//
//  ChatInterfaceRequest.m
//  CarSource
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChatInterfaceRequest.h"
#import "AFNetworking.h"
#import "FriendModel.h"

#define RESULTCODE @"0"
@implementation ChatInterfaceRequest

#pragma --
#pragma mark//我的好友列表
+ (void)postMyGoodFriendListRequestWithUserId:(NSString *)userId Completion:(requestComplete)completion{
    NSDictionary *parameters = @{@"userId": userId};
    //    NSLog(@"%@",parameters );
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:[NSString stringWithFormat:@"%@friends/get_user_friends_list",HTTPREQUEST] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
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
                [LCCoolHUD showFailure:@"获取好友列表失败" zoom:NO shadow:NO];
            }

        }else{

            NSMutableArray *friendArray = [NSMutableArray array];
            NSMutableArray *array = data[@"data"];
            for (NSDictionary *dict in array) {
                FriendModel *friend = [FriendModel friendModelModelWithDictionary:dict];
                [friendArray addObject:friend];
            }
            completion(friendArray,string);
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
