//
//  UserBankAccount.m
//  CarSource
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserBankAccount.h"

@implementation UserBankAccount
+ (UserBankAccount *)userBankAccountModelWithDictionary:(NSDictionary *)dict{
    UserBankAccount *bank = [[UserBankAccount alloc]init];
    bank.bankAccountNumber = dict[@"bankAccountNumber"];//银行账户 号码
    bank.bankAccountName = dict[@"bankAccountName"];//银行卡开户人姓名姓名
    bank.bankAccountText = dict[@"bankAccountText"];//开户银行
    bank.bankAccountId = dict[@"bankAccountId"];
    return bank;
}
@end
