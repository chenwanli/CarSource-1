//
//  MyInformationRequest.h
//  CarSource
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInformationRequest : NSObject
// 获取我的销售列表
+ (void)postGetMySalesListRequestWithUserId:(NSString *)userId page:(NSString *)page Completion:(requestComplete)completion;
//删除我的销售信息
+ (void)postDeleteMySalesInformationRequestWithUserId:(NSString *)userId salesId:(NSString *)salesId Completion:(requestComplete)completion;
// 获取我的寻车信息列表
+ (void)postIFoundTheCarInformationListRequestWithUserId:(NSString *)userId page:(NSString *)page Completion:(requestComplete)completion;
//删除我的寻车信息
+ (void)postDeleteMyCarInformationRequestWithUserId:(NSString *)userId salesId:(NSString *)salesId Completion:(requestComplete)completion;
// 获取向我发起的担保
+ (void)postGetToMeByGuaranteeRequestWithUserId:(NSString *)userId page:(NSString *)page Completion:(requestComplete)completion;
//删除担保
+ (void)postDeleteTheGuaranteeRequestWithUserId:(NSString *)userId vouchTransactionId:(NSString *)vouchTransactionId Completion:(requestComplete)completion;
// 获取我的担保列表
+ (void)postToObtainAListOfMyGuaranteeRequestWithUserId:(NSString *)userId page:(NSString *)page Completion:(requestComplete)completion;
// 获取我的最近交易担保列表
+ (void)postToObtainAListOfMyRecentTradingGuaranteeRequestWithCompletion:(requestComplete)completion;
//添加车展信息
+ (void)postAddTheShowInformationRequestWithUserId:(NSString *)userId carSeriesTypeId:(NSString *)carSeriesTypeId imageArray:(NSMutableArray *)imageArray price:(NSString *)price  introduction:(NSString *)introduction colour:(NSString *)colour specificationId:(NSString *)specificationId showCarList:(showCarList)showCarList;
//添加交车
+ (void)postAddInTheCarRequestWithUserId:(NSString *)userId transactionVehiclesTime:(NSString *)transactionVehiclesTime imageArray:(NSMutableArray *)imageArray transactionVehiclesIntroduction:(NSString *)transactionVehiclesIntroduction  transactionVehiclesCarSeriesTypeId:(NSString *)transactionVehiclesCarSeriesTypeId  transactionVehiclesShowroomId:(NSString *)transactionVehiclesShowroomId transactionVehiclesSpecificationId:(NSString *)transactionVehiclesSpecificationId showCarList:(showCarList)showCarList;
//添加或修改用户身份信息
+ (void)postToAddOrModifyTheUserIdentityInformationRequestWithUserId:(NSString *)userId identityInformationName:(NSString *)identityInformationName imageArray:(NSMutableArray *)imageArray identityInformationNumber:(NSString *)identityInformationNumber showCarList:(showCarList)showCarList;
@end
