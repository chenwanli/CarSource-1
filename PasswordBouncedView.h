//
//  PasswordBouncedView.h
//  CarSource
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^password) (NSMutableArray *passwordArray);
typedef void (^cancelBtn) (NSString *cancelStr);
@interface PasswordBouncedView : UIView
@property (nonatomic,strong)password password;
@property (nonatomic,strong)cancelBtn cancelBtn;
@end
