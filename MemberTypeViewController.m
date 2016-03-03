//
//  MemberTypeViewController.m
//  CarSource
//
//  Created by apple on 16/1/10.
//  Copyright © 2016年 apple. All rights reserved.
//
//会员类型
#import "MemberTypeViewController.h"
#import "UserTypesModel.h"
#import "MemberTypeViewCell.h"

@interface MemberTypeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_typeTable;
    NSMutableArray *_typeArray;
     BOOL _isChoose[10000][10000];
    NSInteger _section;
    NSInteger _row;
    NSMutableArray *_memberArray;
    NSMutableArray *_userTypeName;
    BOOL _isAop;
}

@end

@implementation MemberTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _row = -1;
    _section = -1;
    self.view.backgroundColor = GRAY;
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"会员类型";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _memberArray = [[NSMutableArray alloc]init];
    _userTypeName = [[NSMutableArray alloc]init];
    _typeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _typeTable.delegate = self;
    // 设置数据源
    _typeTable.dataSource = self;
    _typeTable.bounces = NO;
    _typeTable.backgroundColor = [UIColor whiteColor];
    _typeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_typeTable];
    if (_isMember == YES) {
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
//        footerView.backgroundColor = GRAY;
        UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitButton setTitle:@"确定" forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
        submitButton.layer.cornerRadius = 5;
        submitButton.layer.masksToBounds = YES;
        //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
        submitButton.backgroundColor = COLOR;
        [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:submitButton];

        [submitButton makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@50);
            make.bottom.equalTo(footerView).offset(-20);
            make.right.equalTo(footerView).offset(-50);
            make.height.equalTo(@40);
        }];
        
        _typeTable.tableFooterView = footerView;

    }


     [LCCoolHUD showLoading:@"正在加载" inView:self.view];
    [ResourcesRequest postGetTheUserTypesRequestWithShowCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {

        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"]) {
            _typeArray = saleArray;

            [_typeTable reloadData];
        }
    }];


}
- (void)submitButtonClick:(UIButton *)button{

    NSString *userTypeId = @"";
    NSString *userTypeName = @"";
    for (int i = 0; i < _memberArray.count; i++) {

        if (i == 0) {
            userTypeId = [NSString stringWithFormat:@"%@",[_memberArray objectAtIndex:i]];
            userTypeName = [NSString stringWithFormat:@"%@",[_userTypeName objectAtIndex:i]];
        }else{
            userTypeId = [userTypeId stringByAppendingString:[NSString stringWithFormat:@",%@",[_memberArray objectAtIndex:i]]];
             userTypeName = [userTypeName stringByAppendingString:[NSString stringWithFormat:@"/%@",[_userTypeName objectAtIndex:i]]];
        }

    }
//    NSLog(@"userTypeName = %@    userTypeId%@",userTypeName,userTypeId);
     self.memberType(userTypeName,userTypeId);
    [self.navigationController popViewControllerAnimated:YES];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _typeArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    MemberTypeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell)
    {
        cell = [[MemberTypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UserTypesModel *userTypes = [_typeArray objectAtIndex:indexPath.row];
    cell.memberLabel.text = [NSString stringWithFormat:@"%@",userTypes.usetTypeName];

    if (_isMember == YES) {
            if (_isChoose[indexPath.section][indexPath.row]) {
                cell.backgroundColor = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:240/255.0 alpha:1];
                cell.memberLabel.textColor = [UIColor whiteColor];
            }else{
                cell.backgroundColor = [UIColor whiteColor];
                cell.memberLabel.textColor = [UIColor grayColor];
            }



    }else{
        if (_row == indexPath.row && _section == indexPath.section) {
            cell.backgroundColor = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:240/255.0 alpha:1];
            cell.memberLabel.textColor = [UIColor whiteColor];
        }else{
            cell.backgroundColor = [UIColor whiteColor];
            cell.memberLabel.textColor = [UIColor grayColor];
        }
    }

    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

     UserTypesModel *userTypes = [_typeArray objectAtIndex:indexPath.row];
    if (_isMember == YES) {

        if (indexPath.row == 0) {
            memset(_isChoose,0,sizeof(_isChoose));

            _isAop = YES;
            [_memberArray removeAllObjects];
            [_userTypeName removeAllObjects];
            _isChoose[indexPath.section][indexPath.row] = !_isChoose[indexPath.section][indexPath.row];
            if (_isChoose[indexPath.section][indexPath.row]) {
                [_userTypeName addObject:userTypes.usetTypeName];
                [_memberArray addObject:userTypes.userTypeId];
            }else{
                [_memberArray removeObject:userTypes.userTypeId];
                [_userTypeName removeObject:userTypes.usetTypeName];
            }


        }else{

            if (_isAop == YES) {
                _isAop = NO;
                [_memberArray removeAllObjects];
                [_userTypeName removeAllObjects];
                memset(_isChoose,0,sizeof(_isChoose));
            }
            _isChoose[indexPath.section][indexPath.row] = !_isChoose[indexPath.section][indexPath.row];
            if (_isChoose[indexPath.section][indexPath.row]) {
                [_userTypeName addObject:userTypes.usetTypeName];
                [_memberArray addObject:userTypes.userTypeId];
            }else{
                [_memberArray removeObject:userTypes.userTypeId];
                [_userTypeName removeObject:userTypes.usetTypeName];
            }

        }

    }else{
        _section = indexPath.section;
        _row = indexPath.row;
        self.memberType(userTypes.usetTypeName,userTypes.userTypeId);
        [self.navigationController popViewControllerAnimated:YES];

    }
    [tableView reloadData];
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
