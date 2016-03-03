//
//  ServiceViewController.m
//  CarSource
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 apple. All rights reserved.
//
//我的服务
#import "ServiceViewController.h"
#import "PhoneNumberCell.h"
#import "CompanyAccountCell.h"
#import "ServiceView.h"
#import "CertificationViewController.h"
#import "SelectAreaViewController.h"
#import "UserBankAccount.h"

@interface ServiceViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITableView *_serviceTable;
    NSMutableArray *_salesArray;
    UITextField *_phoneField;
    NSMutableArray *_bankArray;
}

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"我的服务";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _serviceTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _serviceTable.delegate = self;
    // 设置数据源
    _serviceTable.dataSource = self;
    //    _commissionedTable.scrollEnabled = NO;
    _serviceTable.backgroundColor = [UIColor whiteColor];
    _serviceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_serviceTable];

    [self initServiceTableHeaderView];

    _salesArray = [[NSMutableArray alloc]init];
    _bankArray = [[NSMutableArray alloc]init];
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [LCCoolHUD showLoading:@"正在加载，请稍后" inView:self.view];
    [RequestClass postMyServiceRequestWithUserId:login.userId request:^(NSMutableArray *saleArray, NSMutableArray *areaArray, NSMutableArray *salesArray, NSMutableArray *userBankArray, NSString *errorMessage) {

        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"]) {

            if (![[NSString stringWithFormat:@"%@",salesArray] isEqualToString:@"<null>"]) {
                for (NSString *str in salesArray) {
                    [_salesArray addObject:str];
                }

            }
            if (![[NSString stringWithFormat:@"%@",userBankArray] isEqualToString:@"<null>"]) {
                for (UserBankAccount *bank in userBankArray) {
                    [_bankArray addObject:bank];
                }
            }
            [_serviceTable reloadData];
        }
    }];
}

- (void)initServiceTableHeaderView{

//    NSArray *arr = @[@"服务区域",@"销售专员"];
//
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
//
//    for (int i = 0; i<arr.count; i++) {
//        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 *i +17, 16, 16)];
//        numberLabel.layer.cornerRadius = 8;
//        numberLabel.layer.masksToBounds = YES;
//        numberLabel.textAlignment = NSTextAlignmentCenter;
//        numberLabel.textColor = [UIColor whiteColor];
//        numberLabel.font = [UIFont systemFontOfSize:13];
//        numberLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
//        numberLabel.text = [NSString stringWithFormat:@"%d",i+1];
//        [headerView addSubview:numberLabel];
//
//        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 *i +10, 70, 30)];
//        typeLabel.textColor = BLACK;
//        typeLabel.font = [UIFont systemFontOfSize:16];
//        typeLabel.text = [arr objectAtIndex:i];
//        [headerView addSubview:typeLabel];
//
//        UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 49*i +50, SCREEN_WIDTH -20, 1)];
//        lineImage.backgroundColor = GRAY;
//        [headerView addSubview:lineImage];
//        
//    }

//    UIButton *areaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [areaBtn setTitle:@"区域" forState:UIControlStateNormal];
//    areaBtn.frame = CGRectMake(120,10, 120, 30);
//    areaBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [areaBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    areaBtn.backgroundColor = GRAY;
//    [areaBtn addTarget:self action:@selector(areaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [headerView addSubview:areaBtn];
//
//    _serviceTable.tableHeaderView = headerView;

    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    UIImageView *footerImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH -20, 1)];
    footerImage.backgroundColor = GRAY;
    [footerView addSubview:footerImage];

//    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 17, 16, 16)];
//    numberLabel.layer.cornerRadius = 8;
//    numberLabel.layer.masksToBounds = YES;
//    numberLabel.textAlignment = NSTextAlignmentCenter;
//    numberLabel.textColor = [UIColor whiteColor];
//    numberLabel.font = [UIFont systemFontOfSize:13];
//    numberLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
//    numberLabel.text = @"4";
//    [footerView addSubview:numberLabel];

    UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 30)];
    typeLabel.textColor = BLACK;
    typeLabel.font = [UIFont systemFontOfSize:16];
    typeLabel.text = @"申请认证";
    [footerView addSubview:typeLabel];

    UIButton *certification = [UIButton buttonWithType:UIButtonTypeCustom];
    [certification setTitle:@"已认证" forState:UIControlStateNormal];
    certification.frame = CGRectMake(120,10, 120, 30);
    certification.titleLabel.font = [UIFont systemFontOfSize:16];
    [certification setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    certification.backgroundColor = GRAY;
    [certification addTarget:self action:@selector(certificationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:certification];


    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 49, SCREEN_WIDTH -20, 1)];
    lineImage.backgroundColor = GRAY;
    [footerView addSubview:lineImage];

    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"确定" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(50,70, SCREEN_WIDTH - 100, 50);
    submitButton.titleLabel.font = [UIFont systemFontOfSize:20];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:submitButton];

    _serviceTable.tableFooterView = footerView;



}
- (void)certificationButtonClick:(UIButton *)button{
    CertificationViewController *certification = [[CertificationViewController alloc]init];
    [self.navigationController pushViewController:certification animated:YES];
}

- (void)areaButtonClick:(UIButton *)button{
    SelectAreaViewController *selectArea = [[SelectAreaViewController alloc]init];
    [self.navigationController pushViewController:selectArea animated: YES];

}

- (void)submitButtonClick:(UIButton *)button{

}


// 设置表中有多少个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return _salesArray.count;
    }else{
        return _bankArray.count;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"Cell";
        PhoneNumberCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        if (!cell)
        {
            cell = [[PhoneNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.phoneLabel.text = [_salesArray objectAtIndex:indexPath.row];
        return cell;


    }else {
        static NSString *cellIdentifier = @"Cell";
        CompanyAccountCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        if (!cell)
        {
            cell = [[CompanyAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = GRAY;
        UserBankAccount *bank = [_bankArray objectAtIndex:indexPath.row];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",bank.bankAccountName];
        cell.bankLabel.text = [NSString stringWithFormat:@"%@",bank.bankAccountText];
        cell.accountLabel.text = [NSString stringWithFormat:@"%@",bank.bankAccountNumber];
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }else{
        return 162;
    }

}
// 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    if (section == 0) {

        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        view.backgroundColor = [UIColor whiteColor];

        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 30)];
        typeLabel.textColor = BLACK;
        typeLabel.font = [UIFont systemFontOfSize:16];
        typeLabel.text = @"销售专员";
        [view addSubview:typeLabel];

        _phoneField = [[UITextField alloc]initWithFrame:CGRectMake(90, 10, 170, 30)];
        _phoneField.font = [UIFont systemFontOfSize:14];
        _phoneField.placeholder = @"输入对方的手机账号";
        _phoneField.delegate = self;
        _phoneField.textAlignment = NSTextAlignmentCenter;;
        _phoneField.textColor = [UIColor grayColor];
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneField.borderStyle = UITextBorderStyleRoundedRect;
        _phoneField.backgroundColor = [UIColor colorWithRed:227/255.0 green:241/255.0 blue:255/255.0 alpha:1];
        [_phoneField setReturnKeyType : UIReturnKeyDone ];
        _phoneField.clearButtonMode = UITextFieldViewModeAlways;
        [view addSubview:_phoneField];

        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        addBtn.frame = CGRectMake( 270,10, 60, 30);
        addBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [addBtn setTitleColor:COLOR forState:UIControlStateNormal];
//        addBtn.backgroundColor = [UIColor lightGrayColor];
        [addBtn addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:addBtn];

        UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 49, SCREEN_WIDTH -20, 1)];
        bgImage.backgroundColor = GRAY;
        [view addSubview:bgImage];
        return view;
    }else{
        ServiceView *service = [[ServiceView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        service.service = ^ (NSString *name,NSString *bank,NSString *number){
            UserBankAccount *userBank = [[UserBankAccount alloc]init];
            userBank.bankAccountName = name;
            userBank.bankAccountText = bank;
            userBank.bankAccountNumber = number;
            [_bankArray addObject:userBank];
            [_serviceTable reloadData];

        };
        return service;
    }
    return nil;
}
// 设置区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 50;
    }else{
        return 200;
    }

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}
//绑定销售用户

- (void)addButtonClick:(UIButton *)button{

    [self.view endEditing:YES];

    if (_phoneField.text == nil || [_phoneField.text isEqualToString:@""]) {
        SHOW_ALERT(@"请输入您的手机号");
        return;
    }

    if (_phoneField.text.length != 11) {
        SHOW_ALERT(@"请输入正确的手机号码");
        return;
    }
     LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
     [LCCoolHUD showLoading:@"正在添加" inView:self.view];
    [RequestClass postBindingSalesUsersdRequestWithUserId:login.userId salasTel:_phoneField.text Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {

        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"]) {
             [LCCoolHUD showSuccess:@"添加成功" zoom:YES shadow:YES];
            [_salesArray addObject:_phoneField.text];
            [_serviceTable reloadData];
        }

    }];
}
//删除销售用户
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [LCCoolHUD showLoading:@"正在删除，请稍后" inView:self.view];

    if(editingStyle == UITableViewCellEditingStyleDelete){

        if (indexPath.section == 0) {
                [RequestClass postRemoveTheBindingSalesUsersRequestWithUserId:login.userId salasTel:[_salesArray objectAtIndex:indexPath.row] Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
                    [LCCoolHUD hideInView:self.view];
                    if ([errorMessage isEqualToString:@"0"]) {
                        [LCCoolHUD showSuccess:@"删除成功" zoom:YES shadow:YES];
                        [_salesArray removeObjectAtIndex:indexPath.row];
                        [_serviceTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }];
        }else{

            UserBankAccount *bank = [_bankArray objectAtIndex:indexPath.row];
            [RequestClass postDeleteUserBusinessCardInformationRequestWithUserId:login.userId  bankAccountId:bank.bankAccountId Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {

                [LCCoolHUD hideInView:self.view];
                if ([errorMessage isEqualToString:@"0"]) {
                    [LCCoolHUD showSuccess:@"删除成功" zoom:YES shadow:YES];
                    [_bankArray removeObjectAtIndex:indexPath.row];
                    [_serviceTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }

            }];
        }

    }
}
//修改删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [LCCoolHUD hideInView:self.view];
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
