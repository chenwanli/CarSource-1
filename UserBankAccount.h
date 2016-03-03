//
//  UserBankAccount.h
//  CarSource
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 apple. All rights reserved.
//
// 我的服务 用户银行卡信息
#import <Foundation/Foundation.h>

@interface UserBankAccount : NSObject
@property (nonatomic,strong)NSString *bankAccountNumber,*bankAccountName,*bankAccountText,*bankAccountId;
+ (UserBankAccount *)userBankAccountModelWithDictionary:(NSDictionary *)dict;
@end
