//
//  AppearanceOfInteriorViewController.m
//  CarSource
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppearanceOfInteriorViewController.h"
#import "AppearanceOfInteriorViewCell.h"
#import "MoreViewController.h"

@interface AppearanceOfInteriorViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_appearanceTable;
    NSMutableArray *_appearanceArray;
}

@end

@implementation AppearanceOfInteriorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _appearanceArray = [[NSMutableArray alloc]initWithObjects:@"外观", @"内饰",nil];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"奥迪Q7";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _appearanceTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _appearanceTable.delegate = self;
    // 设置数据源
    _appearanceTable.dataSource = self;
    _appearanceTable.bounces = NO;
    _appearanceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_appearanceTable];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 180)];
    imageView.image = [UIImage imageNamed:@"Q7"];
    [view addSubview:imageView];

    _appearanceTable.tableHeaderView = view;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _appearanceArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    AppearanceOfInteriorViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[AppearanceOfInteriorViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];

    cell.appearanceLabel.text = [_appearanceArray objectAtIndex:indexPath.row];
    [cell initAppearanceOfInteriorViewCellArray:nil];

    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MoreViewController *more = [[MoreViewController alloc]init];
    more.moreStr = [_appearanceArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:more animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((SCREEN_WIDTH - 20)/2 - 80)*2 +90;
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
