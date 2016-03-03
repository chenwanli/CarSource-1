//
//  ResourcesRequest.h
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResourcesRequest : NSObject
//获取车系详细信息
+ (void)postForCarsThatDetailedInformationRequestWithCarSeriesId:(NSString *)carSeriesId showCarList:(showCarList)showCarList;
//获取我的销售列表
+ (void)postGetMySalesListRequestWithCarUserId:(NSString *)userId page:(NSString *)page showCarList:(showCarList)showCarList;
//获取城市中 省 列表
+ (void)postListForProvinceInTheCityWithCarShowCarList:(showCarList)showCarList;
//根据用户所在区域获取发布销售车辆列表
+ (void)postAccordingToTheUsersAreaToObtainAListReleasedSalesVehiclesWithUserId:(NSString *)userId city:(NSString *)city area:(NSString *)area page:(NSString *)page showCarList:(showCarList)showCarList;
//获取用户类型
+ (void)postGetTheUserTypesRequestWithShowCarList:(showCarList)showCarList;
//根据用户会员类型获取发布销售车辆列表
+ (void)postDependingOnTheTypeOfUserMembersToObtainAListReleasedSalesVehiclesReleasedSalesVehiclesWithUserId:(NSString *)userId userITyped:(NSString *)userITyped  page:(NSString *)page showCarList:(showCarList)showCarList;
//根据车品牌获取发布销售车辆列表
+ (void)postAccordingToTheCarBrandToObtainAListReleasedSalesVehiclesWithUserId:(NSString *)userId specificationId:(NSString *)specificationId  brandId:(NSString *)brandId page:(NSString *)page showCarList:(showCarList)showCarList;
//获取默认寻车列表
+ (void)postGetTheDefaultSearchListRequestWithPage:(NSString *)page showCarList:(showCarList)showCarList;
//获取指定地区 寻车列表
+ (void)postToObtainAListSpecifiedAreasForCarRequestWithCity:(NSString *)city area:(NSString *)area page:(NSString *)page showCarList:(showCarList)showCarList;
//获取指定品牌寻车列表
+ (void)postToObtainAListSpecifiedBrandForTheCarRequestWithBrandId:(NSString *)brandId specificationId:(NSString *)specificationId page:(NSString *)page showCarList:(showCarList)showCarList;
//添加中规寻车
+ (void)postAddRulesFoundInCarsRequestWithUserId:(NSString *)userId text:(NSString *)text userTypeId:(NSString *)userTypeId seriesTypeId:(NSString *)seriesTypeId specificationId:(NSString *)specificationId showCarList:(showCarList)showCarList;
//发布普通销售车辆
+ (void)postIssuedOrdinarySalesVehiclesRequestWithUserId:(NSString *)userId text:(NSString *)text imageArray:(NSMutableArray *)imageArray brandId:(NSString *)brandId userTypeId:(NSString *)userTypeId showCarList:(showCarList)showCarList;
//发布普通销售车辆
+ (void)postParallelImportSalesVehiclesRequestWithUserId:(NSString *)userId salesText:(NSString *)salesText imageArray:(NSMutableArray *)imageArray carsSalesModelsId:(NSString *)carsSalesModelsId salesCarsType:(NSString *)salesCarsType colour:(NSString *)colour salesSpecificationId:(NSString *)salesSpecificationId salesShelfNumber:(NSString *)salesShelfNumber salesImportedCarsPrice:(NSString *)salesImportedCarsPrice showCarList:(showCarList)showCarList;
//发起担保
+ (void)postAGuaranteeRequestWithUserId:(NSString *)userId vouchTransactionCarSeriesTypeId:(NSString *)vouchTransactionCarSeriesTypeId imageArray:(NSMutableArray *)imageArray vouchTransactionColour:(NSString *)vouchTransactionColour  vouchTransactionDealPrice:(NSString *)vouchTransactionDealPrice vouchTransactionGuaranteeDepositPrice:(NSString *)vouchTransactionGuaranteeDepositPrice vouchTransactionText:(NSString *)vouchTransactionText tel:(NSString *)tel showCarList:(showCarList)showCarList;
//获取寻车列表
+ (void)postToObtainAListForCarRequestWithUserId:(NSString *)userId brandId:(NSString *)brandId specificationId:(NSString *)specificationId city:(NSString *)city area:(NSString *)area  page:(NSString *)page showCarList:(showCarList)showCarList;
//发布销售车辆列表
+ (void)postListReleasedSalesVehiclesRequestWithCarUserId:(NSString *)userId city:(NSString *)city area:(NSString *)area  page:(NSString *)page userITyped:(NSString *)userITyped specificationId:(NSString *)specificationId  brandId:(NSString *)brandId text:(NSString *)text showCarList:(showCarList)showCarList;
//搜索
+ (void)postSearchRequestWithText:(NSString *)text page:(NSString *)page showCarList:(showCarList)showCarList;
@end
