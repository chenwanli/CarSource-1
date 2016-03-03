//
//  Serialization.h
//  MicroBeautyIn
//
//  Created by 龙卫科 on 15/9/10.
//  Copyright (c) 2015年 Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Serialization : NSObject
+ (void)initSerializationArray:(NSMutableArray *)array;
+ (NSMutableArray *)initNSKeyedUnarchiver;
@end
