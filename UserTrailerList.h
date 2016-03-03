//
//  UserTrailerList.h
//  CarSource
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserTrailerList : NSObject
@property (nonatomic,strong)NSString *userCompanyName,*userName,*userServiceType,*userTrailerId,*userTrailerUrl,*usetTrailerTel;
@property (nonatomic,strong)NSMutableArray *authenticateList;
+ (UserTrailerList *)userTrailerListWithDictionary:(NSDictionary *)dict;
@end
