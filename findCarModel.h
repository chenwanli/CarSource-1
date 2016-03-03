//
//  findCarModel.h
//  CarSource
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface findCarModel : NSObject
@property (nonatomic,strong)NSString *searchCarId,*searchCarText,*searchCarTime;
+ (findCarModel *)findCarModelWithDictionary:(NSDictionary *)dict;
@end
