//
//  MySalesListModel.h
//  CarSource
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySalesListModel : NSObject
@property (nonatomic,strong)NSString *carSeriesBrand,*carSeriesName,*carSeriesTypeName,*modelsPrice,*salesCarsType,*salesId,*salesModelsColour,*salesText,*salesTime,*specificationText;
@property (nonatomic,strong)NSMutableArray *arr;
+ (MySalesListModel *)MySalesListModelWithDictionary:(NSDictionary *)dict;
@end
