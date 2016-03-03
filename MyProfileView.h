//
//  MyProfileView.h
//  CarSource
//
//  Created by apple on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^next) (NSString *next);
typedef void (^buttonTag) (NSInteger buttonTag);
typedef void (^userBtn) (NSString *userBtn);
typedef void (^loginBtn) (NSString *loginStr);
typedef void (^bgButton) (NSString *bgButton);
@interface MyProfileView : UIView
@property (nonatomic,strong)next next;
@property (nonatomic,strong)buttonTag buttonTag;
@property (nonatomic,strong)userBtn userBtn;
@property (nonatomic,strong)UIButton *userButton;
@property (nonatomic,strong)loginBtn loginBtn;
@property (nonatomic,strong)bgButton bgButton;
- (void)initBackgroundImageView;
@end
