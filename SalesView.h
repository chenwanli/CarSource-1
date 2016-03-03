//
//  SalesView.h
//  CarSource
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^brandTag) (NSInteger brandTag);
typedef void (^imageUrlArr) (NSMutableArray *imageArray ,NSInteger imageCount);
typedef void (^searchStr) (NSString *string);
typedef void (^details) (NSMutableArray *array);
@interface SalesView : UIView
@property (nonatomic,strong)brandTag brandTag;
@property (nonatomic,strong)imageUrlArr imageUrlArr;
@property (nonatomic,strong)searchStr searchStr;
@property (nonatomic,strong)details details;
- (void)provincesStr:(NSString *)provincesStr provincesIdStr:(NSString *)provincesIdStr areaStr:(NSString *)areaStr;//选择区域
- (void)initMemberType:(NSString *)memberType memberTypeId:(NSString *)memberTypeId;//选择会员
- (void)initVehicleId:(NSString *)vehicleId vehicleName:(NSString *)vehicleName specificationId:(NSString *)specificationId;//选择品牌
- (void)initReleaseSalesViewControllerCount:(NSInteger)count;//发布成功刷新表
- (void)installationMJRefresh;//重新获取默认销售列表
//搜索
- (void)searchName:(NSString *)name string:(NSString *)string;
@end
