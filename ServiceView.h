//
//  ServiceView.h
//  CarSource
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^service) (NSString *name,NSString *bank,NSString *number);
@interface ServiceView : UIView
@property (nonatomic,strong)service service;
@end
