//
//  ModelsContrastViewCell.h
//  CarSource
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModelsContrastViewCell : UITableViewCell
@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong)UIImageView *deleteImage;
@property (nonatomic,strong)UILabel *modelsLabel;
- (void)modelsContrastViewCell;
@end
