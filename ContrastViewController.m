//
//  ContrastViewController.m
//  CarSource
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ContrastViewController.h"
#import "ContrastViewCell.h"
#import "ContrastView.h"

@interface ContrastViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_contrastTable;
}

@end

@implementation ContrastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"对比";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };
    _contrastTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _contrastTable.delegate = self;
    // 设置数据源
    _contrastTable.dataSource = self;
    _contrastTable.bounces = NO;
    _contrastTable.rowHeight = 60;
    _contrastTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contrastTable.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:240/255.0 alpha:1];
    _contrastTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_contrastTable];

    ContrastView *contrastView = [[ContrastView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    _contrastTable.tableHeaderView = contrastView;
    [contrastView initContrastViewArray:nil];


}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 6;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    ContrastViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[ContrastViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}
// 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    view.backgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 37, 70, 10)];
    label.text = @"基本信息";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];

    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.size.equalTo(CGSizeMake(200, 20));
    }];

    return view;
}
// 设置区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
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
