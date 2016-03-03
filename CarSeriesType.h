//
//  CarSeriesType.h
//  CarSource
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarSeriesType : NSObject
@property (nonatomic,strong)NSString *carSeriesBrandName,*carSeriesName,*carSeriesTypeName;
+ (CarSeriesType *)carSeriesTypeWithDictionary:(NSDictionary *)dict;
@end
