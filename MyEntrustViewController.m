//
//  MyEntrustViewController.m
//  CarSource
//
//  Created by apple on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//
//我的定金
#import "MyEntrustViewController.h"
#import "MyEntrustViewCell.h"

@interface MyEntrustViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_entrustTable;
}

@end

@implementation MyEntrustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"我的定金";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _entrustTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _entrustTable.delegate = self;
    // 设置数据源
    _entrustTable.dataSource = self;
    _entrustTable.bounces = NO;
    _entrustTable.rowHeight = 120;
    _entrustTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _entrustTable.backgroundColor = GRAY;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_entrustTable];
    [self initMyEntrustViewController];

}
- (void)initMyEntrustViewController{

    NSArray *array = [[NSArray alloc]initWithObjects:@"发布信息", @"建立联系", @"确定交易", @"申请退款", nil];

    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    headerView.backgroundColor = GRAY;

    for (int i = 0; i < array.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4)*i, 0, SCREEN_WIDTH/4, 80)];
        view.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:view];
        UILabel *digitalLabel = [[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width/2-15, 10, 30, 30)];
        digitalLabel.layer.cornerRadius = 15;
        digitalLabel.layer.masksToBounds = YES;
        digitalLabel.textAlignment = NSTextAlignmentCenter;
        digitalLabel.textColor = [UIColor whiteColor];
        digitalLabel.backgroundColor = COLOR;
        digitalLabel.font = [UIFont systemFontOfSize:16];
        digitalLabel.text = [NSString stringWithFormat:@"%d",i+1];
        [view addSubview:digitalLabel];

        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, view.frame.size.width, 25)];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor grayColor];
        textLabel.font = [UIFont systemFontOfSize:15];
        textLabel.text = [array objectAtIndex:i];
        [view addSubview:textLabel];

        
    }

    _entrustTable.tableHeaderView = headerView;

    UIView *submitView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, 100)];
    submitView.backgroundColor = GRAY;

    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"申请退款" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(50,30, SCREEN_WIDTH - 100, 50);
    submitButton.titleLabel.font = [UIFont systemFontOfSize:20];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [submitView addSubview:submitButton];

    _entrustTable.tableFooterView = submitView;

}
- (void)submitButtonClick:(UIButton *)button{

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    MyEntrustViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[MyEntrustViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];

    [cell initMyEntrustViewCellText:@"深圳车老大"];
    cell.searchLabel.text = @"急寻";
    cell.timeLabel.text = @"2016-01-14";
    cell.configuration.text = @"5系4356 德系黑马 手续全 销往内蒙5系4356 内蒙";

    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
