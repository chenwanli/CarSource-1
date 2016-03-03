//
//  SalesOptionsView.m
//  CarSource
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 apple. All rights reserved.
//
//销售车源
#import "SalesOptionsView.h"
#import "SalesOptionsViewCell.h"
#import "SalesListModel.h"

@interface SalesOptionsView ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_salesTable;
    CGFloat _cellHeight;
    CGFloat _height;
    NSString *_string;
    NSInteger _count;
    BOOL _isSales[10000][10000];
    NSInteger _state;
    NSInteger _stateCount;
    NSMutableArray *_salesArray;
}
@end
@implementation SalesOptionsView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    _count = 1;
    _state = 1;
    _stateCount = 1;
    _salesArray = [[NSMutableArray alloc]init];
    _salesTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 114) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _salesTable.delegate = self;
    // 设置数据源
    _salesTable.dataSource = self;
    _salesTable.backgroundColor = [UIColor whiteColor];
    _salesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self addSubview:_salesTable];

    [self installationMJRefresh_2_GIF];


}
- (void)installationMJRefresh_2_GIF
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 1; i<21; i++) {
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.tiff",i]]];
    }

    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
    // 隐藏刷新状态的文字
    //    footer.refreshingTitleHidden = YES;
    // 设置刷新图片
    [footer setImages:arr forState:MJRefreshStateRefreshing];
    [footer setImages:arr forState:MJRefreshStateIdle];
    [footer setImages:arr forState:MJRefreshStatePulling];
    _salesTable.mj_footer = footer;

    [header setImages:arr forState:MJRefreshStateIdle];
    [header setImages:arr forState:MJRefreshStatePulling];
    [header setImages:arr forState:MJRefreshStateRefreshing];

    _salesTable.mj_header = header;
    // 马上进入刷新状态
    [_salesTable.mj_header beginRefreshing];

}
- (void)refresh
{
    _count = 1;
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [MyInformationRequest postGetMySalesListRequestWithUserId:login.userId page:@"1" Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
        _stateCount = 2;
        if ([errorMessage isEqualToString:@"0"]) {
            _state = 2;
            [_salesArray removeAllObjects];
            for (SalesListModel *mySales in saleArray) {
                [_salesArray addObject:mySales];
            }

        }

    }];

    // 为了看效果 延长3秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        if (_state == 2) {
            _state = 1;
            [_salesTable reloadData];
        }
        if (_stateCount == 2) {
            _stateCount = 1;
            [_salesTable.mj_header endRefreshing];
        }

    });

}
- (void)loadMoreData:(MJRefreshAutoGifFooter *)footer{
    _count ++;
    //    NSLog(@"_count  = %ld",_count);
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [MyInformationRequest postGetMySalesListRequestWithUserId:login.userId page:[NSString stringWithFormat:@"%ld",(long)_count]  Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
        _stateCount = 2;
        if ([errorMessage isEqualToString:@"0"]) {
            if (saleArray.count != 0) {
                _state = 2;
                for (SalesListModel *mySales in saleArray) {
                    [_salesArray addObject:mySales];
                }

            }else{
                [footer endRefreshingWithNoMoreData];
            }

        }

    }];

    // 为了看效果 延长3秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_state == 2) {
            _state = 1;
            [_salesTable reloadData];
        }
        if (_stateCount == 2) {
            _stateCount = 1;
            [_salesTable.mj_footer endRefreshing];
        }

    });
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _salesArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    SalesOptionsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell)
    {
        cell = [[SalesOptionsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    else{
        //cell中本来就有一个subview，如果是重用cell，则把cell中自己添加的subview清除掉，避免出现重叠问题
        //         [[cell.subviews objectAtIndex:1] removeFromSuperview];
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];

    cell.displayBtn.hidden = YES;

    SalesListModel *mySales = [_salesArray objectAtIndex:indexPath.row];
    NSString *carStr;
    if ([[NSString stringWithFormat:@"%@",mySales.salesCarsType]isEqualToString:@"0"]) {
        carStr = @"现车";
    }else{
        carStr = @"期货";
    }

    _string = [NSString stringWithFormat:@"%@ %@ 价格：%@万 %@ %@ %@ %@",mySales.carSeriesName,mySales.carSeriesTypeName,mySales.modelsPrice,carStr,mySales.salesModelsColour,mySales.salesText,mySales.specificationText];

     CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH-20, _string, 15);
    _height = size.height;

    [cell configurationHeight:size.height isOpen:_isSales[indexPath.row][indexPath.section] salesArray:mySales.imageList];

     cell.configuration.text = _string;

    //    cell.displayBtn.tag = indexPath.row;
    //    [cell.displayBtn addTarget:self action:@selector(displayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    if (_isSales[indexPath.row][indexPath.section]) {
    //        CGFloat height = [self heightForConfigurationWithString:_string];
    //        [cell configurationHeight:height isOpen:_isSales[indexPath.row][indexPath.section] salesArray:nil];
    //         cell.displayBtn.hidden = NO;
    //    }else{
    //        CGFloat height = [self heightConfigurationWithString:_string];
    //        if (height < 100) {
    //            cell.displayBtn.hidden = YES;
    //        }else{
    //            cell.displayBtn.hidden = NO;
    //        }
    //        [cell configurationHeight:height isOpen:_isSales[indexPath.row][indexPath.section] salesArray:nil];
    //
    //    }
    cell.salesImage = ^(NSMutableArray *array,NSInteger tag){
        self.salesImage(array,tag);
    };

    return cell;

}
- (CGFloat)heightConfigurationWithString:(NSString *)string{

    CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH-20, string, 15);

    if (size.height < 100) {
        return size.height;
    }else{
        return 100;
    }

}

- (void)displayButtonClick:(UIButton *)button{

    NSIndexPath *index=[NSIndexPath indexPathForRow:button.tag inSection:0];
    _isSales[index.row][0] = !_isSales[index.row][0];
    [_salesTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];

}
- (CGFloat)heightForConfigurationWithString:(NSString *)string{

    CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH-20, string, 15);

    return size.height;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     SalesListModel *salesList = [_salesArray objectAtIndex:indexPath.row];
    return  _height +30 +[self salesHeightViewArray:salesList.imageList];

}
- (CGFloat)salesHeightViewArray:(NSMutableArray *)arr{

    if (![[NSString stringWithFormat:@"%@",arr] isEqualToString:@"<null>"]) {
        if (arr.count != 0) {
            if (arr.count < 4) {
                return (SCREEN_WIDTH - 20)/3;
            }else if (arr.count < 7){
                return (SCREEN_WIDTH - 20)/3 *2;
            }else{
                return (SCREEN_WIDTH - 20)/3 *3;
            }

        }else{

            return 0;
        }

    }else{
        return 0;
    }
    
}

//删除销售用户
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
     SalesListModel *mySales = [_salesArray objectAtIndex:indexPath.row];
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [LCCoolHUD showLoading:@"正在删除，请稍后" inView:self];

    if(editingStyle == UITableViewCellEditingStyleDelete){

        [MyInformationRequest postDeleteMySalesInformationRequestWithUserId:login.userId salesId:mySales.salesId Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
            [LCCoolHUD hideInView:self];

            if ([errorMessage isEqualToString:@"0"]) {
                [LCCoolHUD showSuccess:@"删除成功" zoom:YES shadow:YES];
                [_salesArray removeObjectAtIndex:indexPath.row];
                [_salesTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }


        }];

    }

}
//修改删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
