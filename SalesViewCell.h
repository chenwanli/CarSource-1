//
//  SalesViewCell.h
//  CarSource
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^closeHeight) (CGFloat closeHeight, NSInteger row, BOOL close);
typedef void (^imageUrl) (NSMutableArray *imageArray ,NSInteger imageCount);
@interface SalesViewCell : UITableViewCell
@property (nonatomic,strong)UIButton *userButton;
@property (nonatomic,strong)UIImageView *userImage;
@property (nonatomic,strong)UIButton *telButton;
@property (nonatomic,strong)UIButton *informationBtn;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *configuration;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)closeHeight closeHeight;
@property (nonatomic,strong)imageUrl imageUrl;
@property (nonatomic,strong)UIView *salesView;
@property (nonatomic,strong)UIButton *displayBtn;
@property (nonatomic,strong)UIImageView *lineImage;

- (void)salesViewCellNameText:(NSString *)text salesHeightView:(CGFloat)salesHeight configurationHeight:(CGFloat)height isOpen:(BOOL)isOpen salesArray:(NSMutableArray *)salesArray;
- (void)initAuthenticateLabelText:(NSMutableArray *)array;
@end
