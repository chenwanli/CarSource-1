//
//  BelowReleaseViewController.h
//  CarSource
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^belowRelease) (NSString *str);
@interface BelowReleaseViewController : UIViewController
@property (nonatomic,strong)belowRelease belowRelease;
@end
