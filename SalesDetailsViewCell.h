//
//  SalesDetailsViewCell.h
//  CarSource
//
//  Created by apple on 16/2/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalesDetailsViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *salesLabel,*details;
- (void)initSalesLabelHeight:(NSInteger)height;
@end
