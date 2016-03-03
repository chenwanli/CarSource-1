//
//  RulesCarViewCell.h
//  CarSource
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RulesCarViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UIImageView *milledImage;
@property (nonatomic,strong)UIButton *typeButton;
@property (nonatomic,strong)UILabel *guidedLabel;
@property (nonatomic,strong)UIButton *colorBtn;
- (void)initRulesCarViewCell;
- (void)initRulesCarViewCellChooseColor;
@end
