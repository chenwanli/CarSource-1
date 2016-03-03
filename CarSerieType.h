//
//  CarSerieType.h
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarSerieType : NSObject
@property (nonatomic,strong)NSMutableArray *carSerieTypeModelAllList,*carSerieTypeModelList,*carSeriesUrlList,*colourList;
@property (nonatomic,strong)NSString *carSeriesId;
+ (CarSerieType *)carSerieTypeWithDictionary:(NSDictionary *)dict;
@end
