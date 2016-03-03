//
//  OtherGuaranteeViewCell.h
//  CarSource
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherGuaranteeViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *userImage;
@property (nonatomic,strong)UIButton *userButton;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *amountLabel;
@property (nonatomic,strong)UILabel *personalLabel;
@property (nonatomic,strong)UILabel *configuration;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIButton *payButton;
@property (nonatomic,strong)UILabel *payLabel;
@property (nonatomic,strong)UILabel *promptLabel;
@property (nonatomic,strong)UILabel *detailedLabel;
@property (nonatomic,strong)UIButton *credentialsBtn;
- (void)initName:(NSString *)name certification:(NSMutableArray *)certification detailed:(CGFloat)detailed;
@end
