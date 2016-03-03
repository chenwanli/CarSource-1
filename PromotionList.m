//
//  PromotionList.m
//  CarSource
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PromotionList.h"

@implementation PromotionList
+ (PromotionList *)promotionListWithDictionary:(NSDictionary *)dict{
    PromotionList *list = [[PromotionList alloc]init];
    list.promotionId = dict[@"promotionId"];
    list.promotionUrl = dict[@"promotionUrl"];
    return list;
}


@end
