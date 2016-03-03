//
//  SalesView.m
//  CarSource
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SalesView.h"
#import "SalesViewCell.h"
#import "SalesTitleView.h"
#import "SalesListModel.h"

@interface SalesView ()<UITableViewDataSource,UITableViewDelegate>{


    BOOL _isOpen[10000];
    UITableView *_salesTable;
    UIButton *_btn;
    CGFloat _cellHeight;
    CGFloat _rowHeight;
    NSInteger _cellRow;
    NSMutableArray *_salesArray;
    NSString *_str;
    NSInteger _state;
    NSInteger _stateCount;
    NSInteger _count;
    SalesTitleView  *_titleView;
    NSInteger _requestCount; // 1。表示默认列表数据 2 表示选择品牌 3选择会员类型 4 选择地区
    NSString *_provincesIdStr;
    NSString *_areaStr;
    NSString *_memberTypeId;
    NSString *_vehicleId;
    NSString *_specificationId;
    NSString *_text;
}

@end
@implementation SalesView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{
    _cellRow = -1;
    _rowHeight = 0;
    _count = 1;
    _state = 1;
    _stateCount = 1;
    _requestCount = 1;

    _provincesIdStr = @"";
    _areaStr = @"";
    _memberTypeId = @"";
    _vehicleId = @"";
    _specificationId = @"";
    _text = @"";

    self.backgroundColor = [UIColor whiteColor];

    _salesArray = [[NSMutableArray alloc]init];

    _salesTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) style:UITableViewStyleGrouped];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _salesTable.delegate = self;
    // 设置数据源
    _salesTable.dataSource = self;
//    _salesTable.bounces = NO;
    _salesTable.backgroundColor = [UIColor whiteColor];;
    _salesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self addSubview:_salesTable];

    __weak SalesView *salesView = self;
    _titleView = [[SalesTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    _salesTable.tableHeaderView = _titleView;

    _titleView.brandBtn = ^(NSInteger brandTag){
        salesView.brandTag(brandTag);
    };
    _titleView.search = ^(NSString *str){
        salesView.searchStr(str);
    };
    [self installationMJRefresh_2_GIF];

}

//搜索
- (void)searchName:(NSString *)name string:(NSString *)string{
    [_titleView initText:name];
    _text = string;
    [self installationMJRefresh_2_GIF];
}
- (void)installationMJRefresh{

    _provincesIdStr = @"";
    _areaStr = @"";
    _memberTypeId = @"";
    _vehicleId = @"";
    _specificationId = @"";
    [_titleView vehicleStr:@"选择品牌"];
    [_titleView memberTypeStr:@"会员类型"];
    [_titleView provincesStr:@"所在区域"];

    [self installationMJRefresh_2_GIF];
}


- (void)initReleaseSalesViewControllerCount:(NSInteger)count{
    _requestCount = 1;

     [self installationMJRefresh_2_GIF];
}

- (void)provincesStr:(NSString *)provincesStr provincesIdStr:(NSString *)provincesIdStr areaStr:(NSString *)areaStr{
    if ([provincesStr isEqualToString:@""]||provincesStr == nil) {
        [_titleView provincesStr:areaStr];
    }else{
        [_titleView provincesStr:provincesStr];
    }

    _provincesIdStr = provincesStr;
    _areaStr = areaStr;
//    NSLog(@" _areaStr = %@   _provincesIdStr = %@",_areaStr,_provincesIdStr );
    _requestCount = 4;
    [self installationMJRefresh_2_GIF];
}
//选择会员
- (void)initMemberType:(NSString *)memberType memberTypeId:(NSString *)memberTypeId{
    [_titleView memberTypeStr:memberType];
    _memberTypeId = memberTypeId;
    _requestCount = 3;
    [self installationMJRefresh_2_GIF];

}
//选择品牌
- (void)initVehicleId:(NSString *)vehicleId vehicleName:(NSString *)vehicleName specificationId:(NSString *)specificationId{
    [_titleView vehicleStr:vehicleName];
    _vehicleId = vehicleId;
    _specificationId = specificationId;
    _requestCount = 2;
//    NSLog(@"vehicleId =%@ specificationId = %@ ",vehicleId,specificationId);
    [self installationMJRefresh_2_GIF];

}
- (void)installationMJRefresh_2_GIF
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 1; i<21; i++) {
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.tiff",i]]];
    }

    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
    // 隐藏刷新状态的文字
    //    footer.refreshingTitleHidden = YES;
    // 设置刷新图片
    [footer setImages:arr forState:MJRefreshStateRefreshing];
    [footer setImages:arr forState:MJRefreshStateIdle];
    [footer setImages:arr forState:MJRefreshStatePulling];
    _salesTable.mj_footer = footer;

    [header setImages:arr forState:MJRefreshStateIdle];
    [header setImages:arr forState:MJRefreshStatePulling];
    [header setImages:arr forState:MJRefreshStateRefreshing];

    _salesTable.mj_header = header;
    // 马上进入刷新状态
    [_salesTable.mj_header beginRefreshing];

}
- (void)refresh
{
    _count = 1;
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [ResourcesRequest postListReleasedSalesVehiclesRequestWithCarUserId:login.userId city:_provincesIdStr area:_areaStr page:@"1" userITyped:_memberTypeId specificationId:_specificationId brandId:_vehicleId text:_text showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
        _stateCount = 2;
        if ([errorMessage isEqualToString:@"0"]) {
            [_salesArray removeAllObjects];
            _state = 2;
            if (saleArray.count != 0) {

                for (SalesListModel *salesList in saleArray) {
                    [_salesArray addObject:salesList];
                }
            }
        }
    }];
/*
    switch (_requestCount) {
        case 1:
        {
            [ResourcesRequest postGetMySalesListRequestWithCarUserId:login.userId page:@"1" showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
            _stateCount = 2;
            if ([errorMessage isEqualToString:@"0"]) {
                 [_salesArray removeAllObjects];
                _state = 2;
                if (saleArray.count != 0) {

                    for (SalesListModel *salesList in saleArray) {
                        [_salesArray addObject:salesList];
                    }
                }
            }
            
            }];
        }
            break;
        case 2:
        {
            [ResourcesRequest postAccordingToTheCarBrandToObtainAListReleasedSalesVehiclesWithUserId:login.userId specificationId:_specificationId brandId:_vehicleId page:@"1" showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
                _stateCount = 2;
                if ([errorMessage isEqualToString:@"0"]) {
                    [_salesArray removeAllObjects];
                    _state = 2;
                    if (saleArray.count != 0) {
                        for (SalesListModel *salesList in saleArray) {
                            [_salesArray addObject:salesList];

                        }
                    }
                }

            }];
        }
            break;
        case 3:
        {
            [ResourcesRequest postDependingOnTheTypeOfUserMembersToObtainAListReleasedSalesVehiclesReleasedSalesVehiclesWithUserId:login.userId userITyped:_memberTypeId page:@"1" showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
                _stateCount = 2;
                if ([errorMessage isEqualToString:@"0"]) {
                     [_salesArray removeAllObjects];
                    _state = 2;
                    if (saleArray.count != 0) {
                        for (SalesListModel *salesList in saleArray) {
                            [_salesArray addObject:salesList];

                        }
                    }
                }

            }];

        }
            break;
        case 4:
        {
            [ResourcesRequest postAccordingToTheUsersAreaToObtainAListReleasedSalesVehiclesWithUserId:login.userId city:_provincesIdStr area:_areaStr page:@"1" showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
                _stateCount = 2;
                if ([errorMessage isEqualToString:@"0"]) {
                    _state = 2;
                    [_salesArray removeAllObjects];
                    if (saleArray.count != 0) {

                        for (SalesListModel *salesList in saleArray) {
                            [_salesArray addObject:salesList];
                        }
                    }
                }


            }];
        }
            break;

        default:
            break;
    }
 */
    // 为了看效果 延长3秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        if (_state == 2) {
            _state = 1;
            [_salesTable reloadData];
        }
        if (_stateCount == 2) {
            _stateCount = 1;
            [_salesTable.mj_header endRefreshing];
        }

    });

}

- (void)loadMoreData:(MJRefreshAutoGifFooter *)footer{
    _count ++;
    //    NSLog(@"_count  = %ld",_count);
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [ResourcesRequest postListReleasedSalesVehiclesRequestWithCarUserId:login.userId city:_provincesIdStr area:_areaStr page:[NSString stringWithFormat:@"%ld",(long)_count] userITyped:_memberTypeId specificationId:_specificationId brandId:_vehicleId text:_text showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
        _stateCount = 2;
        if ([errorMessage isEqualToString:@"0"]) {
            if (saleArray.count != 0) {
                _state = 2;
                for (SalesListModel *salesList in saleArray) {
                    [_salesArray addObject:salesList];
                }
            }else{
                [footer endRefreshingWithNoMoreData];
            }
        }


    }];
/*
    switch (_requestCount) {
        case 1:
        {
            [ResourcesRequest postGetMySalesListRequestWithCarUserId:login.userId page:[NSString stringWithFormat:@"%ld",(long)_count] showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {

                _stateCount = 2;
                if ([errorMessage isEqualToString:@"0"]) {
                    if (saleArray.count != 0) {
                        _state = 2;
                        for (SalesListModel *salesList in saleArray) {
                            [_salesArray addObject:salesList];
                        }
                    }else{
                        [footer endRefreshingWithNoMoreData];
                    }
                }
                
            }];


        }
            break;
        case 2:
        {
            [ResourcesRequest postAccordingToTheCarBrandToObtainAListReleasedSalesVehiclesWithUserId:login.userId specificationId:_specificationId brandId:_vehicleId page:@"1" showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {

                _stateCount = 2;
                if ([errorMessage isEqualToString:@"0"]) {
                    if (saleArray.count != 0) {
                        _state = 2;
                        for (SalesListModel *salesList in saleArray) {
                            [_salesArray addObject:salesList];
                        }
                    }else{
                        [footer endRefreshingWithNoMoreData];
                    }
                }

            }];
        }
            break;
        case 3:
        {

            [ResourcesRequest postDependingOnTheTypeOfUserMembersToObtainAListReleasedSalesVehiclesReleasedSalesVehiclesWithUserId:login.userId userITyped:_memberTypeId page:[NSString stringWithFormat:@"%ld",(long)_count] showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
                _stateCount = 2;
                if ([errorMessage isEqualToString:@"0"]) {
                    if (saleArray.count != 0) {

                        for (SalesListModel *salesList in saleArray) {
                            [_salesArray addObject:salesList];
                        }
                        _state = 2;
                    }else{
                        [footer endRefreshingWithNoMoreData];
                    }
                }

            }];
        }
            break;
        case 4:
        {
            
            [ResourcesRequest postAccordingToTheUsersAreaToObtainAListReleasedSalesVehiclesWithUserId:login.userId city:_provincesIdStr area:_areaStr page:[NSString stringWithFormat:@"%ld",(long)_count]  showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
                _stateCount = 2;
                if ([errorMessage isEqualToString:@"0"]) {
                    if (saleArray.count != 0) {
                        _state = 2;
                        for (SalesListModel *salesList in saleArray) {
                            [_salesArray addObject:salesList];
                        }
                    }else{
                        [footer endRefreshingWithNoMoreData];
                    }
                }

            }];

        }
            break;
            
        default:
            break;
    }

*/
    // 为了看效果 延长3秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_state == 2) {
            _state = 1;
            [_salesTable reloadData];
        }
        if (_stateCount == 2) {
            _stateCount = 1;
            [_salesTable.mj_footer endRefreshing];
        }

    });
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _salesArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
//    SalesViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
     SalesViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell)
    {
        cell = [[SalesViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    }else{
        //cell中本来就有一个subview，如果是重用cell，则把cell中自己添加的subview清除掉，避免出现重叠问题
        //         [[cell.subviews objectAtIndex:1] removeFromSuperview];
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    SalesListModel *salesList = [_salesArray objectAtIndex:indexPath.row];
    if ([[NSString stringWithFormat:@"%@",salesList.addressCounties] isEqualToString:@""]) {
        cell.addressLabel.text = [NSString stringWithFormat:@" %@",salesList.addressCounties];
    }else{
        cell.addressLabel.text = [NSString stringWithFormat:@" (%@)",salesList.addressCounties];
    }
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",salesList.userName];

    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,salesList.userUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
    NSString *carStr;
    if ([[NSString stringWithFormat:@"%@",salesList.salesCarsType]isEqualToString:@"0"]) {
        carStr = @"现车";
    }else{
        carStr = @"期货";
    }

    if ([[NSString stringWithFormat:@"%@",salesList.salesSpcificationId]isEqualToString:@"1"]) {
         _str = [NSString stringWithFormat:@"%@",salesList.salesText];
    }else{
         _str = [NSString stringWithFormat:@"%@ %@ 价格：%@万 %@ %@ %@ %@ %@",salesList.carSeriesName,salesList.carSeriesTypeName,salesList.modelsPrice,carStr,salesList.salesModelsColour,salesList.salesShelfNumber,salesList.salesText,salesList.specificationText];
    }


    cell.configuration.text = _str;
        [cell initAuthenticateLabelText:salesList.authenticateTypeNameList];

    if (_isOpen[indexPath.row])
    {
        CGFloat height = [self heightForConfigurationWithString:_str];
        _cellHeight = height;
        CGFloat sales = [self salesHeightViewArray:_salesArray];
        [cell salesViewCellNameText:[NSString stringWithFormat:@"%@",salesList.userName] salesHeightView:sales configurationHeight:height isOpen:_isOpen[indexPath.row]salesArray:salesList.imageList];
        cell.displayBtn.hidden = NO;
        cell.displayBtn.tag = indexPath.row;
        [cell.displayBtn addTarget:self action:@selector(displayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        CGFloat height = [self heightConfigurationWithString:_str];
        if (height < 100) {
            cell.displayBtn.hidden = YES;
        }else{
            cell.displayBtn.hidden = NO;
            cell.displayBtn.tag = indexPath.row;
            [cell.displayBtn addTarget:self action:@selector(displayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
         _cellHeight = height;
        CGFloat sales = [self salesHeightViewArray:salesList.imageList];
        [cell salesViewCellNameText:[NSString stringWithFormat:@"%@",salesList.userName] salesHeightView:sales configurationHeight:height isOpen:_isOpen[indexPath.row] salesArray:salesList.imageList];
    }

    cell.imageUrl = ^(NSMutableArray *array,NSInteger imageCounnt){
        self.imageUrlArr(array,imageCounnt);
    };



    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    SalesListModel *salesList = [_salesArray objectAtIndex:indexPath.row];
//    NSLog(@"salesList.salesSpcificationId %@",salesList.salesSpcificationId);
    if (![[NSString stringWithFormat:@"%@",salesList.salesSpcificationId]isEqualToString:@"1"]) {
        NSMutableArray *array = [NSMutableArray array];

        [array addObject:salesList];

        self.details(array);
    }

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

     SalesListModel *salesList = [_salesArray objectAtIndex:indexPath.row];
    NSString *string = @"";
    NSString *carStr;
    if ([[NSString stringWithFormat:@"%@",salesList.salesCarsType]isEqualToString:@"0"]) {
        carStr = @"现车";
    }else{
        carStr = @"期货";
    }


    if ([[NSString stringWithFormat:@"%@",salesList.salesSpcificationId]isEqualToString:@"1"]) {
        string = [NSString stringWithFormat:@"%@",salesList.salesText];
    }else{
        string = [NSString stringWithFormat:@"%@ %@ 价格：%@万 %@ %@ %@ %@ %@",salesList.carSeriesName,salesList.carSeriesTypeName,salesList.modelsPrice,carStr,salesList.salesModelsColour,salesList.salesShelfNumber,salesList.salesText,salesList.specificationText];
    }

    if (_isOpen[indexPath.row]) {

        CGFloat height =  [self heightForConfigurationWithString:string] + [self salesHeightViewArray:salesList.imageList] + 80;

        return height;
    }else{
        CGFloat hgt = [self heightConfigurationWithString:string] + [self salesHeightViewArray:salesList.imageList] + 80 ;
        return hgt;
    }

}

- (void)displayButtonClick:(UIButton *)button{


    NSIndexPath *index=[NSIndexPath indexPathForRow:button.tag inSection:0];
    _isOpen[index.row] = !_isOpen[index.row];
    [_salesTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];

}

- (CGFloat)salesHeightViewArray:(NSMutableArray *)arr{

    if (![[NSString stringWithFormat:@"%@",arr] isEqualToString:@"<null>"]) {
        if (arr.count != 0) {
            if (arr.count < 4) {
                return (SCREEN_WIDTH - 60)/3;
            }else if (arr.count < 7){
                return (SCREEN_WIDTH - 60)/3 *2;
            }else{
                return (SCREEN_WIDTH - 60)/3 *3;
            }

        }else{
            
            return 0;
        }

    }else{
        return 0;
    }

}


- (CGFloat)heightForConfigurationWithString:(NSString *)string{

    CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH-60, string, 15);

    return size.height;

}

- (CGFloat)heightConfigurationWithString:(NSString *)string{

    CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH-60, string, 15);

    if (size.height < 100) {
         return size.height;
    }else{
        return 100;
    }

}

- (void)brandButtonClick:(UIButton *)button{
    _btn.selected = NO;
    button.selected = YES;
    _btn = button;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
