//
//  MemorialViewController.m
//  CarSource
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MemorialViewController.h"
#import "MemorialViewCell.h"
#import "TransactionVehicles.h"
#import "ForDetailsViewController.h"

@interface MemorialViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_memorialTable;
    NSMutableArray *_memorialArray;
    NSInteger _state;
    NSInteger _stateCount;
    NSInteger _count;
}
@end

@implementation MemorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _count = 1;
    _state = 1;
    _stateCount = 1;

    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"最新交车";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };
    _memorialArray = [[NSMutableArray alloc]init];
    _memorialTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _memorialTable.delegate = self;
    // 设置数据源
    _memorialTable.dataSource = self;
    //    _memorialTable.bounces = NO;
    _memorialTable.backgroundColor = [UIColor whiteColor];
    _memorialTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_memorialTable];

    [self initLatestBelowViewController];
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
    _memorialTable.mj_footer = footer;

    [header setImages:arr forState:MJRefreshStateIdle];
    [header setImages:arr forState:MJRefreshStatePulling];
    [header setImages:arr forState:MJRefreshStateRefreshing];

    _memorialTable.mj_header = header;
    // 马上进入刷新状态
    [_memorialTable.mj_header beginRefreshing];

}
- (void)refresh
{
    _count = 1;
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [NetworkRequest postPayTheCarListInformationRequestWithUserId:login.userId showroomId:self.showroomId page:@"1" showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
        _stateCount = 2;
        if ([errorMessage isEqualToString:@"0"]) {

            if (saleArray.count != 0) {
                [_memorialArray removeAllObjects];
                _state = 2;
                for (TransactionVehicles *vehicles in saleArray) {
                    [_memorialArray addObject:vehicles];
                }
            }
        }
    }];

    // 为了看效果 延长3秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        if (_state == 2) {
            _state = 1;
            [_memorialTable reloadData];
        }
        if (_stateCount == 2) {
            _stateCount = 1;
            [_memorialTable.mj_header endRefreshing];
        }

    });

}

- (void)loadMoreData:(MJRefreshAutoGifFooter *)footer{
    _count ++;
    //    NSLog(@"_count  = %ld",_count);
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [NetworkRequest postPayTheCarListInformationRequestWithUserId:login.userId showroomId:self.showroomId page:[NSString stringWithFormat:@"%ld",(long)_count] showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
        _stateCount = 2;
        if ([errorMessage isEqualToString:@"0"]) {

            if (saleArray.count != 0) {
                _state = 2;
                for (TransactionVehicles *vehicles in saleArray) {
                    [_memorialArray addObject:vehicles];
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
            [_memorialTable reloadData];
        }
        if (_stateCount == 2) {
            _stateCount = 1;
            [_memorialTable.mj_footer endRefreshing];
        }

    });

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _memorialArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    MemorialViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MemorialViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = GRAY;
    TransactionVehicles *vehicles = [_memorialArray objectAtIndex:indexPath.row];
    [cell.memorialImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,vehicles.transactionVehiclesUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
    cell.carLabel.text = [NSString stringWithFormat:@"%@",vehicles.transactionVehiclesModels];

    cell.detailedLabel.text = [NSString stringWithFormat:@"%@",vehicles.transactionVehiclesIntroduction];

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",vehicles.transactionVehiclesTime] doubleValue] / 1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:date];

    cell.priceLabel.text = dateString;


    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     TransactionVehicles *vehicles = [_memorialArray objectAtIndex:indexPath.row];
    ForDetailsViewController *forDetails = [[ForDetailsViewController alloc]init];
    forDetails.transactionVehiclesId = vehicles.transactionVehiclesId;
    [self.navigationController pushViewController:forDetails animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [LCCoolHUD showLoading:@"正在删除，请稍等" inView:self.view];
        TransactionVehicles *vehicles = [_memorialArray objectAtIndex:indexPath.row];
        LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
        [NetworkRequest postDeleteCarRecordsRequestWithUserId:login.userId transactionVehiclesId:vehicles.transactionVehiclesId Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
            [LCCoolHUD hideInView:self.view];
            if ([errorMessage isEqualToString:@"0"]) {
                [_memorialArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [LCCoolHUD showSuccess:@"删除成功" zoom:YES shadow:YES];
            }
        }];

    }
    
}
//修改删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.userStatus == YES) {
        return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }

}

- (void)initLatestBelowViewController{

    UIImageView *shareImage = [[UIImageView alloc]init];
    shareImage.image = [UIImage imageNamed:@"twenty-seven"];
    [self.view addSubview:shareImage];

    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [shareButton setImage:[UIImage imageNamed:@"twenty-seven"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    [shareImage makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(@30);
        make.size.equalTo(CGSizeMake(25, 25));

    }];

    [shareButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(@0);
        make.top.equalTo(@0);
        make.size.equalTo(CGSizeMake(80, 64));

    }];
}
- (void)shareButtonClick{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
