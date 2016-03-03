//
//  ProvincesViewController.m
//  CarSource
//
//  Created by apple on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ProvincesViewController.h"

@interface ProvincesViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_provincesTabele;
    NSArray *_bigArray;
    NSArray *_arr;
    NSArray *_provincesArray;
}

@end

@implementation ProvincesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"选择省份";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };


    _provincesTabele = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _provincesTabele.dataSource = self;
    _provincesTabele.delegate = self;
    _provincesTabele.bounces = NO;
    //    _destinationTable.sectionIndexBackgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];//设置右边字体索引背景颜色
    _provincesTabele.sectionIndexColor = [UIColor grayColor];//设置右边字体颜色

    //表格右边的索引，有不管ABCD有多少个，但是只取出ABCD就行，有可能很多个A ，但是只取一个，可以当做显示在表格右边的标题里
    [self.view addSubview: _provincesTabele];
    NSArray *aArrry = [[NSArray alloc]initWithObjects:@"安徽省", nil];
    NSArray *bArrry = [[NSArray alloc]initWithObjects:@"北京市", nil];

    NSArray *cArrry = [[NSArray alloc]initWithObjects:@"重庆市", nil];
    NSArray *fArrry = [[NSArray alloc]initWithObjects:@"福建省", nil];
    NSArray *gArrry = [[NSArray alloc]initWithObjects:@"甘肃省", @"广东省",@"广西壮族",@"贵州省",nil];
    NSArray *hArrry = [[NSArray alloc]initWithObjects:@"海南省", @"河北省",@"河南省",@"黑龙江省",@"湖北省",@"湖南省",nil];
    NSArray *jArrry = [[NSArray alloc]initWithObjects:@"吉林省",@"江苏省",@"江西省", nil];
    NSArray *lArrry = [[NSArray alloc]initWithObjects:@"辽宁省", nil];
    NSArray *nArrry = [[NSArray alloc]initWithObjects:@"内蒙古",@"宁夏回族", nil];
    NSArray *qArrry = [[NSArray alloc]initWithObjects:@"青海省", nil];
    NSArray *sArrry = [[NSArray alloc]initWithObjects:@"山东省",@"山西省", @"陕西省",@"上海市",@"四川省",nil];
    NSArray *tArrry = [[NSArray alloc]initWithObjects:@"天津市", nil];
    NSArray *xArrry = [[NSArray alloc]initWithObjects:@"西藏", @"新疆维吾尔",nil];
    NSArray *yArrry = [[NSArray alloc]initWithObjects:@"云南省", nil];
    NSArray *zArrry = [[NSArray alloc]initWithObjects:@"浙江省", nil];

    _bigArray = [[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"F",@"G",@"H",@"J",@"L",@"N",@"Q",@"S",@"T",@"X",@"Y", @"Z", nil];
    _arr = [[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"F",@"G",@"H",@"J",@"L",@"N",@"Q",@"S",@"T",@"X",@"Y", @"Z",nil];
    _provincesArray = [[NSArray alloc]initWithObjects:aArrry,bArrry,cArrry,fArrry,gArrry,hArrry,jArrry,lArrry,nArrry,qArrry,sArrry,tArrry,xArrry,yArrry,zArrry, nil];

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
        return [[_provincesArray objectAtIndex:section] count];
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
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [[_provincesArray objectAtIndex:indexPath.section ]objectAtIndex:indexPath.row ];
    cell.textLabel.textColor = [UIColor grayColor];

    return cell;
}
// UITableViewDataSource协议中的方法，该方法的返回值用于在表格右边建立一列浮动的索引。
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{

    return _arr;
}
// UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的页眉
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_arr  objectAtIndex:section];


}
-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
// 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    view.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:225/255.0 alpha:1];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 37, 70, 10)];
    label.text = [_arr objectAtIndex:section];
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
