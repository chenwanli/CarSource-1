//
//  CarSeriesViewController.h
//  CarSource
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^carSeries) (NSString *carSeries);
@interface CarSeriesViewController : UIViewController
@property (nonatomic,strong)carSeries carSeries;
@property (nonatomic,strong)NSString *carSeriesStr;
@end
