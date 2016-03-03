//
//  MemberView.h
//  CarSource
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^submit) (NSString *submit);
typedef void (^returnBtn) (NSString *returnBtn);
@interface MemberView : UIView
@property (nonatomic,strong)submit submit;
@property (nonatomic,strong)returnBtn returnBtn;

@end
