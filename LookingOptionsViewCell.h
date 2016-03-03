//
//  LookingOptionsViewCell.h
//  CarSource
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookingOptionsViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *lookingLabel;
@property (nonatomic,strong)UILabel *timeLabel;
- (void)lookingOptionsViewCellHeight:(CGFloat)height;
@end
