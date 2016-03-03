//
//  CommissionedView.m
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CommissionedView.h"
#import "CommissionedViewCell.h"
#import "ImageFigureView.h"
#import "EntrustViewCell.h"
#import "TrailerCell.h"
#import "ResourcesViewCell.h"
#import "InformationsList.h"
#import "ModelsList.h"
#import "PromotionList.h"
#import "UserTrailerList.h"

//委托找车

@interface CommissionedView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_informations;
    NSMutableArray *_modelsArray;
    NSMutableArray *_promotionArray;
    NSMutableArray *_trailerArray ;
    ImageFigureView *_figure;

}

@end
@implementation CommissionedView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{
    _informations = [NSMutableArray array];
    _modelsArray = [NSMutableArray array];
    _promotionArray = [NSMutableArray array];
    _trailerArray = [NSMutableArray array];
    _commissionedTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _commissionedTable.delegate = self;
    // 设置数据源
    _commissionedTable.dataSource = self;
//    _commissionedTable.scrollEnabled = NO;
    _commissionedTable.backgroundColor = [UIColor whiteColor];
    _commissionedTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self addSubview:_commissionedTable];

    [self initTableHeaderView];

    [self installationMJRefresh_2_GIF];
}
- (void)initTableHeaderView{

    UIView *viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190 +(SCREEN_WIDTH +100)/5-20)];
    viewHeader.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    _figure = [[ImageFigureView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 150)];
    [_figure initShufflingFigureURL:array furnitureId:0];
    [viewHeader addSubview:_figure];


    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 170, SCREEN_WIDTH, 20 +(SCREEN_WIDTH +100)/5-20)];
//    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH +100, 20 +(SCREEN_WIDTH +100)/5-20);
    scrollView.backgroundColor = [UIColor whiteColor];
    [viewHeader addSubview:scrollView];

    NSArray *arr = [[NSArray alloc]initWithObjects:@"销售资源",@"求购资源",@"交易担保",@"发布销售",@"发布求购", nil];

    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

        button.frame = CGRectMake((SCREEN_WIDTH +100)/5 *i+10, 10, (SCREEN_WIDTH +100)/5-30, (SCREEN_WIDTH +100)/5-20);
        [button setImage:[UIImage imageNamed: [NSString stringWithFormat:@"Bureau%d",i+1]] forState:UIControlStateNormal];
        [scrollView addSubview:button];

//        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH +100)/5 *i+20, (SCREEN_WIDTH +100)/5-24, (SCREEN_WIDTH +100)/5, 30)];
//        textLabel.text = [arr objectAtIndex:i];
//        textLabel.textAlignment = NSTextAlignmentLeft;
//        textLabel.textColor = [UIColor grayColor];
//        textLabel.font = [UIFont systemFontOfSize:15];
//        [scrollView addSubview:textLabel];
    }

    _commissionedTable.tableHeaderView = viewHeader;


}
- (void)installationMJRefresh_1
{
    _commissionedTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 刷新请求代码

        [_commissionedTable.mj_header endRefreshing]; // 完成请求之后结束刷新
    }];


    // 这个方法是滑动到最后一个cell到时候自动刷新
    _commissionedTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

        [_commissionedTable.mj_footer endRefreshing];
    }];
   }


- (void)installationMJRefresh_2_GIF
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 1; i<21; i++) {
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.tiff",i]]];
    }

    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];

    [header setImages:arr forState:MJRefreshStateIdle];
    [header setImages:arr forState:MJRefreshStatePulling];
    [header setImages:arr forState:MJRefreshStateRefreshing];

    _commissionedTable.mj_header = header;
    // 马上进入刷新状态
     [_commissionedTable.mj_header beginRefreshing];

}

- (void)refresh
{
    // 为了看效果 延长3秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
        //        [LCCoolHUD showLoading:@"正在加载，请稍后" inView:self];

        [NetworkRequest postForInformationOnTheHomepageRequestWithUserId:login.userId request:^(NSMutableArray *saleArray, NSMutableArray *areaArray, NSMutableArray *salesArray, NSMutableArray *userBankArray, NSString *errorMessage) {
            if ([errorMessage isEqualToString:@"0"]) {
                NSMutableArray *promotionUrl = [NSMutableArray array];
                NSMutableArray *promotionId = [NSMutableArray array];
//                for (NSDictionary *informationsDict in saleArray) {
//                    InformationsList *list = [InformationsList informationsListWithDictionary:informationsDict];
//                    [_informations addObject:list];
//                }
                [_modelsArray removeAllObjects];
                for (NSDictionary *modelsDict in areaArray) {
                    ModelsList *models = [ModelsList modelsListWithDictionary:modelsDict];
                    [_modelsArray addObject:models];
                }

                for (NSDictionary *promotionDict in salesArray) {
                    PromotionList *promotion = [PromotionList promotionListWithDictionary:promotionDict];
                    [promotionUrl addObject:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,promotion.promotionUrl]];
                    [promotionId addObject:promotion.promotionId];
                }

//                NSLog(@"promotionUrl = %@",promotionUrl);
                [_figure initShufflingFigureURL:promotionUrl furnitureId:promotionId];

                __weak CommissionedView *commissioned = self;
                _figure.furnitureId = ^(NSInteger furnitureId){

                    commissioned.promotion(furnitureId,promotionId);
                };
                [_trailerArray removeAllObjects];
                for (NSDictionary *trailerDict in userBankArray) {
                    UserTrailerList *trailer = [UserTrailerList userTrailerListWithDictionary:trailerDict];
                    [_trailerArray addObject:trailer];
                }
            }
        }];

        [_commissionedTable.mj_header endRefreshing];
    });
}
// 设置表中有多少个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 6;
    }else{
        return 1;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"Cell";
        ResourcesViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        if (!cell)
        {
            cell = [[ResourcesViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier text:@"5系4356 德系黑马 手续全 销往内蒙5系4356 内蒙"];

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
         cell.nameLabel.text = @"深圳车老大";
        return cell;


    }else if(indexPath.section == 1){
        static NSString *cellIdentifier = @"Cell";
        CommissionedViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        if (!cell)
        {
            cell = [[CommissionedViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        if (_modelsArray.count != 0) {
            for (int i = 0; i < 2; i++) {

                ModelsList *list = [_modelsArray objectAtIndex:i];
                if (i == 0) {
                    cell.nameLabel.text = [NSString stringWithFormat:@"%@",list.modelsName];
                    [cell.carImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,list.modelsUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];

                }else{
                    cell.typeLabel.text = [NSString stringWithFormat:@"%@",list.modelsName];
                    [cell.typeImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,list.modelsUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
                    
                }
            }

        }
                return cell;
    }else{
        static NSString *cellIdentifier = @"Cell";
        TrailerCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        if (!cell)
        {
            cell = [[TrailerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];

        if (_trailerArray.count != 0) {
             [cell initTrailerCellArray:_trailerArray];
        }


        return cell;

    }


    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {


    }
    if (indexPath.section == 1) {
        self.pkResults(nil);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 110;
    }else if(indexPath.section == 1){
        return 210;
    }else{
        return 220;
    }

}
// 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *titles = @[@"求购资源",@"车型对比",@"拖车服务"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 44)];
    bgImage.backgroundColor = [UIColor whiteColor];
    [view addSubview:bgImage];

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 44)];
    titleLabel.text = [titles objectAtIndex:section];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:titleLabel];

    view.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];

    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 1)];
    lineImage.backgroundColor = [UIColor colorWithRed:226/255.0 green:241/255.0 blue:256/255.0 alpha:1];
    [view addSubview:lineImage];


    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 53, SCREEN_WIDTH, 1)];
    image.backgroundColor = [UIColor colorWithRed:226/255.0 green:241/255.0 blue:256/255.0 alpha:1];
    [view addSubview:image];
    return view;
}
// 设置区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
