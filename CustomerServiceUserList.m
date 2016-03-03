//
//  CustomerServiceUserList.m
//  CarSource
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 apple. All rights reserved.
//
//客服列表
#import "CustomerServiceUserList.h"

@implementation CustomerServiceUserList
+ (CustomerServiceUserList *)customerServiceUserListWithDictionary:(NSDictionary *)dict{
    CustomerServiceUserList *list = [[CustomerServiceUserList alloc]init];
    list.customerServiceUserName = dict[@"customerServiceUserName"];//客服昵称
    list.customerServiceUserId = dict[@"customerServiceUserId"];//客服ID
    list.customerServiceUserTel = dict[@"customerServiceUserTel"];//客服电话
    list.customerServiceUserUrl = dict[@"customerServiceUserUrl"];//客服头像
    return list;
}
@end
