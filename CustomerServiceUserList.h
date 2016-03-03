//
//  CustomerServiceUserList.h
//  CarSource
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerServiceUserList : NSObject
@property (nonatomic,strong)NSString *customerServiceUserId,*customerServiceUserName,*customerServiceUserTel,*customerServiceUserUrl;
+ (CustomerServiceUserList *)customerServiceUserListWithDictionary:(NSDictionary *)dict;
@end
