//
//  WalletView.h
//  CarSource
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^wallet) (NSInteger wallet);
typedef void (^set) (NSString *set);
@interface WalletView : UIView

@property (nonatomic,strong)wallet wallet;
@property (nonatomic,strong)set set;

@end
