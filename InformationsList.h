//
//  InformationsList.h
//  CarSource
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationsList : NSObject
@property (nonatomic,strong)NSString *informationText,*informationTime,*informationUserId;
+ (InformationsList *)informationsListWithDictionary:(NSDictionary *)dict;
@end
