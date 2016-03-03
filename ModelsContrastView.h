//
//  ModelsContrastView.h
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^contrast) (NSString *contrast);
@interface ModelsContrastView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_modelsTable;
    BOOL _models;
    BOOL _isModels[10000][10000];
    NSMutableArray *_modelsArray;
     NSMutableArray *_addArray;

}
@property (nonatomic,strong)contrast contrast;
@end
