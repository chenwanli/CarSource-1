//
//  SearchCarModel.h
//  CarSource
//
//  Created by apple on 16/2/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchCarModel : NSObject
@property (nonatomic,strong)NSString *searchCarId,*searchCarText,*searchCarTime;
@property (nonatomic,strong)NSMutableArray *searchCarUser;
+ (SearchCarModel *)searchCarModelWithDictionary:(NSDictionary *)dict;
@end
