//
//  SpecifiedBrandView.h
//  CarSource
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^specified) (NSString *specified);
@interface SpecifiedBrandView : UIView
@property (nonatomic,strong)specified specified;
- (void)initSpecifiedBrandViewCellBrandId:(NSString *)brandId;
- (void)initSpecificationId:(NSString *)specificationId brandId:(NSString *)brandId;
@end
