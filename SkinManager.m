//
//  SkinManager.m
//  HumpLogistics
//
//  Created by MAC on 15/3/15.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import "SkinManager.h"

@implementation SkinManager
+ (instancetype)sharedSkinManager
{
    static SkinManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        manager = [[SkinManager alloc]init];
    });
    return manager;
}

@end
