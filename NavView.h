//
//  NavView.h
//  CarSource
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^returnBtn) (NSString *returnBtn);
@interface NavView : UIView
@property (nonatomic,strong)UIButton *returnBtn;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)returnBtn returnButton;
@end
