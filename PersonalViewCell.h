//
//  PersonalViewCell.h
//  CarSource
//
//  Created by apple on 16/1/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^personal) (CGFloat personal);
@interface PersonalViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *personalLabel;
@property (nonatomic,strong)UIImageView *portraitImage;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UITextField *contentText;
@property (nonatomic,strong)UIButton *userButton;
@property (nonatomic,strong)UILabel *regionLabel;

@property (nonatomic,strong)personal personal;
- (void)initPortraitImage;
- (void)initContentLabel;
- (void)initcontentTextPlaceholder:(NSString *)placeholder;
- (void)initTextView;
@end
