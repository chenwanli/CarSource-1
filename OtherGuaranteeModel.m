//
//  OtherGuaranteeModel.m
//  CarSource
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OtherGuaranteeModel.h"
#import "CarSeriesType.h"
#import "UserInformation.h"

@implementation OtherGuaranteeModel
+ (OtherGuaranteeModel *)otherGuaranteeModelWithDictionary:(NSDictionary *)dict{
    OtherGuaranteeModel *guarantee = [[OtherGuaranteeModel alloc]init];
    guarantee.vouchTransactionApplyForStatus = dict[@"vouchTransactionApplyForStatus"];//寻车ID
    guarantee.vouchTransactionColour = dict[@"vouchTransactionColour"];//车颜色
    guarantee.vouchTransactionDealPrice = dict[@"vouchTransactionDealPrice"];//车价格
    guarantee.vouchTransactionGuaranteeDepositPrice = dict[@"vouchTransactionGuaranteeDepositPrice"];//担保金额
    guarantee.vouchTransactionId = dict[@"vouchTransactionId"];//担保ID
    guarantee.vouchTransactionStatus = dict[@"vouchTransactionStatus"];//交易状态 0未支付 1 已付款 2 交易完成
    guarantee.vouchTransactionText = dict[@"vouchTransactionText"];//担保约定
    guarantee.vouchTransactionTime = dict[@"vouchTransactionTime"];//发布时间
    guarantee.vouchTransactionUrlList = dict[@"vouchTransactionUrlList"];//所有凭证
    guarantee.carSeriesType = [NSMutableArray array];//车信息
    CarSeriesType *carSeries = [CarSeriesType carSeriesTypeWithDictionary:dict[@"carSeriesType"]];
    [guarantee.carSeriesType addObject:carSeries];
    guarantee.userInformation = [NSMutableArray array];// 用户信息
    UserInformation *information = [UserInformation userInformationWithDictionary:dict[@"userInformation"]];
    [guarantee.userInformation addObject:information];
    return guarantee;
}
@end
