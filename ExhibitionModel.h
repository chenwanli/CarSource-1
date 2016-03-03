//
//  ExhibitionModel.h
//  CarSource
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExhibitionModel : NSObject
@property (nonatomic,strong)NSMutableArray *brandUrlList,*customerServiceUserList,*showCar,*transactionVehicles;
@property (nonatomic,strong)NSString *score,*showrooAddress,*showrooUrl,*showrooUserId,*showrooUserName,*showrooUserTel,*showrooUserUrl,*showroomBriefIntroduction,*showroomEmpirical,*showroomShowCarQuantity,*showroomViews,*transactionVehiclesQuantity,*userStatus;
+ (ExhibitionModel *)exhibitionModelWithDictionary:(NSDictionary *)dict;
@end
