//
//  TradingViewController.m
//  CarSource
//
//  Created by apple on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//
//交易担保
#import "TradingViewController.h"
#import "TradingView.h"
#import "TradingViewCell.h"
#import "DetailedViewController.h"
#import "GuaranteeDetailsViewController.h"
#import "RecentlySecuredModel.h"
#import "UserInformation.h"
#import "DateFormater.h"

@interface TradingViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tradingTable;
    NSMutableArray *_tradingArray;
    NSInteger _cellHeight;

}

@end

@implementation TradingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = GRAY;

    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"交易担保";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _tradingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _tradingTable.delegate = self;
    // 设置数据源
    _tradingTable.dataSource = self;
    _tradingTable.bounces = NO;
    _tradingTable.backgroundColor = [UIColor whiteColor];
//    _tradingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_tradingTable];

    TradingView *trading = [[TradingView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 310)];
    _tradingTable.tableHeaderView = trading;

    trading.detailed = ^(NSString *detailed){

        DetailedViewController *detailedView = [[DetailedViewController alloc]init];
        [self.navigationController pushViewController:detailedView animated:YES];

    };

    trading.depositBtn = ^(NSString *depositBtn){

        GuaranteeDetailsViewController *guarantee = [[GuaranteeDetailsViewController alloc]init];
        [self.navigationController pushViewController:guarantee animated:YES];

    };

     [LCCoolHUD showLoading:@"正在加载" inView:self.view];
    [MyInformationRequest postToObtainAListOfMyRecentTradingGuaranteeRequestWithCompletion:^(NSMutableArray *saleArray, NSString *errorMessage) {
        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"]) {
            _tradingArray = saleArray;

            [_tradingTable reloadData];
        }


    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _tradingArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    TradingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell)
    {
        cell = [[TradingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    RecentlySecuredModel *recently = [_tradingArray objectAtIndex:indexPath.row];
    UserInformation *information = [recently.userInformation objectAtIndex:0];

    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,information.userUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
//    cell.nameLabel.text =[NSString stringWithFormat:@"%@",recently.guaranteeName];
    cell.configuration.text = [NSString stringWithFormat:@"%@  %@",recently.guaranteeCarName,recently.guaranteeCarPrice];
    cell.timeLabel.text = [DateFormater numberString:recently.guaranteeTime];
    cell.moneyLabel.text = [NSString stringWithFormat:@"%@ 元",recently.guaranteeDepositPrice];
    cell.userLabel.text = [NSString stringWithFormat:@"%@",information.userName];
    [cell moneyText:[NSString stringWithFormat:@"%@ 元",recently.guaranteeDepositPrice]];
    NSString *string = [NSString stringWithFormat:@"%@  %@",recently.guaranteeCarName,recently.guaranteeCarPrice];
    CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH -130, string, 16);
    _cellHeight = size.height;
    [cell initName:recently.guaranteeName certification:information.userAuthenticateList detailed:size.height];

    [cell.credentialsBtn setTitle:[NSString stringWithFormat:@"%@",recently.guaranteeStatus] forState:UIControlStateNormal];
    
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{

    return _cellHeight + 70;
}

- (void)initTradingViewController:(UIButton *)button{

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
