//
//  CarPicturesView.h
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^carView) (NSString *carView);
@interface CarPicturesView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_destinationTable;
    NSMutableArray *_bigArray;
    NSMutableArray *_allArray;
    NSMutableArray *_arr;
    NSMutableArray *_nameArray;

}

@property (nonatomic,strong)carView carView;
@end
