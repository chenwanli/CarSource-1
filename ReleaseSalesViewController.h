//
//  ReleaseSalesViewController.h
//  CarSource
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^submitBtn) (NSInteger submitBtn);
@interface ReleaseSalesViewController : UIViewController
@property (nonatomic,strong)submitBtn submitBtn;
@end
