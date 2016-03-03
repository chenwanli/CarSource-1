//
//  ChooseBrandViewController.h
//  CarSource
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^vehicleId) (NSString *vehicleId,NSString *vehicleName,NSString *specificationId ,NSString *specifications);
typedef void (^carSeriesStr) (NSString *carSeriesTypeName,NSString *carSeriesTypeId);
typedef void (^exhibition) (NSString *carSeriesTypeName,NSString *carSeriesTypeId,NSString *specificationId ,NSString *specifications);
@interface ChooseBrandViewController : UIViewController
@property (nonatomic,assign)NSInteger chooseBrand;
@property (nonatomic,strong)vehicleId vehicleId;
@property (nonatomic,assign)BOOL isChoose;
@property (nonatomic,assign)BOOL isAop;
@property (nonatomic,assign)BOOL isExhibition;
@property (nonatomic,assign)NSInteger navCount;
@property (nonatomic,strong)NSString *specificationId;
@property (nonatomic,strong)carSeriesStr carSeriesStr;
@property (nonatomic,strong)exhibition exhibition;//展厅
@end
