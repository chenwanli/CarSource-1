//
//  BrandModel.m
//  CarSource
//
//  Created by apple on 16/1/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BrandModel.h"

@implementation ResultArray
- (void)dealloc
{
    self.brandId = nil;
    self.brandInitials = nil;
    self.brandLogo = nil;
    self.brandName = nil;
}
+ (ResultArray *)brandModelWithDictionary:(NSDictionary *)dict{
    ResultArray *brand = [[ResultArray alloc]init];
    brand.brandId = dict[@"brandId"];//品牌ID
    brand.brandInitials = dict[@"brandInitials"];//拼音首字母
    brand.brandLogo = dict[@"brandLogo"];//品牌url地址
    brand.brandName = dict[@"brandName"];//品牌名
    return brand;
}

@end
@implementation  BrandModel

- (NSMutableArray *)storeForDictionary:(NSDictionary *)dict
{
    NSMutableArray *array = [NSMutableArray array];

    for (int i = 0; i < 26; i++)
    {
        _subArray[i] = [NSMutableArray array];
    }

    NSArray *data = [dict objectForKey:@"data"];

    for (NSDictionary *dict in data)
    {
        ResultArray *model = [ResultArray brandModelWithDictionary:dict];
        [self assingmenStoreForBrandModel:model];
    }

    for (int i = 0; i < 26; i++)
    {
        NSArray *newArray = _subArray[i];
        if (newArray.count > 0)
        {
            [array addObject:newArray];
        }
    }
    return array;
}

- (void)assingmenStoreForBrandModel:(ResultArray *)model
{
    if ([model.brandInitials isEqualToString:@"A"])
    {
        [_subArray[0] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"B"])
    {
        [_subArray[1] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"C"])
    {
        [_subArray[2] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"D"])
    {
        [_subArray[3] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"E"])
    {
        [_subArray[4] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"F"])
    {
        [_subArray[5] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"G"])
    {
        [_subArray[6] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"H"])
    {
        [_subArray[7] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"I"])
    {
        [_subArray[8] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"J"])
    {
        [_subArray[9] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"K"])
    {
        [_subArray[10] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"L"])
    {
        [_subArray[11] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"M"])
    {
        [_subArray[12] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"N"])
    {
        [_subArray[13] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"O"])
    {
        [_subArray[14] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"P"])
    {
        [_subArray[15] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"Q"])
    {
        [_subArray[16] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"R"])
    {
        [_subArray[17] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"S"])
    {
        [_subArray[18] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"T"])
    {
        [_subArray[19] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"U"])
    {
        [_subArray[20] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"V"])
    {
        [_subArray[21] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"W"])
    {
        [_subArray[22] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"X"])
    {
        [_subArray[23] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"Y"])
    {
        [_subArray[24] addObject:model];
    }
    else if ([model.brandInitials isEqualToString:@"Z"])
    {
        [_subArray[25] addObject:model];
    }
}

@end
