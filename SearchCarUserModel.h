//
//  SearchCarUserModel.h
//  CarSource
//
//  Created by apple on 16/2/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchCarUserModel : NSObject
@property (nonatomic,strong)NSString *userCity,*userName,*userTel,*userUrl;
@property (nonatomic,strong)NSMutableArray *userAuthenticateList;
+ (SearchCarUserModel *)searchCarUserModelWithDictionary:(NSDictionary *)dict;
@end
