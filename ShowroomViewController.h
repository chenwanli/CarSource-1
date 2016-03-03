//
//  ShowroomViewController.h
//  CarSource
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^showroomView) (NSString *str);
@interface ShowroomViewController : UIViewController
@property (nonatomic,strong)showroomView showroomView;
@property (nonatomic,strong)NSMutableArray *showroomArray;
@property (nonatomic,strong)NSString *showroomId;
@end
