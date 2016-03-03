//
//  WithdrawalView.h
//  CarSource
//
//  Created by apple on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^submit)(NSString *submit);
@interface WithdrawalView : UIView
@property (nonatomic,strong)submit submit;

- (void)initWithdrawalViewArray:(NSMutableArray *)array;
@end
