//
//  FriendsListViewController.h
//  CarSource
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
typedef  void (^friendsList) (NSString *friendsList ,NSString *friendsName);
@interface FriendsListViewController : UIViewController
@property (nonatomic,assign)BOOL isList;
@property (nonatomic,strong)friendsList friendsList;

//容联
@property(nonatomic,strong)UITableView *sessionTableView;
@property (nonatomic,assign)BOOL isFriendsList;
@property (nonatomic, assign) id<SlideSwitchSubviewDelegate> mainView;
@end
