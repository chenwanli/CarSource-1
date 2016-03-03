//
//  TrailerServiceView.h
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^searchProvinces) (NSString *searchProvinces);
@interface TrailerServiceView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_serviceTable;
}
@property (nonatomic,strong)searchProvinces searchProvinces;
@end
