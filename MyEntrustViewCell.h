//
//  MyEntrustViewCell.h
//  CarSource
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEntrustViewCell : UITableViewCell
@property (nonatomic,strong)UIButton *userButton;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *personalImage;
@property (nonatomic,strong)UILabel *searchLabel;
@property (nonatomic,strong)UILabel *configuration;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *depositLabel;

- (void)initMyEntrustViewCellText:(NSString *)text;
@end
