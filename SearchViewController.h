//
//  SearchViewController.h
//  CarSource
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^searchView) (NSString *nameStr,NSString *string);
@interface SearchViewController : UIViewController
@property (nonatomic,strong)searchView searchView;
@end
