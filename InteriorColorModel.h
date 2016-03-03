//
//  InteriorColorModel.h
//  CarSource
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InteriorColorModel : NSObject
@property (nonatomic,strong)NSString *modelsInteriorColorCodes,*modelsInteriorColourId,*modelsInteriorColourName;
+ (InteriorColorModel *)interiorColorModelWithDictionary:(NSDictionary *)dict;
@end
