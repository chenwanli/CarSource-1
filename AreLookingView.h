//
//  AreLookingView.h
//  CarSource
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^brandTag) (NSInteger brandTag);
@interface AreLookingView : UIView
@property (nonatomic,strong)brandTag brandTag;
- (void)initinstallationMJRefresh;
- (void)provincesStr:(NSString *)provincesStr provincesIdStr:(NSString *)provincesIdStr areaStr:(NSString *)areaStr;//选择区域
- (void)initVehicleId:(NSString *)vehicleId vehicleName:(NSString *)vehicleName specificationId:(NSString *)specificationId;//选择品牌
- (void)areLookingView;
- (void)initDefaultMJRefresh;//重新获取默认寻车列表
@end
