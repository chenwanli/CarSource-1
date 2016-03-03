//
//  SalesListModel.h
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalesListModel : NSObject
@property (nonatomic,strong)NSString *addressCounties,*carSeriesName,*carSeriesTypeName,*modelsPrice,*salesCarsType,*salesId,*salesModelsColour,*salesShelfNumber,*salesText,*salesTime,*specificationText,*userName,*userTel,*userUrl,*salesSpcificationId;
@property (nonatomic,strong)NSMutableArray *imageList,*authenticateTypeNameList;
+ (SalesListModel *)salesListModelWithDictionary:(NSDictionary *)dict;

@end
