//
//  EntrustViewCell.h
//  CarSource
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^user) (NSString *user);
@interface EntrustViewCell : UITableViewCell
@property (nonatomic,strong)NSString *userStr;
@property (nonatomic,strong)NSString *typeStr;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)user user;
- (void)awakeFromNib;
@end
