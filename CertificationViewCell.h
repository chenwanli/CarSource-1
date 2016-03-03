//
//  CertificationViewCell.h
//  CarSource
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^deleteBtn) (NSInteger deleteBtn);
typedef void (^imageBtn) (NSInteger imageBtn);
@interface CertificationViewCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UIView *addView;
@property (nonatomic,strong)UIButton *addButton;
@property (nonatomic,strong)deleteBtn deleteBtn;
@property (nonatomic,strong)imageBtn imageBtn;
@property (nonatomic,strong)UITextField *phoneField;
- (void)initCertificationViewCellNameText:(NSString *)nameText;
- (void)certificationViewCell;
- (void)initAddImageArray:(NSMutableArray *)imageArray height:(NSInteger)height cancel:(NSInteger )cancel isAdd:(BOOL)isAdd;
@end
