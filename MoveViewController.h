//
//  MoveViewController.h
//  MoveSelect
//
//  Created by ChaoRen on 15/12/23.
//  Copyright © 2015年 ChaoRen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentModel : NSObject

@property (nonatomic, retain)NSArray *titleArray; // 选项的标题
@property (nonatomic, retain)NSArray *contentViews; // 容器view  **** 这里必须注意 内容跟标题的数量必须一致 ****

@end


@interface MoveViewController : UIViewController

@property (nonatomic, retain)ContentModel *content;
@property NSInteger selectNum; // 点击的选择
@property BOOL isSelectImage;
@property NSInteger imageHeight;

// 字体颜色
@property (nonatomic, retain,readwrite)UIColor *titleSelectColor;
@property (nonatomic, retain,readwrite)UIColor *normalColor;
@property (nonatomic, retain,readwrite)UIFont *titleFont; // 默认15号字体
@property (nonatomic,retain)NSMutableArray *contentViewArr;

@end
