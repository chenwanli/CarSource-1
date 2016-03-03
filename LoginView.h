//
//  LoginView.h
//  CarSource
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^returnBtn) (NSString *returnBtn);
typedef void (^registered) (NSString *registered);
typedef void (^password) (NSString *password);
typedef void (^submitBtn) (NSString *nameText ,NSString *passwordText);
@interface LoginView : UIView
@property (nonatomic,strong)submitBtn submitBtn;
@property (nonatomic,strong)returnBtn returnBtn;
@property (nonatomic,strong)registered registered;
@property (nonatomic,strong)password password;
@end
