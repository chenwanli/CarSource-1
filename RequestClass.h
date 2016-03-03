//
//  RequestClass.h
//  CarSource
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^requestComplete) (NSMutableArray *saleArray,NSString *errorMessage);
typedef void (^request) (NSMutableArray *saleArray,NSMutableArray *areaArray,NSMutableArray *salesArray,NSMutableArray *userBankArray,NSString *errorMessage);
@interface RequestClass : NSObject
// 手机短信验证
+ (void)postSMSVerificationRequestWithTel:(NSString *)tel type:(NSString *)type  Completion:(requestComplete)completion;
// 注册
+ (void)postRegisteredRequestWithTel:(NSString *)tel type:(NSString *)type password:(NSString *)password  code:(NSString *)code Completion:(requestComplete)completion;
// 登陆
+ (void)postLoginRequestWithTel:(NSString *)tel password:(NSString *)password  Completion:(requestComplete)completion;
// 找回用户密码
+ (void)postUserPasswordBackRequestWithTel:(NSString *)tel password:(NSString *)password code:(NSString *)code Completion:(requestComplete)completion;
// 修改用户头像
+ (void)postModifyTheUserHeadRequestWithUserId:(NSString *)userId image:(UIImage *)image Completion:(requestComplete)completion;
// 修改用户背景图
+ (void)postModifyTheUserBackgroundRequestWithUserId:(NSString *)userId image:(UIImage *)image Completion:(requestComplete)completion;
// 根据用户ID获取用户资料
+ (void)postUserDataRequestWithUserId:(NSString *)userId Completion:(requestComplete)completion;
// 修改用户资料接口
+ (void)postModifyTheUserDataInterfaceRequestWithUserId:(NSString *)userId userName:(NSString *)userName userText:(NSString *)userText  companyPosition:(NSString *)companyPosition companyName:(NSString *)companyName addressArea:(NSString *)addressArea Completion:(requestComplete)completion;
// 修改密码
+ (void)postChangeThePasswordRequestWithUserId:(NSString *)userId password:(NSString *)password newPassword:(NSString *)newPassword Completion:(requestComplete)completion;
// 我的服务
+ (void)postMyServiceRequestWithUserId:(NSString *)userId request:(request)request;
// 绑定销售用户
+ (void)postBindingSalesUsersdRequestWithUserId:(NSString *)userId salasTel:(NSString *)salasTel Completion:(requestComplete)completion;
//添加或修改企业银行卡
+ (void)postEnterpriseBankCardRequestWithUserId:(NSString *)userId bankAccountNumber:(NSString *)bankAccountNumber bankAccountName:(NSString *)bankAccountName bankAccountText:(NSString *)bankAccountText  Completion:(requestComplete)completion;
// 删除绑定的销售用户
+ (void)postRemoveTheBindingSalesUsersRequestWithUserId:(NSString *)userId salasTel:(NSString *)salasTel Completion:(requestComplete)completion;
// 删除用户企业银行卡信息
+ (void)postDeleteUserBusinessCardInformationRequestWithUserId:(NSString *)userId bankAccountId:(NSString *)bankAccountId Completion:(requestComplete)completion;
@end
