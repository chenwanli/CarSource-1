//
//  FriendModel.h
//  CarSource
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject
@property (nonatomic,strong)NSString *userFriendsId,*userFriendsRemark,*userFriendsUserId,*userFriendsUserName,*userFriendsUserTel,*userFriendsUserUrl,*userInitials;
+ (FriendModel *)friendModelModelWithDictionary:(NSDictionary *)dict;
@end
