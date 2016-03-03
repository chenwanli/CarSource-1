//
//  SalesOptionsView.h
//  CarSource
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^salesImage) (NSMutableArray *array,NSInteger salesCount);
@interface SalesOptionsView : UIView
@property (nonatomic,strong)salesImage salesImage;
@end
