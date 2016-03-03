//
//  CarSerieModel.h
//  CarSource
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarSerieModel : NSObject
@property (nonatomic,strong)NSString *carSerieId,*carSeriePrice,*carSerieName;
+ (CarSerieModel *)carSerieModelWithDictionary:(NSDictionary *)dict;
@end
