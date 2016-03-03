//
//  PromotionList.h
//  CarSource
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PromotionList : NSObject
@property (nonatomic,strong)NSString *promotionId,*promotionUrl;
+ (PromotionList *)promotionListWithDictionary:(NSDictionary *)dict;
@end
