//
//  SelectAreaViewController.m
//  CarSource
//
//  Created by apple on 16/1/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SelectAreaViewController.h"
#import "provincesModel.h"

@interface SelectAreaViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_provincesTabele;
    BOOL _isChoose[10000][10000];
    UIButton *_btn;
    NSMutableArray *_provincesCoding;
    NSMutableArray *_provincesId;
    NSMutableArray *_provincesName;
    NSMutableArray *_allArray;
    NSMutableArray *_bigArray;
    NSString *_provincesStr;
    NSString *_provincesIdStr;
    NSString *_areaStr;
    NSInteger _section;
    NSInteger _row;
    NSArray *_areaArray;

}


@end

@implementation SelectAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _section = -1;
    _row = -1;
    _areaStr = @"";
    _provincesIdStr = @"";
    _provincesStr = @"";
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"选择区域";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };
   UIButton *determineButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    determineButton.frame = CGRectMake(SCREEN_WIDTH - 100, 10, 100, 54);
    [determineButton setTitle:@"提交" forState:UIControlStateNormal];
    determineButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(determineButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:determineButton];

    _provincesTabele = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _provincesTabele.dataSource = self;
    _provincesTabele.delegate = self;
    _provincesTabele.bounces = NO;
    //    _destinationTable.sectionIndexBackgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];//设置右边字体索引背景颜色
    _provincesTabele.sectionIndexColor = [UIColor grayColor];//设置右边字体颜色

    [self.view addSubview: _provincesTabele];

    _areaArray = [[NSArray alloc]initWithObjects:@"东区",@"南区", @"西区",@"北区", nil];

    UIView *areaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
    areaView.backgroundColor = GRAY;

    for (int i = 0; i < _areaArray.count; i++) {
        UIButton *areaButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        areaButton.frame = CGRectMake(0, 44*i, SCREEN_WIDTH-15, 44);
        areaButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [areaButton setTitle:[NSString stringWithFormat:@"  %@",[_areaArray objectAtIndex:i]] forState:UIControlStateNormal];
        areaButton.tag = i+ 1;
//        areaButton.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
        areaButton.layer.borderColor = GRAY.CGColor;
        areaButton.layer.borderWidth = 1.0;
        areaButton.backgroundColor = [UIColor whiteColor];
        areaButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [areaButton setTitleColor:BLACK forState:UIControlStateNormal];
        [areaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [areaButton setBackgroundImage:[UIImage imageNamed:@"obvious"] forState:UIControlStateSelected];
        [areaButton setBackgroundImage:[UIImage imageNamed:@"Reports"] forState:UIControlStateNormal];
        [areaButton addTarget:self action:@selector(areaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [areaView addSubview:areaButton];

    }


    UILabel *areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 186, SCREEN_WIDTH, 34)];
    areaLabel.text = @"  选择省份";
    areaLabel.font = [UIFont systemFontOfSize:14];
    areaLabel.textColor = [UIColor grayColor];
    areaLabel.backgroundColor = [UIColor colorWithRed:224/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    [areaView addSubview:areaLabel];

    _provincesTabele.tableHeaderView = areaView;

    _provincesCoding = [[NSMutableArray alloc]init];
    _provincesId = [[NSMutableArray alloc]init];
    _provincesName = [[NSMutableArray alloc]init];
    _allArray = [[NSMutableArray alloc]init];
    _bigArray = [[NSMutableArray alloc]init];

    [LCCoolHUD showLoading:@"正在加载" inView:self.view];
    [ResourcesRequest postListForProvinceInTheCityWithCarShowCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {

        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"]) {
            NSString *str = @"";
            for (provincesModel *provinces in saleArray) {

                  //表格右边的索引，有不管ABCD有多少个，但是只取出ABCD就行，有可能很多个A ，但是只取一个，可以当做显示在表格右边的标题里
                if (![[NSString stringWithFormat:@"%@",provinces.cityCoding] isEqualToString:str]) {
                    [_provincesCoding addObject:provinces.cityCoding];
//                    [_provincesId addObject:provinces.cityId];
//                    [_provincesName addObject:provinces.cityName];
                }
                str = provinces.cityCoding;
                [_allArray addObject:provinces];
            }
            [_bigArray removeAllObjects];

            for (NSString *string in _provincesCoding) {
                //_provincesCoding表格右边所有的标题
                //每一个区的数据，这是根据ABCD来分组的，也就是说A组有多少个数据全部存进A组里面
                NSMutableArray *indexArray = [[NSMutableArray alloc] initWithCapacity:0];

                for (provincesModel *model in _allArray) {

                    if ([[NSString stringWithFormat:@"%@",model.cityCoding] isEqualToString:string]) {
                        //根据所含有相同标题的全部取出来放进同一个数组
                        [indexArray addObject:model];
                    }
                }
                //每一个标题下都有一组数据，就是一个数组

                [_bigArray addObject:indexArray];
            }

            [_provincesTabele reloadData];
        }
    }];


}
- (void)determineButtonClick:(UIButton *)button{

    if ([_areaStr isEqualToString:@""] && [_provincesIdStr isEqualToString:@""] ) {
        SHOW_ALERT(@"请选择区域或省份");
        return;
    }
   //    NSLog(@" _areaStr = %@   _provincesIdStr = %@",_areaStr,_provincesIdStr );
    self.provinces(_provincesStr,_provincesIdStr,_areaStr);

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)areaButtonClick:(UIButton *)button{

    _btn.selected = NO;
    button.selected = YES;
    _btn = button;
    _areaStr = [_areaArray objectAtIndex:button.tag-1];

//    if (button.selected) {
//         button.backgroundColor = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:240/255.0 alpha:1];
//    }else{
//         button.backgroundColor = [UIColor whiteColor];
//    }
}
#pragma --
#pragma mark UITableView
// UITableViewDataSource协议中的方法，该方法的返回值决定表格包含多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    // _bigArray集合包含多少个元素，就包含多少个分区
    return _bigArray.count;
}
// UITableViewDataSource协议中的方法，该方法的返回值决定指定分区包含多少个元素
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[_bigArray objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView
                             dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    provincesModel *provinces = [[_bigArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",provinces.cityName];
    cell.textLabel.textColor = BLACK;
    cell.textLabel.font = [UIFont systemFontOfSize:16];

    if (_row == indexPath.row && _section == indexPath.section) {
        cell.backgroundColor = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:240/255.0 alpha:1];
        cell.textLabel.textColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor grayColor];
    }


    return cell;
}
// UITableViewDataSource协议中的方法，该方法的返回值用于在表格右边建立一列浮动的索引。
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{

    return _provincesCoding;
}
// UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的页眉
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_provincesCoding  objectAtIndex:section];
}
-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    provincesModel *provinces = [[_bigArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    _provincesStr = provinces.cityName;
    _provincesIdStr = provinces.cityId;
    _section = indexPath.section;
    _row = indexPath.row;
//    _isChoose[indexPath.section][indexPath.row] = !_isChoose[indexPath.section][indexPath.row];
    [tableView reloadData];

}
// 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:225/255.0 alpha:1];
    UILabel *label = [[UILabel alloc]init];
    label.text = [_provincesCoding objectAtIndex:section];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:12];
    [view addSubview:label];

    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.size.equalTo(CGSizeMake(200, 15));
    }];

    return view;
}
// 设置区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
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
