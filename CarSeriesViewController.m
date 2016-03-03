//
//  CarSeriesViewController.m
//  CarSource
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 apple. All rights reserved.
//
//获取指定车系中的所有车型

#import "CarSeriesViewController.h"
#import "CarSeriesViewCell.h"
#import "ImageFigureView.h"
#import "AppearanceOfInteriorViewController.h"
#import "CarSerieType.h"
#import "CarSerieTypeModelAllList.h"
#import "CarSerieTypeModelList.h"

@interface CarSeriesViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_carSeriesTable;
    ImageFigureView *_figure;
    BOOL _isAop[10000];
    NSMutableArray *_selectedArray;
    NSMutableArray *_modelArray;
    NSMutableArray *_departmentArray;
    NSMutableArray *_colorArray;
}

@end

@implementation CarSeriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _carSeriesTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, self.view.frame.size.height-64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _carSeriesTable.delegate = self;
    // 设置数据源
    _carSeriesTable.dataSource = self;
    _carSeriesTable.bounces = NO;
    _carSeriesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_carSeriesTable];
    _selectedArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0", nil];//这个用于判断展开还是缩回当前
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    view.backgroundColor = GRAY;

    NSMutableArray *array = [[NSMutableArray alloc]init];
    _figure = [[ImageFigureView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 180)];
    [_figure initShufflingFigureURL:array furnitureId:0];
    [view addSubview:_figure];
    UIImageView *carImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 180)];
    [view addSubview:carImage];

    _carSeriesTable.tableHeaderView = view;
     [LCCoolHUD showLoading:@"正在加载" inView:self.view];
    [ResourcesRequest postForCarsThatDetailedInformationRequestWithCarSeriesId:self.carSeriesStr showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"]) {
            CarSerieType *carSerie  = [saleArray objectAtIndex:0];
            _modelArray = carSerie.carSerieTypeModelAllList;
            _departmentArray = carSerie.carSerieTypeModelList;
            _colorArray = carSerie.colourList;
            [_carSeriesTable reloadData];
        }
    }];


}
- (void)button{

    AppearanceOfInteriorViewController *interior = [[AppearanceOfInteriorViewController alloc]init];
    [self.navigationController pushViewController:interior animated:YES];

       
}
// 设置表中有多少个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

//    if ([_selectedArray[section] isEqualToString:@"1"])
//    {
        if (section == 0) {
            return _modelArray.count;
            
        }else if (section == 1){
            return _departmentArray.count;
        }else{
            return _colorArray.count;
        }

//    }
//    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    CarSeriesViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell)
    {
        cell = [[CarSeriesViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.priceLabel.hidden = NO;
    cell.guideLabel.hidden = NO;

    if (indexPath.section == 0) {
        CarSerieTypeModelAllList *carSerie = [_modelArray objectAtIndex:indexPath.row];
        cell.typeLabel.text = [NSString stringWithFormat:@"%@",carSerie.carSerieTypeName];
        cell.priceLabel.text = [NSString stringWithFormat:@"%@",carSerie.carSerieTypePrice];


    }else if (indexPath.section == 1){
        CarSerieTypeModelList *carSerie = [_departmentArray objectAtIndex:indexPath.row];
        cell.typeLabel.text = [NSString stringWithFormat:@"%@",carSerie.carSerieTypeName];
        cell.priceLabel.text = [NSString stringWithFormat:@"%@",carSerie.carSerieTypePrice];

    }else{
        cell.priceLabel.hidden = YES;
        cell.guideLabel.hidden = YES;
        
        cell.typeLabel.text = [NSString stringWithFormat:@"%@",[_colorArray objectAtIndex:indexPath.row]];
    }


    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 30;
    }else{
        return 50;
    }

}
// 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *titles = @[@"型号指导价",@"全系指导价",@"颜色大全"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    view.backgroundColor = GRAY;
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 44)];
    bgImage.backgroundColor = LIGHTBLUE;
    [view addSubview:bgImage];

    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = [titles objectAtIndex:section];
    titleLabel.textColor = BLACK;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:titleLabel];
    if (section == 0) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 15, 15)];
        image.image = [UIImage imageNamed:@"eye"];
        [view addSubview:image];
        titleLabel.frame = CGRectMake(30, 10, 80, 44);
    }else{
         titleLabel.frame = CGRectMake(30, 10, SCREEN_WIDTH-60, 44);
    }
    UIButton *penBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    penBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 10, 40, 40);
    //    returnBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //    nextBtn.titleLabel.font = [UIFont systemFontOfSize: 18.0];
    penBtn.tag = 1000 + section;

//    if ([_selectedArray[section] isEqualToString:@"1"])
//    {
//        penBtn.transform = CGAffineTransformMakeRotation(180*M_PI/90);
//    }else{
//        penBtn.transform = CGAffineTransformMakeRotation(180*M_PI/180);
//    }
//    [penBtn setImage: [UIImage imageNamed:@"Pen"] forState:UIControlStateNormal];
    [penBtn setTitle:@"更多" forState:UIControlStateNormal];
    [penBtn addTarget:self action:@selector(penButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:penBtn];

    return view;
}
// 设置区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54;
}
- (void)penButtonClick:(UIButton *)button{
//    if ([_selectedArray[button.tag - 1000] isEqualToString:@"0"]) {
//        [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"1"];
//        [_carSeriesTable reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    else
//    {
//        //如果当前点击的section是展开的,那么点击后就需要把它缩回,使_selectedArray对应的值为0,这样当前section返回cell的个数变成0,然后刷新这个section就行了
//        [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"0"];
//        [_carSeriesTable reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
//    }


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
