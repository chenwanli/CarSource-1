//
//  MethodOfPaymentCell.h
//  CarSource
//
//  Created by apple on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MethodOfPaymentCell : UITableViewCell
@property (nonatomic,strong)UIImageView *payImage;
@property (nonatomic,strong)UIButton *payButton;
@property (nonatomic,strong)UILabel *payLabel;
@property (nonatomic,strong)UILabel *instructionsLabel;
@property (nonatomic,strong)UIImageView *chooseImage;
@property (nonatomic,strong)UIImageView *bankImage;
- (void)initMethodOfPaymentCellText:(NSString *)text;
@end
