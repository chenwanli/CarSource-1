//
//  UserTypesModel.h
//  CarSource
//
//  Created by apple on 16/2/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserTypesModel : NSObject
@property (nonatomic,strong)NSString *userTypeId,*usetTypeName;
+ (UserTypesModel *)userTypesModelWithDictionary:(NSDictionary *)dict;
@end
