//
//  provincesModel.h
//  CarSource
//
//  Created by apple on 16/2/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface provincesModel : NSObject
@property (nonatomic,strong)NSString *cityCoding,*cityId,*cityName;
+ (provincesModel *)provincesModelWithDictionary:(NSDictionary *)dict;
@end
