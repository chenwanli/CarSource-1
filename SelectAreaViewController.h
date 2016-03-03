//
//  SelectAreaViewController.h
//  CarSource
//
//  Created by apple on 16/1/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^provinces) (NSString *provincesStr,NSString *provincesIdStr,NSString *areaStr);
@interface SelectAreaViewController : UIViewController
@property (nonatomic,strong)provinces provinces;

@end
