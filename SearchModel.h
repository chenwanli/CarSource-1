//
//  SearchModel.h
//  CarSource
//
//  Created by apple on 16/2/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject
@property (nonatomic,strong)NSString *brandName,*carSeriesName,*carSeriesTypeName,*text;
+ (SearchModel *)searchModelWithDictionary:(NSDictionary *)dict;
@end
