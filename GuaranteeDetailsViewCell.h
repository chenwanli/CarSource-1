//
//  GuaranteeDetailsViewCell.h
//  CarSource
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^guarantee) (NSString *guarantee);
@interface GuaranteeDetailsViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *typeLabel ;
@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong)UILabel *chooseLabel;
@property (nonatomic,strong)guarantee guarantee;
@property (nonatomic,strong)UITextField *numberField;
@property (nonatomic,strong)UITextView *textview;
- (void)initGuaranteeDetailsViewCell;
- (void)initGuaranteeDetailsViewCellUnitText:(NSString *)unitText placeholder:(NSString *)placeholder;
- (void)initTextView;
@end
