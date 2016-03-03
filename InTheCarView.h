//
//  InTheCarView.h
//  CarSource
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^addImage) (NSString *addStr);
typedef void (^canceldelete) (NSString *cancelButton);
typedef void (^deleteImage) (NSInteger deleteImage);
typedef void (^toViewImage) (NSInteger toViewImage);
typedef void (^typeBtn) (NSString *typeBtn);
typedef void (^submit) (NSString *submit);
@interface InTheCarView : UIView
@property (nonatomic,strong)addImage addImage;
@property (nonatomic,strong)canceldelete canceldelete;
@property (nonatomic,strong)deleteImage deleteImage;
@property (nonatomic,strong)toViewImage toViewImage;
@property (nonatomic,strong)submit submit;
@property (nonatomic,strong)typeBtn typeBtn;
- (void)initAddImageArray:(NSMutableArray *)imageArray;
- (void)initCarSeriesTypeName:(NSString *)carSeriesTypeName carSeriesTypeId:(NSString *)carSeriesTypeId promotionId:(NSString *)promotionId specificationId:(NSString *)specificationId specifications:(NSString *)specifications;

@end
