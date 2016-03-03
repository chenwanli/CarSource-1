//
//  NetworkRequest.h
//  CarSource
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^showCarList) (NSMutableArray *saleArray,NSString *showCarList, NSString *errorMessage);
@interface NetworkRequest : NSObject
// 获取首页信息
+ (void)postForInformationOnTheHomepageRequestWithUserId:(NSString *)userId request:(request)request;
// 我的展厅
+ (void)postMyShowroomRequestWithUserId:(NSString *)userId  showCarList:(showCarList)showCarList;
// 获取展厅信息
+ (void)postExhibitionInformationRequestWithUserId:(NSString *)userId showroomId:(NSString *)showroomId Completion:(requestComplete)completion;
// 修改展厅
+ (void)postModifyTheShowroomRequestWithUserId:(NSString *)userId showroomId:(NSString *)showroomId  introduction:(NSString *)introduction address:(NSString *)address empirical:(NSString *)empirical Completion:(requestComplete)completion;
// 车展列表信息
+ (void)postShowAListOfInformationRequestWithUserId:(NSString *)userId showroomId:(NSString *)showroomId  page:(NSString *)page showCarList:(showCarList)showCarList;
// 删除指定用户车展信息
+ (void)postDeleteTheSpecifiedUserShowInformationRequestWithUserId:(NSString *)userId showroomId:(NSString *)showroomId  showCarList:(showCarList)showCarList;
// 交车列表信息
+ (void)postPayTheCarListInformationRequestWithUserId:(NSString *)userId showroomId:(NSString *)showroomId  page:(NSString *)page showCarList:(showCarList)showCarList;
// 删除交车记录
+ (void)postDeleteCarRecordsRequestWithUserId:(NSString *)userId transactionVehiclesId:(NSString *)transactionVehiclesId Completion:(requestComplete)completion;
// 查看指定车展信息
+ (void)postViewTheInformationSpecifiedMotorShowRequestWithShowCarId:(NSString *)showCarId showCarList:(showCarList)showCarList;
// 交车信息详情
+ (void)postForDetailsInformationRequestWithUserId:(NSString *)userId transactionVehiclesId:(NSString *)transactionVehiclesId showCarList:(showCarList)showCarList;
// 添加车展信息
+ (void)postAddTheShowInformationRequestWithUserId:(NSString *)userId modelsId:(NSString *)modelsId  interiorColourId:(NSString *)interiorColourId exteriorColourId:(NSString *)exteriorColourId  price:(NSString *)price  introduction:(NSString *)introduction urlArr:(NSString *)urlArr showCarList:(showCarList)showCarList;
//获取指定规格品牌
+ (void)postSpecifyTheSpecificationsBrandRequestWithUserId:(NSString *)userId specificationId:(NSString *)specificationId showCarList:(showCarList)showCarList;
//指定规格品牌
+ (void)postSpecificationsBrandRequestWithBrandId:(NSString *)brandId specificationId:(NSString *)specificationId showCarList:(showCarList)showCarList;
//获取所有品牌集合
+ (void)postGetAllTheBrandCollectionsRequestWithUserId:(NSString *)userId showCarList:(showCarList)showCarList;
//获取所有规格集合
+ (void)postGetAllTheSpecificationsSetRequestWithUserId:(NSString *)userId showCarList:(showCarList)showCarList;
//获取指定品牌的所有车系
+ (void)postSpecifiedBrandForAllCarsRequestWithBrandId:(NSString *)brandId showCarList:(showCarList)showCarList;
//获取指定车系中的所有车型
+ (void)postAccessToSpecifyAllTheModelsInTheCarsRequestWithCarSeriesId:(NSString *)carSeriesId showCarList:(showCarList)showCarList;
//获取所有车型的外观颜色集合
+ (void)postGetAllTheModelsTheAppearanceOfTheColorSetRequestWithCarUserId:(NSString *)userId showCarList:(showCarList)showCarList;
//获取所有车型的内饰颜色集合
+ (void)postGetAllTheModelsOfInteriorColorSetRequestWithCarUserId:(NSString *)userId showCarList:(showCarList)showCarList;
@end
