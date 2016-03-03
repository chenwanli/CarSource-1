//
//  ExteriorColorModel.h
//  CarSource
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExteriorColorModel : NSObject
@property (nonatomic,strong)NSString *modelsExteriorColorCodes,*modelsExteriorColourId,*modelsExteriorColourName;
+ (ExteriorColorModel *)exteriorColorModelWithDictionary:(NSDictionary *)dict;
@end
