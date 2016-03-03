//
//  CommissionedView.h
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^pkResults)(NSString *pkResults);
typedef void (^user) (NSString *user);
typedef void (^promotion) (NSInteger promotion,NSMutableArray *array);
@interface CommissionedView : UIView
@property (nonatomic,strong)UITableView *commissionedTable;
@property (nonatomic,strong)user user;
@property (nonatomic,strong)pkResults pkResults;
@property (nonatomic,strong)promotion promotion;

@end
