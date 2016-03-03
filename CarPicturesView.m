//
//  CarPicturesView.m
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarPicturesView.h"
#import "CarPicturesViewCell.h"
//汽车图片
@implementation CarPicturesView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{
    _destinationTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) style:UITableViewStylePlain];
    _destinationTable.dataSource = self;
    _destinationTable.delegate = self;
    _destinationTable.bounces = NO;
    _destinationTable.rowHeight = 60;
//    _destinationTable.sectionIndexBackgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];//设置右边字体索引背景颜色
    _destinationTable.sectionIndexColor = [UIColor grayColor];//设置右边字体颜色

    //表格右边的索引，有不管ABCD有多少个，但是只取出ABCD就行，有可能很多个A ，但是只取一个，可以当做显示在表格右边的标题里
    [self addSubview: _destinationTable];
    _allArray = [[NSMutableArray alloc]init];
    _bigArray = [[NSMutableArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G", nil];
    _nameArray = [[NSMutableArray alloc]init];
    _arr = [[NSMutableArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G", nil];
////    [RequestClass postGeographicInformationRequestWitHCompletion:^(NSMutableArray *saleArray, NSString *errorMessage) {
////
////        NSString *str = @"";
////        for (GeographicInformation *geographicIn in saleArray) {
////
////            if (![geographicIn.nation isEqualToString:str]) {
////                //根据他们含有相同的标识，只取一个
////                [_arr addObject:geographicIn.nation];
////                [_nameArray addObject:geographicIn.name];
////            }
////            str = geographicIn.nation;
////            [_allArray addObject:geographicIn];
////
////
////        }
//        //        NSLog(@"%@",_allArray);
//        //         NSLog(@"%@",_arr);
//        [_bigArray removeAllObjects];
//        for (NSString *str  in _arr) {
//            //_arr表格右边所有的标题
//            //每一个区的数据，这是根据ABCD来分组的，也就是说A组有多少个数据全部存进A组里面
//            NSMutableArray *indexArray = [[NSMutableArray alloc] initWithCapacity:0];
////            for (GeographicInformation *geographic in _allArray)
////            {
////                if ([geographic.nation isEqualToString:str]) {
////                    //根据所含有相同标题的全部取出来放进同一个数组
////                    [indexArray addObject:geographic];
////                }
////
////            }
//            //每一个标题下都有一组数据，就是一个数组
//            [_bigArray addObject:indexArray];
//            //             NSLog(@"%@",_bigArray);
//        }
//        [_destinationTable reloadData];
////    }];

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
//    return [[_bigArray objectAtIndex:section] count];
    return 5;
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
    cell.backgroundColor = [UIColor whiteColor];
    cell.carImage.image = [UIImage imageNamed:@"Aventador"];


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
    self.carView(nil);
}
// 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    view.backgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
