//
//  MemberTypeViewController.h
//  CarSource
//
//  Created by apple on 16/1/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^memberType) (NSString *memberType,NSString *memberTypeId);

@interface MemberTypeViewController : UIViewController
@property (nonatomic,strong)memberType memberType;
@property (nonatomic,assign)BOOL isMember;

@end
