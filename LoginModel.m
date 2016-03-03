//
//  LoginModel.m
//  CarSource
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
// 定义了一套编码的规范
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userText forKey:@"userText"];
    [aCoder encodeObject:self.userTel forKey:@"userTel"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.userUrl forKey:@"userUrl"];
    [aCoder encodeObject:self.userMoney forKey:@"userMoney"];
    [aCoder encodeObject:self.userTypeId forKey:@"userTypeId"];
    [aCoder encodeObject:self.userBackGround forKey:@"userBackGround"];


}
// 定义了一套解码的规范
// 初始化方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.userTypeId = [aDecoder decodeObjectForKey:@"userTypeId"];
        self.userMoney = [aDecoder decodeObjectForKey:@"userMoney"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.userUrl = [aDecoder decodeObjectForKey:@"userUrl"];
        self.userTel = [aDecoder decodeObjectForKey:@"userTel"];
        self.userText = [aDecoder decodeObjectForKey:@"userText"];
        self.userBackGround = [aDecoder decodeObjectForKey:@"userBackGround"];

    }
    return self;
}

@end
