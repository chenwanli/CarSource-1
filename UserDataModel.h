//
//  UserDataModel.h
//  CarSource
//
//  Created by apple on 16/1/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataModel : NSObject
@property (nonatomic,strong)NSString *userType,*userUrl,*userText,*userTel,*userName,*company,*companyName,*companyPosition,*addressArea;
+ (UserDataModel *)userDataModelWithDictionary:(NSDictionary *)dict;
@end
