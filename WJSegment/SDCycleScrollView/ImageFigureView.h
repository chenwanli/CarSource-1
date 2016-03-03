//
//  ImageFigureView.h
//  CarSource
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
typedef void (^furnitureId) (NSInteger furnitureId);
@interface ImageFigureView : UIView<SDCycleScrollViewDelegate>
- (void)initShufflingFigureURL:(NSMutableArray *)url furnitureId:(NSMutableArray *)furnitureId;
@property (nonatomic,retain)NSMutableArray *furnitureIdArray;
@property (nonatomic,strong)furnitureId furnitureId;
@end
