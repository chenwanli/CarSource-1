//
//  ShowDetailsModel.h
//  CarSource
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowDetailsModel : NSObject
@property (nonatomic,strong)NSString *showCarColour,*showCarId,*showCarIntroduction,*showCarModels,*showCarModelsType,*showCarPrice,*showCarTime,*showCarUserTel,*showroomArea;
@property (nonatomic,strong)NSMutableArray *showCarUrl;
+ (ShowDetailsModel *)showDetailsModelWithDictionary:(NSDictionary *)dict;
@end
