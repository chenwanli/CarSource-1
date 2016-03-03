//
//  ExhibitionViewCell.h
//  CarSource
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHRatingView.h"
@interface ExhibitionViewCell : UITableViewCell<ratingViewDelegate>
@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UILabel *introduceLabel;
@property (nonatomic,strong)LHRatingView *rView;
@property (nonatomic,strong)UIButton *phoneBtn;
@property (nonatomic,strong)UIImageView *belowIamge;
@property (nonatomic,strong)UILabel *carLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *detailedLabel;
@property (nonatomic,strong)UIImageView *memorialImage;

// 展车介绍  我的地址
- (void)theExhibitionHallisIntroducedHeight:(NSInteger)height;
//评分控件
- (void)initLHRatingView;
//经营品牌
- (void)initBrandManagementImageArray:(NSMutableArray *)array;
// 公司销售
- (void)initCompanySalesArray:(NSMutableArray *)array;
//联系电话
- (void)initContactPhoneNumber;
//全部展车
- (void)initAllofTheBelow;
//交车纪念
- (void)initItForMemorial;
@end
