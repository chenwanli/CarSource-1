//
//  ForDetailsModel.h
//  CarSource
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForDetailsModel : NSObject
@property (nonatomic,strong)NSString *userAddress,*userAddressTel,*transactionVehiclesId,*transactionVehiclesIntroduction,*transactionVehiclesModels,*transactionVehiclesModelsType,*transactionVehiclesTime;
@property (nonatomic,strong)NSMutableArray *transactionVehiclesUrlList;
+ (ForDetailsModel *)forDetailsModelWithDictionary:(NSDictionary *)dict;
@end
