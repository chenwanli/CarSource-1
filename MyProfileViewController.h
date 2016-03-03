//
//  MyProfileViewController.h
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^nextArray) (NSMutableArray *next);
typedef void (^btnTag) (NSInteger btnTag);
typedef void (^userBtn) (NSString *userBtn);
typedef void (^row) (NSInteger row,BOOL isProfile);
typedef void (^loginBtn)(NSString *loginBtn);
@interface MyProfileViewController : UIViewController

@property (nonatomic,strong)nextArray nextArray;
@property (nonatomic,strong)btnTag btnTag;
@property (nonatomic,strong)userBtn userBtn;
@property (nonatomic,strong)row row;
@property (nonatomic,strong)loginBtn loginBtn;
@end
