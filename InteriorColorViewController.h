//
//  InteriorColorViewController.h
//  CarSource
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^interiorColor) (NSString *appearance, NSString *interiorColor,NSString *appearanceId, NSString *interiorColorId);
@interface InteriorColorViewController : UIViewController
@property (nonatomic,strong)interiorColor interiorColor;
@end
