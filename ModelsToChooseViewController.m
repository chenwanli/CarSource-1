//
//  ModelsToChooseViewController.m
//  CarSource
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ModelsToChooseViewController.h"
#import "ModelsToChooseViewCell.h"
#import "SpecificationModel.h"
#import "ChooseBrandViewController.h"

@interface ModelsToChooseViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_modelsTable;
    NSMutableArray *_modelsArray;
}

@end

@implementation ModelsToChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"车型选择";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

//    _modelsArray = [[NSMutableArray alloc]init];
    _modelsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _modelsTable.delegate = self;
    // 设置数据源
    _modelsTable.dataSource = self;
    _modelsTable.bounces = NO;
    _modelsTable.rowHeight = 60;
    _modelsTable.backgroundColor = GRAY;
    _modelsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_modelsTable];

    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
     [LCCoolHUD showLoading:@"正在加载" inView:self.view];
    [NetworkRequest postGetAllTheSpecificationsSetRequestWithUserId:login.userId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {

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
    ModelsToChooseViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[ModelsToChooseViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = GRAY;
    SpecificationModel *specification = [_modelsArray objectAtIndex:indexPath.row];
    cell.typeLabel.text = [NSString stringWithFormat:@"  %@",specification.specificationText];

    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

     SpecificationModel *specification = [_modelsArray objectAtIndex:indexPath.row];
    if (self.isChooseType == YES) {

        ChooseBrandViewController *chooseBrand = [[ChooseBrandViewController alloc]init];
        chooseBrand.isChoose = YES;
        chooseBrand.navCount = 1;
        chooseBrand.specificationId = specification.specificationId;
        [self.navigationController pushViewController:chooseBrand animated: YES];
        chooseBrand.vehicleId = ^(NSString *vehicleId,NSString *vehicleName,NSString *specificationId,NSString *specifications){


            
        };
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSString stringWithFormat:@"%@",specification.specificationText] forKey:@"specificationText"];
        [defaults setObject:[NSString stringWithFormat:@"%@",specification.specificationId] forKey:@"specificationId"];

    }else{
        SpecificationModel *specification = [_modelsArray objectAtIndex:indexPath.row];
        //    NSLog(@"specification.specificationId = %@",specification.specificationId);
        self.chooseType([NSString stringWithFormat:@"%@",specification.specificationId],[NSString stringWithFormat:@"%@",specification.specificationText]);
        [self.navigationController popViewControllerAnimated:YES];

    }

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
