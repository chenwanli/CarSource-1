//
//  TrailerCell.h
//  CarSource
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrailerCell : UITableViewCell
@property (nonatomic,strong)UIImageView *carImage;
@property (nonatomic,strong)UIImageView *typeImage;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UIView *rightView;
@property (nonatomic,strong)UILabel *leftService;
@property (nonatomic,strong)UILabel *rightService;
@property (nonatomic,strong)UILabel *leftName;
@property (nonatomic,strong)UILabel *rightName;
@property (nonatomic,strong)UIButton *leftPhone;
@property (nonatomic,strong)UIButton *rightPhone;
@property (nonatomic,strong)UIImageView *leftImage;
@property (nonatomic,strong)UIImageView *rightImage;
@property (nonatomic,strong)UIImageView *leftcertification;
@property (nonatomic,strong)UIImageView *rightcertification;
- (void)initTrailerCellArray:(NSMutableArray *)trailerArray;
@end
