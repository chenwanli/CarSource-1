//
//  SalasTelModel.m
//  CarSource
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SalasTelModel.h"

@implementation SalasTelModel
+ (SalasTelModel *)salasTelModelModelWithDictionary:(NSDictionary *)dict{
    SalasTelModel *salas = [[SalasTelModel alloc]init];
    salas.AuthenticateTypeName = dict[@"AuthenticateTypeName"];
    salas.TrailerServiceTypeName = dict[@"TrailerServiceTypeName"];
    return salas;
}
@end
