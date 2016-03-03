//
//  ShowroomViewCell.h
//  CarSource
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowroomViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *showroomLabel;
@property (nonatomic,strong)UITextView *textview;
- (void)initShowroomViewCellIndex:(NSInteger)index;
@end
