//
//  ResourcesViewCell.h
//  CarSource
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResourcesViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIButton *userButton;
@property (nonatomic,strong)UIButton *telButton;
@property (nonatomic,strong)UIButton *informationBtn;
@property (nonatomic,strong)UILabel *nameLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier text:(NSString *)text;
@end
