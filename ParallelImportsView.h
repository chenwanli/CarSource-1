//
//  ParallelImportsView.h
//  CarSource
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^addImage) (NSString *addStr);
typedef void (^canceldelete) (NSString *cancelButton);
typedef void (^deleteImage) (NSInteger deleteImage);
typedef void (^toViewImage) (NSInteger toViewImage);
typedef void (^models) (NSString *models);
typedef void (^colorBtn) (NSString *colorBtn);
typedef void (^submitStr) (NSString *submitStr);
@interface ParallelImportsView : UIView
@property (nonatomic,strong)addImage addImage;
@property (nonatomic,strong)canceldelete canceldelete;
@property (nonatomic,strong)deleteImage deleteImage;
@property (nonatomic,strong)toViewImage toViewImage;
@property (nonatomic,strong)UIButton *typeButton;
@property (nonatomic,strong)UIButton *colorButton;
@property (nonatomic,strong)models models;
@property (nonatomic,strong)colorBtn colorBtn;
@property (nonatomic,strong)submitStr submitStr;
- (void)initAddImageArray:(NSMutableArray *)imageArray;
//获取车型内容
- (void)initTypeButtontext;
- (void)initColorAppearance:(NSString *)appearance interior:(NSString *)interior;

@end
