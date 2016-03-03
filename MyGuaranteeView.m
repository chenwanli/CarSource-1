//
//  MyGuaranteeView.m
//  CarSource
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyGuaranteeView.h"
#import "OtherGuaranteeViewCell.h"
#import "OtherGuaranteeModel.h"
#import "CarSeriesType.h"
#import "UserInformation.h"

@interface MyGuaranteeView ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_guaranteeTable;
    NSMutableArray *_guaranteeArray;
    CGFloat _cellHeight;
    NSInteger _count;
    NSInteger _state;
    NSInteger _stateCount;

}
@end
@implementation MyGuaranteeView
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

    _guaranteeArray = [[NSMutableArray alloc]init];

    _guaranteeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 114) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _guaranteeTable.delegate = self;
    // 设置数据源
    _guaranteeTable.dataSource = self;
    _guaranteeTable.backgroundColor = [UIColor whiteColor];
    _guaranteeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self addSubview:_guaranteeTable];

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
    _guaranteeTable.mj_footer = footer;

    [header setImages:arr forState:MJRefreshStateIdle];
    [header setImages:arr forState:MJRefreshStatePulling];
    [header setImages:arr forState:MJRefreshStateRefreshing];

    _guaranteeTable.mj_header = header;
    // 马上进入刷新状态
    [_guaranteeTable.mj_header beginRefreshing];

}
- (void)refresh
{
    _count = 1;
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [MyInformationRequest postToObtainAListOfMyGuaranteeRequestWithUserId:login.userId page:@"1" Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
        _stateCount = 2;
        if ([errorMessage isEqualToString:@"0"]) {
            _state = 2;
            [_guaranteeArray removeAllObjects];

            for (OtherGuaranteeModel *guarantee in saleArray) {
                [_guaranteeArray addObject:guarantee];
            }
        }

    }];

    // 为了看效果 延长3秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        if (_state == 2) {
            _state = 1;
            [_guaranteeTable reloadData];
        }
        if (_stateCount == 2) {
            _stateCount = 1;
            [_guaranteeTable.mj_header endRefreshing];
        }

    });

}
- (void)loadMoreData:(MJRefreshAutoGifFooter *)footer{
    _count ++;
    //    NSLog(@"_count  = %ld",_count);
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [MyInformationRequest postToObtainAListOfMyGuaranteeRequestWithUserId:login.userId page:[NSString stringWithFormat:@"%ld",(long)_count] Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
        _stateCount = 2;
        if ([errorMessage isEqualToString:@"0"]) {
            if (saleArray.count != 0) {
                _state = 2;
                for (OtherGuaranteeModel *guarantee in saleArray) {
                    [_guaranteeArray addObject:guarantee];
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
            [_guaranteeTable reloadData];
        }
        if (_stateCount == 2) {
            _stateCount = 1;
            [_guaranteeTable.mj_footer endRefreshing];
        }
        
    });
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _guaranteeArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    OtherGuaranteeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell)
    {
        cell = [[OtherGuaranteeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    OtherGuaranteeModel *guarantee = [_guaranteeArray objectAtIndex:indexPath.row];
    UserInformation *information = [guarantee.userInformation objectAtIndex:0];
    CarSeriesType *carSeries = [guarantee.carSeriesType objectAtIndex:0];

    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,information.userUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];

    cell.configuration.text = [NSString stringWithFormat:@"%@ %@ %@",carSeries.carSeriesBrandName, carSeries.carSeriesName, carSeries.carSeriesTypeName];
    cell.amountLabel.text = [NSString stringWithFormat:@"%@ 元",guarantee.vouchTransactionGuaranteeDepositPrice];
    CGSize detailedHeight = STRING_SIZE_FONT(SCREEN_WIDTH - 20, guarantee.vouchTransactionText, 14);
    [cell initName:[NSString stringWithFormat:@"%@",information.userName] certification:information.userAuthenticateList detailed:detailedHeight.height];

    cell.detailedLabel.text = [NSString stringWithFormat:@"%@",guarantee.vouchTransactionText];
    _cellHeight =detailedHeight.height ;


    if ([[NSString stringWithFormat:@"%@",guarantee.vouchTransactionStatus] isEqualToString:@"0"]) {
        cell.payLabel.text = @"未支付";
    }else if ([[NSString stringWithFormat:@"%@",guarantee.vouchTransactionStatus] isEqualToString:@"1"] ){
        cell.payLabel.text = @"已付款";

    }else{
        cell.payLabel.text = @"交易完成";
    }
    cell.payButton.tag = indexPath.row;
    [cell.payButton addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.credentialsBtn.tag = indexPath.row;
    [cell.credentialsBtn addTarget:self action:@selector(credentialsButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  _cellHeight + 120;

}


- (void)payButtonClick:(UIButton *)button{

    OtherGuaranteeModel *guarantee = [_guaranteeArray objectAtIndex:button.tag];
    if ([[NSString stringWithFormat:@"%@",guarantee.vouchTransactionStatus] isEqualToString:@"0"]) {
        self.payRefund (1);

    }else if ([[NSString stringWithFormat:@"%@",guarantee.vouchTransactionStatus] isEqualToString:@"1"] ){
        self.payRefund (2);

    }else{

    }
}
- (void)credentialsButtonClick:(UIButton *)button{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    OtherGuaranteeModel *guarantee = [_guaranteeArray objectAtIndex:button.tag];
    for (NSString *urlStr in guarantee.vouchTransactionUrlList) {
        [array addObject:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,urlStr]];
    }
    self.credentials(array);
}

//删除销售用户
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherGuaranteeModel *guarantee = [_guaranteeArray objectAtIndex:indexPath.row];
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [LCCoolHUD showLoading:@"正在删除，请稍后" inView:self];

    if(editingStyle == UITableViewCellEditingStyleDelete){

        [MyInformationRequest postDeleteTheGuaranteeRequestWithUserId:login.userId vouchTransactionId:guarantee.vouchTransactionId Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
            [LCCoolHUD hideInView:self];
            if ([errorMessage isEqualToString:@"0"]) {
                [LCCoolHUD showSuccess:@"删除成功" zoom:YES shadow:YES];
                [_guaranteeArray removeObjectAtIndex:indexPath.row];
                [_guaranteeTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
