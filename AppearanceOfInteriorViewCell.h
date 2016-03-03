//
//  AppearanceOfInteriorViewCell.h
//  CarSource
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppearanceOfInteriorViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *appearanceLabel;
@property (nonatomic,strong)UILabel *moreLabel;
- (void)initAppearanceOfInteriorViewCellArray:(NSMutableArray *)array;
@end
