//
//  RulesCarView.h
//  CarSource
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^rulesCar) (NSInteger rulesCar);
typedef void (^members) (NSString *members);
@interface RulesCarView : UIView
@property (nonatomic,strong)rulesCar rulesCar;
@property (nonatomic,strong) members members;
- (void)initTypeStr:(NSString *)typeStr;
- (void)initColorStr:(NSString *)colorStr;
@end
