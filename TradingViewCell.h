//
//  TradingViewCell.h
//  CarSource
//
//  Created by apple on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradingViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *userImage;
@property (nonatomic,strong)UIButton *userButton;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *personalImage;
@property (nonatomic,strong)UILabel *personalLabel;
@property (nonatomic,strong)UILabel *configuration;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIButton *credentialsBtn;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UILabel *sellerLabel;
@property (nonatomic,strong)UILabel *userLabel;
- (void)moneyText:(NSString *)moneyText;
- (void)initName:(NSString *)name certification:(NSMutableArray *)certification detailed:(CGFloat)detailed;
@end
