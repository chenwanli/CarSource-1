//
//  SalesDetailsViewController.m
//  CarSource
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SalesDetailsViewController.h"
#import "SalesDetailsViewCell.h"
#import "DetailsTableHeaderView.h"
#import "SalesListModel.h"
#import "DetailsTableFooterView.h"
#import "ImageViewController.h"

@interface SalesDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_salesTable;
    NSMutableArray *_detailsArray;
     CGFloat _cellHeight;

}

@end

@implementation SalesDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTitleView];

    _detailsArray = [[NSMutableArray alloc]initWithObjects:@"颜色",@"地址",@"类型",@"车架号",@"配置", nil];
    self.view.backgroundColor = [UIColor whiteColor];
    _salesTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 104) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _salesTable.delegate = self;
    // 设置数据源
    _salesTable.dataSource = self;
    _salesTable.bounces = NO;
    _salesTable.backgroundColor = [UIColor whiteColor];;
//    _salesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_salesTable];

    [self initTableHeaderView];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _detailsArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    SalesDetailsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell)
    {
        cell = [[SalesDetailsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SalesListModel *salesList = [self.salesArray objectAtIndex:0];
    cell.salesLabel.text = [_detailsArray objectAtIndex:indexPath.row];
    _cellHeight = 44;
    switch (indexPath.row) {
        case 0:
        {
            cell.details.text = [NSString stringWithFormat:@"%@",salesList.salesModelsColour];
        }
            break;
        case 1:
        {
            cell.details.text = [NSString stringWithFormat:@"%@",salesList.addressCounties];
        }
            break;
        case 2:
        {
            if ([[NSString stringWithFormat:@"%@",salesList.salesCarsType]isEqualToString:@"0"]) {
                cell.details.text = @"现车";
            }else{
                cell.details.text = @"期货";
            }


        }
            break;
        case 3:
        {
            cell.details.text = [NSString stringWithFormat:@"%@",salesList.salesShelfNumber];
        }
            break;
        case 4:
        {
            CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH-80, salesList.salesText, 16);
            if (size.height + 20 > 44) {
                 _cellHeight = size.height + 20;
            }else{
                 _cellHeight = 44;
            }

            [cell initSalesLabelHeight:size.height];
            cell.details.text = [NSString stringWithFormat:@"%@",salesList.salesText];
        }
            break;

        default:
            break;
    }



    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight;
}
- (void)initTableHeaderView{

    SalesListModel *salesList = [self.salesArray objectAtIndex:0];
    CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH-20, salesList.carSeriesTypeName, 18);
    
    DetailsTableHeaderView *headerView = [[DetailsTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, size.height + 40) array:self.salesArray height:size.height];
    _salesTable.tableHeaderView = headerView;


    DetailsTableFooterView *footerView = [[DetailsTableFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self salesHeightViewArray:salesList.imageList] + 90) array:self.salesArray];
    _salesTable.tableFooterView = footerView;
    
    footerView.footerImage =  ^(NSMutableArray *array,NSInteger footerCount){
        //        查看大图
        ImageViewController *imageView = [[ImageViewController alloc]init];
        imageView.imageArray = array;
        imageView.index = footerCount;
        [self.navigationController pushViewController:imageView animated:YES];

    };

    footerView.userBtn = ^(NSString *str){

    };

}
- (CGFloat)salesHeightViewArray:(NSMutableArray *)arr{

    if (![[NSString stringWithFormat:@"%@",arr] isEqualToString:@"<null>"]) {
        if (arr.count != 0) {
            if (arr.count < 4) {
                return (SCREEN_WIDTH - 20)/3;
            }else if (arr.count < 7){
                return (SCREEN_WIDTH - 20)/3 *2;
            }else{
                return (SCREEN_WIDTH - 20)/3 *3;
            }

        }else{

            return 0;
        }

    }else{
        return 0;
    }
    
}


- (void)initTitleView{

    UIImageView *bgImage = [[UIImageView alloc]init];
    bgImage.backgroundColor = COLOR;
    [self.view addSubview:bgImage];

    UIImageView *image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"return"];
    [self.view addSubview:image];

    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setTitle:@"车源详情" forState:UIControlStateNormal];
    //    [returnButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    returnButton.titleLabel.font = [UIFont systemFontOfSize:18];
    returnButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [returnButton addTarget:self action:@selector(returnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnButton];

    UIImageView *shareImage = [[UIImageView alloc]init];
    shareImage.image = [UIImage imageNamed:@"twenty-seven"];
    [self.view addSubview:shareImage];

    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [shareButton setImage:[UIImage imageNamed:@"twenty-seven"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];

    UIImageView *img = [[UIImageView alloc]init];
    img.backgroundColor = COLOR;
    [self.view addSubview:img];

    NSArray *array = [[NSArray alloc]initWithObjects:@"电话",@"消息", nil];

    for (int i = 0; i < array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH/2 *i, SCREEN_HEIGHT -40, SCREEN_WIDTH/2, 40);
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = 1 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }


    [bgImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(self.view).offset(@0);
        make.height.equalTo(@64);

    }];


    [image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@30);
        make.size.equalTo(CGSizeMake(15, 18));

    }];

    [returnButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@20);
        make.size.equalTo(CGSizeMake(90, 40));

    }];

    [shareImage makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(@30);
        make.size.equalTo(CGSizeMake(25, 25));

    }];

    [shareButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(@0);
        make.top.equalTo(@0);
        make.size.equalTo(CGSizeMake(80, 64));
        
    }];

    [img makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(self.view).offset(@0);
        make.height.equalTo(@40);

    }];
}
- (void)buttonClick:(UIButton *)button{

}

- (void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)shareButtonClick{

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
