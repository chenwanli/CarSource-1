//
//  Serialization.m
//  MicroBeautyIn
//
//  Created by 龙卫科 on 15/9/10.
//  Copyright (c) 2015年 Long. All rights reserved.
//

#import "Serialization.h"

@implementation Serialization
+ (void)initSerializationArray:(NSMutableArray *)array{
    // 1,创建一个空的data
    NSMutableData *data = [[NSMutableData alloc] initWithCapacity:0];
    
    // 2,创建一个序列化器(编码器)  给它一个空的data,用来存放编码之后的数据
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    // 3,用序列化器来编码数组
    [archiver encodeObject:array];
    
    // 4,结束编码
    [archiver finishEncoding];
    
    // 此时data已经不空了
    // 5,把data写入文件
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LoginData.plist"];
    
    [data writeToFile:path atomically:YES];
    
}

+ (NSMutableArray *)initNSKeyedUnarchiver{
    // 1,把文件 读到data中
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LoginData.plist"];
    
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:path];
    
    // 2,创建一个反序列化器(解码器)
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    // 3,从反序列化器中解码出对象
    NSMutableArray *array = [unarchiver decodeObject];
    
    // 4,结束解码
    [unarchiver finishDecoding];
    
    // 5,使用数组
//    NSLog(@"array--%@",array);
    return array;

}

@end
