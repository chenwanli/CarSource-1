//
//  CarSeriesTypeModel.h
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarSeriesTypeModel : NSObject
@property (nonatomic,strong)NSString *carSeriesTypeId,*carSeriesTypeName;
+ (CarSeriesTypeModel *)carSeriesTypeModelWithDictionary:(NSDictionary *)dict;
@end
