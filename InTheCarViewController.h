//
//  InTheCarViewController.h
//  CarSource
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^inTheCar) (NSString *str);
@interface InTheCarViewController : UIViewController
@property (nonatomic,strong)inTheCar inTheCar;
@property (nonatomic,strong)NSString *showroomId;
@end
