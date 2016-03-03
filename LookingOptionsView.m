//
//  LookingOptionsView.m
//  CarSource
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 apple. All rights reserved.
//
//求购车源
#import "LookingOptionsView.h"
#import "SalesOptionsViewCell.h"
#import "LookingOptionsViewCell.h"
#import "findCarModel.h"

@interface LookingOptionsView ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_lookingTable;
    NSMutableArray *_lookingArray;
    NSInteger _count;
    NSInteger _state;
    NSInteger _stateCount;
    CGFloat _cellHeight;
    BOOL _isLooking;
}
@end
@implementation LookingOptionsView
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
    _lookingArray = [[NSMutableArray alloc]init];
    _lookingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 114) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _lookingTable.delegate = self;
    // 设置数据源
    _lookingTable.dataSource = self;
    _lookingTable.backgroundColor = [UIColor whiteColor];
    _lookingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self addSubview:_lookingTable];




}
- (void)installationMJRefresh{
    if (_isLooking == NO) {
        _isLooking = YES;
         [self installationMJRefresh_2_GIF];
    }
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
    _lookingTable.mj_footer = footer;

    [header setImages:arr forState:MJRefreshStateIdle];
    [header setImages:arr forState:MJRefreshStatePulling];
    [header setImages:arr forState:MJRefreshStateRefreshing];

    _lookingTable.mj_header = header;
    // 马上进入刷新状态
    [_lookingTable.mj_header beginRefreshing];

}
- (void)refresh
{
    _count = 1;
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [MyInformationRequest postIFoundTheCarInformationListRequestWithUserId:login.userId page:@"1" Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {

        _stateCount = 2;
        if ([errorMessage isEqualToString:@"0"]) {
            _state = 2;
            [_lookingArray removeAllObjects];
            for (findCarModel *findCar in saleArray) {
                [_lookingArray addObject:findCar];
            }

        }

    }];

    // 为了看效果 延长3秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        if (_state == 2) {
            _state = 1;
            [_lookingTable reloadData];
        }
        if (_stateCount == 2) {
            _stateCount = 1;
            [_lookingTable.mj_header endRefreshing];
        }

    });

}
- (void)loadMoreData:(MJRefreshAutoGifFooter *)footer{
    _count ++;
    //    NSLog(@"_count  = %ld",_count);
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [MyInformationRequest postIFoundTheCarInformationListRequestWithUserId:login.userId page:[NSString stringWithFormat:@"%ld",(long)_count]  Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {

        _stateCount = 2;
        if ([errorMessage isEqualToString:@"0"]) {
            _state = 2;

            if (saleArray.count != 0) {
                for (findCarModel *findCar in saleArray) {
                    [_lookingArray addObject:findCar];
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
            [_lookingTable reloadData];
        }
        if (_stateCount == 2) {
            _stateCount = 1;
            [_lookingTable.mj_footer endRefreshing];
        }
        
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _lookingArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    LookingOptionsViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[LookingOptionsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];

    findCarModel *findCar = [_lookingArray objectAtIndex:indexPath.row];
    cell.lookingLabel.text = [NSString stringWithFormat:@"%@",findCar.searchCarText];
   _cellHeight =  [self heightForConfigurationWithString:[NSString stringWithFormat:@"%@",findCar.searchCarText]];
    [cell lookingOptionsViewCellHeight:_cellHeight];

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",findCar.searchCarTime] doubleValue] / 1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:date];
    cell.timeLabel.text = dateString;
    

    
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)heightForConfigurationWithString:(NSString *)string{

    CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH-20, string, 15);

    return size.height;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    findCarModel *findCar = [_lookingArray objectAtIndex:indexPath.row];
    return  _cellHeight + 40;
    
}
//删除销售用户
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   findCarModel *findCar = [_lookingArray objectAtIndex:indexPath.row];
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [LCCoolHUD showLoading:@"正在删除，请稍后" inView:self];

    if(editingStyle == UITableViewCellEditingStyleDelete){

        [MyInformationRequest postDeleteMyCarInformationRequestWithUserId:login.userId salesId:findCar.searchCarId Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {

            [LCCoolHUD hideInView:self];
            if ([errorMessage isEqualToString:@"0"]) {
                [LCCoolHUD showSuccess:@"删除成功" zoom:YES shadow:YES];
                [_lookingArray removeObjectAtIndex:indexPath.row];
                [_lookingTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
