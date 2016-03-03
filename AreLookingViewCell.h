//
//  AreLookingViewCell.h
//  CarSource
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreLookingViewCell : UITableViewCell
@property (nonatomic,strong)UIButton *userButton;
@property (nonatomic,strong)UIImageView *userImage;
@property (nonatomic,strong)UIButton *telButton;
@property (nonatomic,strong)UIButton *informationBtn;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *searchLabel;
@property (nonatomic,strong)UILabel *configuration;
@property (nonatomic,strong)UILabel *timeLabel;
- (void)initAuthenticateLabelArray:(NSMutableArray *)array;
- (void)configurationHeight:(NSInteger)height;
@end
