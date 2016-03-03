//
//  SalasTelModel.h
//  CarSource
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 apple. All rights reserved.
//
// 我的服务 用户认证状态
#import <Foundation/Foundation.h>

@interface SalasTelModel : NSObject
//用户认证状态     拖车服性质
@property (nonatomic,strong)NSString *AuthenticateTypeName,*TrailerServiceTypeName;
+ (SalasTelModel *)salasTelModelModelWithDictionary:(NSDictionary *)dict;
@end
