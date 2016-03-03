//
//  TopupViewController.m
//  CarSource
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//
//充值
#define TEXT @"充值金币您可以用于寻车或者售车推广，也可以用于交易担保和委托找车。充值的金币随时可以申请提现返还您的帐户，提现到账时间一般在3个工作日内，节假日除外。"

#import "TopupViewController.h"
#import "TopupViewCell.h"
#import "MethodOfPaymentCell.h"
#import "BankCardView.h"

@interface TopupViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_topupTable;
    NSInteger _indexPath;
}
@property (nonatomic,strong)BankCardView *bankView;
@property (nonatomic,strong)UIView *bgView;;
@end

@implementation TopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"充值";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };
    _indexPath = -1;
    _topupTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _topupTable.delegate = self;
    // 设置数据源
    _topupTable.dataSource = self;
    _topupTable.bounces = NO;
    _topupTable.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];
    _topupTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _topupTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_topupTable];
    [self initPromptView];

//    // 单击的 Recognizer
//    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget: self action:@selector(SingleTap:)];
//    //点击的次数
//    singleRecognizer.numberOfTapsRequired = 1; // 单击
//    //给self.view添加一个手势监测；
//    [self.view addGestureRecognizer:singleRecognizer];

}
- (void)bankViewHeight:(NSInteger)height{
    [_bankView removeFromSuperview];
    [_bgView removeFromSuperview];

    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0.5;
    [self.view addSubview:_bgView];

    _bankView = [[BankCardView alloc]initWithFrame:CGRectMake(30, 150, SCREEN_WIDTH-60, height)];
    _bankView.layer.cornerRadius = 5;
    _bankView.layer.masksToBounds = YES;
    [self.view addSubview:_bankView];

    __weak TopupViewController *topup = self;
    _bankView.deleteBtn = ^(NSString *deleteBtn){
        [topup.bankView removeFromSuperview];
        [topup.bgView removeFromSuperview];

    };

    _bankView.indexRow = ^(NSInteger indexRow){
        [topup.bankView removeFromSuperview];
        [topup.bgView removeFromSuperview];


    };


}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
    [self.view endEditing:YES];
}

- (void)initPromptView {

    CGSize promptSize = STRING_SIZE_FONT(SCREEN_WIDTH-20, TEXT, 16);


    UIView *promptView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, promptSize.height +30)];
    promptView.backgroundColor = [UIColor whiteColor];

    UILabel *promptLabel = [[UILabel alloc]init];
    promptLabel.textColor = [UIColor grayColor];
    promptLabel.backgroundColor =[UIColor colorWithRed:245/255.0 green:250/255.0 blue:255/255.0 alpha:1];
    promptLabel.font = [UIFont systemFontOfSize:16];
    promptLabel.text = TEXT;
    promptLabel.numberOfLines = 0;
    [promptView addSubview:promptLabel];

    [promptLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.right.equalTo(promptView).offset(-10);
        make.height.equalTo(promptSize.height +10);
    }];

    _topupTable.tableHeaderView = promptView;

    UIView *foorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];

    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(30,30, SCREEN_WIDTH - 60, 50);
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [foorView addSubview:submitButton];

    _topupTable.tableFooterView = foorView;

}
// 提交
- (void)submitButtonClick:(UIButton *)button{

    
    
}


// 设置表中有多少个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }else{
        return 3;
    }


}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"TopupCell";
        TopupViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        if (!cell)
        {
            cell = [[TopupViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        
        
        return cell;

    }else{
        static NSString *cellIdentifier = @"MethodCell";
        MethodOfPaymentCell *methodCell = [tableView cellForRowAtIndexPath:indexPath];

        if (!methodCell)
        {
            methodCell = [[MethodOfPaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        methodCell.selectionStyle = UITableViewCellSelectionStyleNone;
        methodCell.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        methodCell.payImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"fork%ld",(long)indexPath.row +1]];
        methodCell.payButton.hidden = YES;
        methodCell.bankImage.hidden = YES;
        switch (indexPath.row ) {
            case 0:
            {

                methodCell.payButton.hidden = NO;
                methodCell.bankImage.hidden = NO;
                methodCell.payLabel.text = @"农业银行储蓄卡（8989）";
                methodCell.instructionsLabel.text = @"单日交易限额¥5000.00";

                [ methodCell.payButton addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];

            }
                break;
            case 1:
            {
                methodCell.payLabel.text = @"微信支付";
                methodCell.instructionsLabel.text = @"推荐微信用户使用";
            }
                break;
            case 2:
            {
                methodCell.payLabel.text = @"支付宝支付";
                methodCell.instructionsLabel.text = @"推荐支付宝用户使用";
            }
                break;

            default:
                break;
        }
        if (_indexPath == indexPath.row) {
            methodCell.chooseImage.image = [UIImage imageNamed:@"for"];
        }else{
            methodCell.chooseImage.image = [UIImage imageNamed:@"highlighted"];
        }
        [methodCell initMethodOfPaymentCellText:@"农业银行储蓄卡（8989）"];
        return methodCell;

    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    if (indexPath.section == 1) {
        _indexPath = indexPath.row;
        [_topupTable reloadData];
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 110;
    }else {
        return 70;
    }

}
// 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *titles = @[@"选择充值金额",@"选择支付方式"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 45)];
    bgImage.backgroundColor = [UIColor whiteColor];
    [view addSubview:bgImage];

    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 16, 16)];
    numberLabel.layer.cornerRadius = 8;
    numberLabel.layer.masksToBounds = YES;
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.font = [UIFont systemFontOfSize:13];
    numberLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
    numberLabel.text = [NSString stringWithFormat:@"%ld",section+1];
    [view addSubview:numberLabel];

    UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(36, 23, 160, 30)];
    typeLabel.textColor = [UIColor grayColor];
    typeLabel.font = [UIFont systemFontOfSize:16];
    typeLabel.text = [titles objectAtIndex:section];
    [view addSubview:typeLabel];

    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,59, SCREEN_WIDTH, 1)];

    lineImage.backgroundColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1];
    [view addSubview:lineImage];
    return view;
}
// 设置区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
- (void)payButtonClick{

    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"农业银行储蓄卡（8989）",@"农业银行储蓄卡（8989）",@"农业银行储蓄卡（8989）",@"农业银行储蓄卡（8989）",@"农业银行储蓄卡（8989）",@"农业银行储蓄卡（8989）",@"农业银行储蓄卡（8989）",@"农业银行储蓄卡（8989）",nil];

    if (array.count*44 + 100 < 5*44 + 100) {
        [self bankViewHeight:array.count*44 + 100];


    }else{
        [self bankViewHeight:5*44 + 100];


    }
    [_bankView initBankCardViewArray:array];




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
