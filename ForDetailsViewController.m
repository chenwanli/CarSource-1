//
//  ForDetailsViewController.m
//  CarSource
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ForDetailsViewController.h"
#import "ForDetailsViewCell.h"
#import "ImageViewController.h"
#import "ForDetailsModel.h"
#import "ForDetailsView.h"

@interface ForDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_detailsTable;
    NSMutableArray *_detailsArray;
    NSInteger _cellheight;
    UILabel *_addressLabel;
    UIButton *_phoneBtn;
    NSString *_telStr;
}

@end

@implementation ForDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"交车详情";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };
    _detailsArray = [[NSMutableArray alloc]init];
    _detailsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _detailsTable.delegate = self;
    // 设置数据源
    _detailsTable.dataSource = self;
    //    _belowTable.bounces = NO;
    _detailsTable.backgroundColor = [UIColor whiteColor];
    _detailsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_detailsTable];

     [self forDetailsViewController];

    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
     [LCCoolHUD showLoading:@"正在加载，请稍等" inView:self.view];
     [NetworkRequest postForDetailsInformationRequestWithUserId:login.userId transactionVehiclesId:self.transactionVehiclesId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {

         [LCCoolHUD hideInView:self.view];
         if ([errorMessage isEqualToString:@"0"] ) {

             ForDetailsModel *details = [saleArray objectAtIndex:0];
             if (![[NSString stringWithFormat:@"%@",details.transactionVehiclesUrlList] isEqualToString:@"<null>"]) {
                 for (NSString *detailsStr in details.transactionVehiclesUrlList) {

                     [_detailsArray addObject:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,detailsStr]];
                 }

             }
             CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH - 20, details.transactionVehiclesIntroduction, 14);
             ForDetailsView *showDetails = [[ForDetailsView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 180 + size.height )array:saleArray height:size.height];
             
             _detailsTable.tableHeaderView = showDetails;
             [_phoneBtn setTitle:[NSString stringWithFormat:@"%@",details.userAddressTel] forState:UIControlStateNormal];
             _telStr = [NSString stringWithFormat:@"%@",details.userAddressTel];
             _addressLabel.text = [NSString stringWithFormat:@"地址: %@",details.userAddress];
             
             [_detailsTable reloadData];
         }

     }];

    [self forDetailsViewController];

}
- (void)forDetailsViewController{

    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    bgView.layer.borderWidth = 1.0;

    UIImageView *phoneIamge = [[UIImageView alloc]initWithFrame:CGRectMake(20, 8, 18, 20)];
    phoneIamge.image = [UIImage imageNamed:@"tel"];
    [bgView addSubview:phoneIamge];

    _phoneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _phoneBtn.frame = CGRectMake(45, 5, SCREEN_WIDTH - 55, 25);
    _phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    _phoneBtn.titleLabel.font = [UIFont systemFontOfSize: 18.0];
    [_phoneBtn addTarget:self action:@selector(phoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_phoneBtn];


    _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH -20, 50)];
    _addressLabel.textColor = [UIColor grayColor];
    _addressLabel.font = [UIFont systemFontOfSize:15];
    _addressLabel.numberOfLines = 0;
    [bgView addSubview:_addressLabel];

    _detailsTable.tableFooterView = bgView;
}

- (void)phoneButtonClick{
    if (_telStr != nil || [_telStr isEqualToString:@""]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_telStr]]];

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _detailsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    ForDetailsViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ForDetailsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = GRAY;

    [cell.showImage sd_setImageWithURL:[NSURL URLWithString:[_detailsArray objectAtIndex:indexPath.row]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image)
        {
//            CGFloat width = image.size.width*SCREEN_HEIGHT/image.size.height;
            CGFloat height = image.size.height*(SCREEN_WIDTH -20)/image.size.width;
            if (image.size.width > image.size.height)
            {
                //                NSLog(@" height = %f",height);
                cell.showImage.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, height);
                _cellheight = height +20;
            }
            else
            {
                //                 NSLog(@" height = %f",height);
                cell.showImage.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, height);

                _cellheight = height +20;
            }
        }
    }];


    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ImageViewController *image = [[ImageViewController alloc]init];
    image.imageArray = _detailsArray;
    image.index = indexPath.row;
    [self.navigationController pushViewController:image animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cellheight;
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
