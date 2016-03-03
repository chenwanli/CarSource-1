//
//  DetailsFooterView.h
//  CarSource
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^addImage) (NSString *addStr);
typedef void (^canceldelete) (NSString *cancelButton);
typedef void (^deleteImage) (NSInteger deleteImage);
typedef void (^toViewImage) (NSInteger toViewImage);
typedef void (^imageArr) (NSMutableArray *array);

@interface DetailsFooterView : UIView
@property (nonatomic,strong)addImage addImage;
@property (nonatomic,strong)canceldelete canceldelete;
@property (nonatomic,strong)deleteImage deleteImage;
@property (nonatomic,strong)toViewImage toViewImage;
@property (nonatomic,strong)imageArr imageArr;
- (void)initAddImageArray:(NSMutableArray *)imageArray height:(CGFloat)height cancel:(BOOL)cancel;

@end
