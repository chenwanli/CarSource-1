//
//  AppDelegate.h
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//容联
@property (strong, nonatomic) NSString *callid;
+(AppDelegate*)shareInstance;
-(void)updateSoftAlertViewShow:(NSString*)message isForceUpdate:(BOOL)isForce;
-(void)toast:(NSString*)message;

@end

