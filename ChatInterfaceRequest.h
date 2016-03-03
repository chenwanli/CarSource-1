//
//  ChatInterfaceRequest.h
//  CarSource
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatInterfaceRequest : NSObject
//我的好友列表
+ (void)postMyGoodFriendListRequestWithUserId:(NSString *)userId Completion:(requestComplete)completion;
@end
