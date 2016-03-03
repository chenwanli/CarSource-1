//
//  SpecifiedBrandView.m
//  CarSource
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SpecifiedBrandView.h"
#import "SpecifiedBrandViewCell.h"
#import "CarSerieModel.h"

@interface SpecifiedBrandView ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_specifiedTable;
    NSMutableArray *_specifiedArray;
}
@end
@implementation SpecifiedBrandView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    _specifiedTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-70, self.frame.size.height) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _specifiedTable.delegate = self;
    // 设置数据源
    _specifiedTable.dataSource = self;
    _specifiedTable.bounces = NO;
    _specifiedTable.rowHeight = 50;
    _specifiedTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_specifiedTable];


}
- (void)initSpecifiedBrandViewCellBrandId:(NSString *)brandId{

    [LCCoolHUD showLoading:@"正在加载" inView:self];
    [NetworkRequest postSpecifiedBrandForAllCarsRequestWithBrandId:brandId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
        [LCCoolHUD hideInView:self];
        if ([errorMessage isEqualToString:@"0"]) {
            _specifiedArray = saleArray;
            [_specifiedTable reloadData];
        }
    }];

}
- (void)initSpecificationId:(NSString *)specificationId brandId:(NSString *)brandId{
    [LCCoolHUD showLoading:@"正在加载" inView:self];
    [NetworkRequest postSpecificationsBrandRequestWithBrandId:brandId specificationId:specificationId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
        [LCCoolHUD hideInView:self];
        if ([errorMessage isEqualToString:@"0"]) {
            _specifiedArray = saleArray;
            [_specifiedTable reloadData];
        }
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _specifiedArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    SpecifiedBrandViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell)
    {
        cell = [[SpecifiedBrandViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    CarSerieModel *serie = [_specifiedArray objectAtIndex:indexPath.row];
    cell.carSerieName.text = [NSString stringWithFormat:@"%@",serie.carSerieName];
    cell.carSeriePrice.text = [NSString stringWithFormat:@"%@",serie.carSeriePrice];

    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CarSerieModel *serie = [_specifiedArray objectAtIndex:indexPath.row];
    self.specified(serie.carSerieId);
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
