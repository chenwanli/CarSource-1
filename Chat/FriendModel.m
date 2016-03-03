//
//  FriendModel.m
//  CarSource
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel
+ (FriendModel *)friendModelModelWithDictionary:(NSDictionary *)dict{
    FriendModel *friend = [[FriendModel alloc]init];
    friend.userFriendsId = dict[@"userFriendsId"];//好友ID(用于修改备注或删除)
    friend.userFriendsRemark = dict[@"userFriendsRemark"];//备注
    friend.userFriendsUserId = dict[@"userFriendsUserId"];
    friend.userFriendsUserName = dict[@"userFriendsUserName"];//好友昵称
    friend.userFriendsUserTel = dict[@"userFriendsUserTel"];//好友手机号
    friend.userFriendsUserUrl = dict[@"userFriendsUserUrl"];//好友头像
    friend.userInitials = dict[@"userInitials"];

    return friend;
}

@end
