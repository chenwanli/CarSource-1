//
//  SalesOptionsViewCell.h
//  CarSource
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLDisplayView.h"
typedef void (^salesImage) (NSMutableArray *array,NSInteger salesCount);
@interface SalesOptionsViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *configuration;
@property (nonatomic,strong)UIButton *displayBtn;
@property (nonatomic,strong)salesImage salesImage;
- (void)configurationHeight:(CGFloat)height isOpen:(BOOL)isOpen salesArray:(NSMutableArray *)salesArray;
@end
