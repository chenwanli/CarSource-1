//
//  UserInformation.h
//  CarSource
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformation : NSObject
@property (nonatomic,strong)NSString *userName,*userTel,*userUrl;
@property (nonatomic,strong)NSMutableArray *userAuthenticateList;
+ (UserInformation *)userInformationWithDictionary:(NSDictionary *)dict;
@end
