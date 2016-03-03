//
//  OtherGuaranteeModel.h
//  CarSource
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OtherGuaranteeModel : NSObject
@property (nonatomic,strong)NSString *vouchTransactionApplyForStatus,*vouchTransactionColour,*vouchTransactionDealPrice,*vouchTransactionGuaranteeDepositPrice,*vouchTransactionId,*vouchTransactionStatus,*vouchTransactionText,*vouchTransactionTime;
@property (nonatomic,strong)NSMutableArray *carSeriesType,*userInformation,*vouchTransactionUrlList;
+ (OtherGuaranteeModel *)otherGuaranteeModelWithDictionary:(NSDictionary *)dict;
@end
