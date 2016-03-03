//
//  SearchViewController.m
//  CarSource
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchModel.h"
#import "SearchViewCell.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITableView *_searchTable;
    UITextField *_textField;
    NSInteger _count;
    NSMutableArray *_searchArray;
}

@end

@implementation SearchViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];// 1
    [_textField becomeFirstResponder];// 2
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    _searchArray = [[NSMutableArray alloc]init];
    _count = 1;
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"搜索";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _searchTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 124, SCREEN_WIDTH, SCREEN_HEIGHT - 124) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _searchTable.delegate = self;
    // 设置数据源
    _searchTable.dataSource = self;
//    _searchTable.bounces = NO;
    _searchTable.backgroundColor = [UIColor whiteColor];;
        _searchTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _searchTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_searchTable];
    [self initUITextField];
    [self installationMJRefresh];

}
- (void)installationMJRefresh{

    _count ++;
    _searchTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];

    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    _searchTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];

}
- (void)loadMoreData:(MJRefreshAutoNormalFooter *)footer{
    _count++ ;
    if ([_textField.text isEqualToString:@""]||_textField.text == nil) {
        [_searchTable.mj_footer endRefreshing];
    }else{
        [ResourcesRequest postSearchRequestWithText:_textField.text page:[NSString stringWithFormat:@"%ld",(long)_count] showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
            if ([errorMessage isEqualToString:@"0"]) {
                if (saleArray.count != 0) {

                    for (SearchModel *search in saleArray) {
                        [_searchArray addObject:search];
                    }
                    [_searchTable reloadData];
                    [_searchTable.mj_footer endRefreshing];
                }else{
                    [footer endRefreshingWithNoMoreData];
                }

            }else{
                 [_searchTable.mj_footer endRefreshing];
            }
        }];

    }


}
- (void)initUITextField{

    UIView *view = [[UIView alloc]init];
    view.backgroundColor = GRAY;
    [self.view addSubview:view];

    _textField = [[UITextField alloc]init];
    _textField.font = [UIFont systemFontOfSize:15];
    UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"did"]];
    _textField.leftView = imgv;
    _textField.delegate = self;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.textColor = BLACK;
    _textField.placeholder = @"输入你要查找的车型、车号、价格";
    _textField.backgroundColor = [UIColor whiteColor];
    [_textField setReturnKeyType : UIReturnKeySearch ];
    [_textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    //    textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"输入你要找的车型、车号、价格" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} ];
    _textField.clearButtonMode = UITextFieldViewModeAlways;

    [self.view addSubview:_textField];

//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"搜索" forState:UIControlStateNormal];
//    [button setTitleColor:COLOR forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];

    [view makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@64);
        make.right.equalTo(self.view).offset(@0);
        make.height.equalTo(@60);
    }];


    [_textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@74);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(@40);
    }];

//    [button makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view).offset(-10);
//        make.top.equalTo(@74);
//        make.size.equalTo(CGSizeMake(40, 40));
//
//    }];

}

- (void)textFieldEditChanged:(UITextField *)textField
{

//    if (![textField.text isEqualToString:@""] || textField.text == nil) {
        _count = 1;

        [ResourcesRequest postSearchRequestWithText:textField.text page:@"1" showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
            if ([errorMessage isEqualToString:@"0"]) {
                [_searchArray removeAllObjects];
                for (SearchModel *search in saleArray) {
                    [_searchArray addObject:search];

                }
                [_searchTable reloadData];
            }
        }];
//    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField.text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
       return YES;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.searchView(textField.text,textField.text);
    [self.navigationController popViewControllerAnimated:YES];

    return YES;
}

- (void)buttonClick{

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _searchArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = BLACK;
    SearchModel *search = [_searchArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",search.text];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     SearchModel *search = [_searchArray objectAtIndex:indexPath.row];
    self.searchView([NSString stringWithFormat:@"%@",search.text],[NSString stringWithFormat:@"%@",search.carSeriesTypeName]);
    [self.navigationController popViewControllerAnimated:YES];
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
