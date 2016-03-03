//
//  RecentlySecuredModel.h
//  CarSource
//
//  Created by apple on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentlySecuredModel : NSObject
@property (nonatomic,strong)NSString *guaranteeCarName,*guaranteeCarPrice,*guaranteeDepositPrice,*guaranteeName,*guaranteeStatus,*guaranteeTime;
@property (nonatomic,strong)NSMutableArray *userInformation;
+ (RecentlySecuredModel *)recentlySecuredModelWithDictionary:(NSDictionary *)dict;
@end
