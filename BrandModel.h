//
//  BrandModel.h
//  CarSource
//
//  Created by apple on 16/1/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultArray : NSObject
@property (nonatomic,strong)NSString *brandId,*brandInitials,*brandLogo,*brandName;
//+ (ResultArray *)brandModelWithDictionary:(NSDictionary *)dict;
@end
@interface  BrandModel : NSObject

{
    NSMutableArray *_subArray[26];
}

- (NSMutableArray *)storeForDictionary:(NSDictionary *)dict;

@end
