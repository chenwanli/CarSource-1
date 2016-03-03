//
//  TransactionVehicles.h
//  CarSource
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionVehicles : NSObject
@property (nonatomic,strong)NSString *transactionVehiclesId,*transactionVehiclesIntroduction,*transactionVehiclesModels,*transactionVehiclesModelsType,*transactionVehiclesTime,*transactionVehiclesUrl;
+ (TransactionVehicles *)transactionVehiclesWithDictionary:(NSDictionary *)dict;
@end
