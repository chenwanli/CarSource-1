//
//  AllModelsViewController.m
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AllModelsViewController.h"
#import "CarSeriesTypeModel.h"

@interface AllModelsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_modelsTable;
    NSMutableArray *_modelsArray;
}

@end

@implementation AllModelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"车型";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _modelsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _modelsTable.delegate = self;
    // 设置数据源
    _modelsTable.dataSource = self;
    _modelsTable.bounces = NO;
    _modelsTable.rowHeight = 50;
    //    _carSeriesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_modelsTable];

    [LCCoolHUD showLoading:@"正在加载" inView:self.view];
    [NetworkRequest postAccessToSpecifyAllTheModelsInTheCarsRequestWithCarSeriesId:self.modelsStr  showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {

        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"]) {

            _modelsArray = saleArray;
            [_modelsTable reloadData];

        }
    }];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _modelsArray.count;


}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = BLACK;
    cell.textLabel.font = [UIFont systemFontOfSize:16];

    CarSeriesTypeModel *carSeries = [_modelsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",carSeries.carSeriesTypeName];

    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CarSeriesTypeModel *carSeries = [_modelsArray objectAtIndex:indexPath.row];
    if (self.navCount == 1) {
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSString stringWithFormat:@"%@",carSeries.carSeriesTypeName] forKey:@"carSeriesTypeName"];
        [defaults setObject:[NSString stringWithFormat:@"%@",carSeries.carSeriesTypeId] forKey:@"carSeriesTypeId"];

    }else{

        self.allModels([NSString stringWithFormat:@"%@",carSeries.carSeriesTypeName],[NSString stringWithFormat:@"%@",carSeries.carSeriesTypeId]);
        
    }

    [self.navigationController popToViewController: self.navigationController.viewControllers[self.navCount] animated:YES];
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
