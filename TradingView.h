//
//  TradingView.h
//  CarSource
//
//  Created by apple on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^detailed) (NSString *detailed);
typedef void (^depositBtn) (NSString *depositBtn);
@interface TradingView : UIView
@property (nonatomic,strong)depositBtn depositBtn;
@property (nonatomic,strong)detailed detailed;

@end
