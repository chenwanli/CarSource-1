//
//  ImageFigureView.m
//  CarSource
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ImageFigureView.h"

@implementation ImageFigureView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self initShufflingFigure];
    }
    return self;
}

- (void)initShufflingFigureURL:(NSMutableArray *)url furnitureId:(NSMutableArray *)furnitureId {
    _furnitureIdArray = url;
    //采用本地图片实现
    //    NSArray *images = @[[UIImage imageNamed:@"h1.jpg"],
    //                        [UIImage imageNamed:@"h2.jpg"],
    //                        [UIImage imageNamed:@"h3.jpg"],
    //                        [UIImage imageNamed:@"h4.jpg"]
    //
    SDCycleScrollView *cycleScrollView;
    if (url.count == 0) {
        NSMutableArray *images = [[NSMutableArray alloc]init];
        for (int i = 1; i<6; i++) {
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"h%d.jpg",i]]];
        }


        // 本地加载 --- 创建不带标题的图片轮播器
        cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds imagesGroup:images];
    }else{
        cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds imageURLStringsGroup:url];
    }
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self addSubview:cycleScrollView];
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView.autoScrollTimeInterval = 2.0;
    //    if (furnitureId == nil) {
    //        cycleScrollView.autoScroll = NO;
    //    }
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{

    if(_furnitureId ==nil)
    {
//        NSLog(@"---点击了第%ld张图片  %@", (long)index, [_furnitureIdArray objectAtIndex:index] );
    }
    else
    {
        self.furnitureId(index);
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
