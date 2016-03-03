//
//  UlesPublishedView.h
//  CarSource
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^addBtn) (NSString *addButton);
typedef void (^cancelBtn) (NSString *cancelBtn);
typedef void (^deleteBtn) (NSInteger deleteBtn);
typedef void (^imageBtn) (NSInteger imageBtn);
typedef void (^chooseButton) (NSInteger chooseButton);
typedef void (^submit) (NSString *submitBtn);
@interface UlesPublishedView : UIView
@property (nonatomic,strong)addBtn addBtn;
@property (nonatomic,strong)cancelBtn cancelBtn;
@property (nonatomic,strong)deleteBtn deleteBtn;
@property (nonatomic,strong)imageBtn imageBtn;
@property (nonatomic,strong)chooseButton chooseButton;
@property (nonatomic,strong)submit submit;
- (void)initAddImagesViewImageArray:(NSMutableArray *)imageArray;
- (void)initVehicleId:(NSString *)vehicleId vehicleName:(NSString *)vehicleName specificationId:(NSString *)specificationId specifications:(NSString *)specifications;
- (void)initMemberType:(NSString *)memberType memberTypeId:(NSString *)memberTypeId;
@end
