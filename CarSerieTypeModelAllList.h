//
//  CarSerieTypeModelAllList.h
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarSerieTypeModelAllList : NSObject
@property (nonatomic,strong)NSString *carSerieTypeId,*carSerieTypeName,*carSerieTypePrice;
+ (CarSerieTypeModelAllList *)carSerieTypeModelAllListWithDictionary:(NSDictionary *)dict;
@end
