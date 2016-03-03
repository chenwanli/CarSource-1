//
//  MessageViewController.h
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^nextDataArray) (NSMutableArray *next,UIViewController *viewController);
@interface MessageViewController : UIViewController
@property (nonatomic,strong)nextDataArray nextArray;
@end
