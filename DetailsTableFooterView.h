//
//  DetailsTableFooterView.h
//  CarSource
//
//  Created by apple on 16/2/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^footerImage) (NSMutableArray *array,NSInteger footerCount);
typedef void (^userBtn) (NSString *userStr);
@interface DetailsTableFooterView : UIView
- (id)initWithFrame:(CGRect)frame array:(NSMutableArray *)array;
@property (nonatomic,strong)footerImage footerImage;
@property (nonatomic,strong)userBtn userBtn;
@end
