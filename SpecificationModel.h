//
//  SpecificationModel.h
//  CarSource
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecificationModel : NSObject
@property (nonatomic,strong)NSString *specificationId,*specificationText;
+ (SpecificationModel *)specificationModelWithDictionary:(NSDictionary *)dict;
@end
