//
//  ChooseBrandViewController.m
//  CarSource
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//
// 选择品牌
#import "ChooseBrandViewController.h"
#import "CarPicturesViewCell.h"
#import "ModelsToChooseViewController.h"
#import "BrandModel.h"
#import "SpecifiedBrandView.h"
#import "CHDViewController.h"
#import "CarSeriesViewController.h"
#import "AppearanceOfInteriorViewController.h"
#import "AllModelsViewController.h"

@interface ChooseBrandViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_brandTable;
    NSMutableArray *_chooseArray;
    UIButton *_typeButton;
//    BOOL _isChoose[10000][10000];
    NSInteger _row;
    NSInteger _section;
    SpecifiedBrandView *_specified;
    NSInteger _integer;
    NSMutableArray *_brandInitialsArray;
}
@property (nonatomic,strong)NSString *chooseType;
@property (nonatomic,strong)NSString *specifications;

@end

@implementation ChooseBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _row = -1;
    _section = -1;
    _integer = 0;
    _brandInitialsArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];

    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"选择品牌";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    _brandTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT -114) style:UITableViewStyleGrouped];
    _brandTable.dataSource = self;
    _brandTable.delegate = self;
    _brandTable.bounces = NO;
    _brandTable.rowHeight = 60;
    //    _destinationTable.sectionIndexBackgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];//设置右边字体索引背景颜色
    _brandTable.sectionIndexColor = [UIColor grayColor];//设置右边字体颜色

    //表格右边的索引，有不管ABCD有多少个，但是只取出ABCD就行，有可能很多个A ，但是只取一个，可以当做显示在表格右边的标题里
    [self.view addSubview: _brandTable];
    if ([[NSString stringWithFormat:@"%@",self.specificationId] isEqualToString:@""] || self.specificationId == nil) {
        [LCCoolHUD showLoading:@"正在加载" inView:self.view];
        LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
        [NetworkRequest postGetAllTheBrandCollectionsRequestWithUserId:login.userId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
            [LCCoolHUD hideInView:self.view];
            if ([errorMessage isEqualToString:@"0"]) {
                  [_brandInitialsArray removeAllObjects];
                _chooseArray = saleArray;
                for (int i = 0; i < saleArray.count; i++) {
                    NSArray *array = saleArray[i];
                    if (array.count > 0)
                    {
                        ResultArray *model = array[0];
                        [_brandInitialsArray addObject:model.brandInitials];
                    }

                }
                [_brandTable reloadData];
            }
        }];

    }else{
        [self initSpecificationId:self.specificationId];
    }

    if (_isChoose == YES) {
        if (_isExhibition == YES) {
            [self initParallelImports];
            [self initChooseBrandView];
        }else{
            _brandTable.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64);
            [self initChooseBrandView];

        }
    }else{
        [self initParallelImports];
    }


}

- (void)initSpecificationId:(NSString *)specificationId{

    [LCCoolHUD showLoading:@"正在加载" inView:self.view];
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [NetworkRequest postSpecifyTheSpecificationsBrandRequestWithUserId:login.userId specificationId:specificationId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"]) {
            [_brandInitialsArray removeAllObjects];
            _chooseArray = saleArray;
            for (int i = 0; i < saleArray.count; i++) {
                NSArray *array = saleArray[i];
                if (array.count > 0)
                {
                    ResultArray *model = array[0];
                    [_brandInitialsArray addObject:model.brandInitials];
                }

            }
            [_brandTable reloadData];
        }

    }];
}



- (void)initParallelImports{

    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.tag = 40;
    textLabel.text = @"平行进口";
    textLabel.textColor = COLOR;
    textLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:textLabel];

    _typeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_typeButton setTitle:@"美规 中东 欧版 加版" forState:UIControlStateNormal];
    _typeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_typeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_typeButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_typeButton];

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.tag = 41;
    imageView.image = [UIImage imageNamed:@"milled"];
    [self.view addSubview:imageView];

    [textLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@64);
        make.size.equalTo(CGSizeMake(70, 50));
    }];


    [_typeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(80);
        make.top.equalTo(@64);
        make.right.equalTo(self.view).offset(-30);
        make.height.equalTo(@50);
    }];

    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(@80);
        make.size.equalTo(CGSizeMake(15, 18));
    }];


}

- (void)initChooseBrandView{


    _specified = [[SpecifiedBrandView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 64, SCREEN_WIDTH - 70, SCREEN_HEIGHT -64)];
    _specified.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_specified];


   __weak ChooseBrandViewController *choose = self;

    _specified.specified = ^(NSString *str){

//        [NetworkRequest postAccessToSpecifyAllTheModelsInTheCarsRequestWithCarSeriesId:str showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
//
//        }];

//        NSMutableArray *titleArray = [[NSMutableArray alloc]initWithObjects:@"2013款",@"2014款",@"2015款",nil];
//        CHDViewController *chd = [[CHDViewController alloc] init];
//        for (int i = 0; i < titleArray.count; i++) {
//            CarSeriesViewController *carSeries = [[CarSeriesViewController alloc]init];
//            [chd.ScrollControllersArr addObject:carSeries];
//            if (i == 0) {
//                carSeries.view.backgroundColor = [UIColor redColor];
//            }else if (i == 1){
//                  carSeries.view.backgroundColor = [UIColor grayColor];
//            }else{
//                  carSeries.view.backgroundColor = [UIColor greenColor];
//            }
//            carSeries.carSeries = ^(NSString *str){
//                AppearanceOfInteriorViewController *interior = [[AppearanceOfInteriorViewController alloc]init];
//                [choose.navigationController pushViewController:interior animated:YES];
//
//            };
//            
//
//        }
//        chd.nameArr = [NSMutableArray arrayWithArray:titleArray];
//        chd.tag = 1;
//        chd.titleStr = @"奥迪Q7";
//        [choose.navigationController pushViewController:chd animated:YES];
        if (choose.chooseBrand == 10) {
            CarSeriesViewController *carSeries = [[CarSeriesViewController alloc]init];
            carSeries.carSeriesStr = str;
            [choose.navigationController pushViewController:carSeries animated:YES];
        }else{

            AllModelsViewController *allModels = [[AllModelsViewController alloc]init];
            allModels.modelsStr = str;
            allModels.navCount = choose.navCount;
            [choose.navigationController pushViewController:allModels animated:YES];
            if (_isExhibition == YES) {
                allModels.allModels = ^(NSString *carSeriesTypeName,NSString *carSeriesTypeId){
                    if ([choose.chooseType isEqualToString:@""] || choose.chooseType == nil) {
                        choose.chooseType = @"1";
                    }
                    choose.exhibition(carSeriesTypeName,carSeriesTypeId,choose.chooseType,choose.specifications);
                };
            }else{
                allModels.allModels = ^(NSString *carSeriesTypeName,NSString *carSeriesTypeId){
                    choose.carSeriesStr( carSeriesTypeName,carSeriesTypeId);
                };
            }


        }
    };




}
- (void)submitButtonClick:(UIButton *)button{
     [self.navigationController popViewControllerAnimated:YES];

}

- (void)typeButtonClick:(UIButton *)button{

    ModelsToChooseViewController *modelsView = [[ModelsToChooseViewController alloc]init];
    [self.navigationController pushViewController:modelsView animated:YES];

    modelsView.chooseType = ^(NSString *chooseType,NSString *text){

        _brandTable.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        _typeButton.hidden = YES;
        UILabel *label = (UILabel *)[self.view viewWithTag:40];
        label.hidden = YES;
        UIImageView *image = (UIImageView *)[self.view viewWithTag:41];
        image.hidden = YES;
        _chooseType = chooseType;

        _specifications = text;
        self.specificationId = chooseType;

         [self initSpecificationId:chooseType];
    };


}

#pragma --
#pragma mark UITableView
// UITableViewDataSource协议中的方法，该方法的返回值决定表格包含多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    // _bigArray集合包含多少个元素，就包含多少个分区
    return _chooseArray.count;
}
// UITableViewDataSource协议中的方法，该方法的返回值决定指定分区包含多少个元素
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[_chooseArray objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"Cell";
    CarPicturesViewCell* cell = [tableView
                                 dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[CarPicturesViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // 将单元格的边框设置为圆角
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    ResultArray *model = [[_chooseArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.carLabel.text = [NSString stringWithFormat:@"%@",model.brandName];
    [cell.carImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,model.brandLogo]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];

    if (_row == indexPath.row && _section == indexPath.section) {
        cell.backgroundColor = COLOR;
        cell.carLabel.textColor = [UIColor whiteColor];
    }else{
         cell.backgroundColor = [UIColor whiteColor];
         cell.carLabel.textColor = [UIColor grayColor];
    }

    return cell;
}
// UITableViewDataSource协议中的方法，该方法的返回值用于在表格右边建立一列浮动的索引。
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _brandInitialsArray;
}
// UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的页眉
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//     NSArray *array = _chooseArray[section];
//     ResultArray *model = array[0];
    return [_brandInitialsArray objectAtIndex:section];
}
-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


//    _isChoose[indexPath.section][indexPath.row] = !_isChoose[indexPath.section][indexPath.row];
    ResultArray *model = [[_chooseArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];


    _row = indexPath.row;
    _section = indexPath.section;

    if (self.chooseBrand == 12) {

        if ([_chooseType isEqualToString:@""] || _chooseType == nil) {
            _chooseType = @"1";
        }
        self.vehicleId([NSString stringWithFormat:@"%@",model.brandId],[NSString stringWithFormat:@"%@",model.brandName],_chooseType,_specifications);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        _integer = 0;
        [UIView animateWithDuration:0.5 animations:^{
            _specified.frame = CGRectMake(70, 64, SCREEN_WIDTH - 70, SCREEN_HEIGHT -64);
        } completion:nil];

        if ([[NSString stringWithFormat:@"%@",self.specificationId] isEqualToString:@""] || self.specificationId == nil) {
            
            [_specified initSpecifiedBrandViewCellBrandId:[NSString stringWithFormat:@"%@",model.brandId]];
        }else{
            [_specified initSpecificationId:[NSString stringWithFormat:@"%@",self.specificationId] brandId:[NSString stringWithFormat:@"%@",model.brandId]];
        }

    }
    [tableView reloadData];

}
// 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    view.backgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 37, 70, 10)];
    label.text = [_brandInitialsArray objectAtIndex:section];;
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (_integer == 0) {
        _integer = 1;
        [UIView animateWithDuration:0.5 animations:^{
            _specified.frame = CGRectMake(SCREEN_WIDTH, 64, SCREEN_WIDTH - 70, SCREEN_HEIGHT -64);
        } completion:nil];
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
