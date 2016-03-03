//
//  ResourcesViewController.h
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^releaseTag) (NSInteger releaseTag);
typedef void (^guarantee) (NSString *guarantee);
typedef void (^brandTag) (NSInteger brandBtn);
typedef void (^brand) (NSInteger brand);
typedef void (^imageUrlArray) (NSMutableArray *arr,NSInteger count);
typedef void (^search) (NSString *str);
typedef void (^details) (NSMutableArray *detailsArray);
@interface ResourcesViewController : UIViewController
@property (nonatomic,strong)releaseTag releaseTag;
@property (nonatomic,strong)guarantee guarantee;
@property (nonatomic,strong)brandTag brandTag;
@property (nonatomic,strong)brand brand;
@property (nonatomic,strong)imageUrlArray imageUrlArray;
@property (nonatomic,strong)search search;
@property (nonatomic,strong)details details;

- (void)initProvincesStr:(NSString *)provincesStr provincesIdStr:(NSString *)provincesIdStr areaStr:(NSString *)areaStr isAop:(BOOL)isAop;// 选择区域

- (void)initMemberType:(NSString *)memberType memberTypeId:(NSString *)memberTypeId;//选择会员
- (void)initVehicleId:(NSString *)vehicleId vehicleName:(NSString *)vehicleName specificationId:(NSString *)specificationId isAop:(BOOL)isAop;//选择品牌
- (void)initReleaseSalesViewControllerCount:(NSInteger)count;
- (void)areLookingView;
//搜索
- (void)searchName:(NSString *)name string:(NSString *)string;
@end
