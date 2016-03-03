//
//  RegisteredView.h
//  CarSource
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^submit) (NSString *tel,NSString *code,NSString *password);
typedef void (^returnBtn) (NSString *returnBtn);
@interface RegisteredView : UIView
@property (nonatomic,strong)submit submit;
@property (nonatomic,strong)returnBtn returnBtn;
@end
