//
//  HomeViewController.h
//  CarSource
//
//  Created by apple on 15/12/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^homeIndex) (NSInteger homeIndex ,NSMutableArray *contentViews);
typedef void (^pkResults) (NSString *pkResults);
typedef void (^promotionUrl) (NSInteger promotion ,NSMutableArray *promotionUrl);

@interface HomeViewController : UIViewController
@property (nonatomic,strong)homeIndex homeIndex;
@property (nonatomic,strong)pkResults pkResults;
@property (nonatomic,strong)promotionUrl promotionUrl;

@end
