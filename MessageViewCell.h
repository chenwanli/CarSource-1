//
//  MessageViewCell.h
//  CarSource
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *userImage;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *instructions;
@property (nonatomic,strong)UILabel *timeLabel;//时间
@end
