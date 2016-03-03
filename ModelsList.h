//
//  ModelsList.h
//  CarSource
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelsList : NSObject
@property (nonatomic,strong)NSString *modelsId,*modelsName,*modelsPrice,*modelsUrl;
+ (ModelsList *)modelsListWithDictionary:(NSDictionary *)dict;
@end
