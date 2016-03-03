//
//  BankCardView.h
//  CarSource
//
//  Created by apple on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^deleteBtn) (NSString *deleteBtn);
typedef void (^indexRow) (NSInteger index);
@interface BankCardView : UIView
@property (nonatomic,strong)deleteBtn deleteBtn;
@property (nonatomic,strong)indexRow indexRow;

- (void)initBankCardViewArray:(NSMutableArray *)array;
@end
