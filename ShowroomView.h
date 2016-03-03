//
//  ShowroomView.h
//  CarSource
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^showroom) (NSString *str);
@interface ShowroomView : UIView
@property (nonatomic,strong)showroom showroom;
- (id)initWithFrame:(CGRect)frame array:(NSMutableArray *)array showroomId:(NSString *)showroomId;
@end
