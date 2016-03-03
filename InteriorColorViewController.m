//
//  InteriorColorViewController.m
//  CarSource
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "InteriorColorViewController.h"
#import "InteriorColorViewCell.h"
#import "ExteriorColorModel.h"
#import "InteriorColorModel.h"

@interface InteriorColorViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITableView *_interiorTable;
    NSMutableArray *_interiorArray;
    UITextField *_textField;
    NavView *_nav;
    NSInteger _interior;
    NSString *_appearanceStr;
     NSString *_appearanceId;
}

@end

@implementation InteriorColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    _nav.titleLabel.text = @"外观颜色";
    [self.view addSubview:_nav];
    _interior = 0;

   __weak InteriorColorViewController *interiorColor = self;

    _nav.returnButton = ^(NSString *returnButton){
        [interiorColor.navigationController popViewControllerAnimated:YES];
    };


    _interiorArray = [[NSMutableArray alloc]init];

    _interiorTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _interiorTable.delegate = self;
    // 设置数据源
    _interiorTable.dataSource = self;
    _interiorTable.bounces = NO;
    _interiorTable.rowHeight = 50;
    _interiorTable.backgroundColor = GRAY;
    _interiorTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_interiorTable];

    [self initInteriorColorViewtableFooterView];

    [LCCoolHUD showLoading:@"正在加载" inView:self.view];
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [NetworkRequest postGetAllTheModelsTheAppearanceOfTheColorSetRequestWithCarUserId:login.userId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"]) {

            _interiorArray = saleArray;
            [_interiorTable reloadData];

        }
        
    }];

}
- (void)initInteriorColorViewtableFooterView{

    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];

    UIView *bgView = [[UIView alloc]init];
    bgView.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    bgView.layer.borderWidth = 1.0;
    bgView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:bgView];

    UILabel *customLabel = [[UILabel alloc]init];
    customLabel.textColor = [UIColor grayColor];
    customLabel.font = [UIFont systemFontOfSize:16];
    customLabel.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    customLabel.text = @"   自定义颜色";
    customLabel.layer.borderWidth = 1.0;
    [bgView addSubview:customLabel];

    _textField = [[UITextField alloc]init];
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.delegate = self;
    _textField.textColor = [UIColor grayColor];
    _textField.placeholder = @"填入你需要的颜色";
    _textField.keyboardType = UIKeyboardTypeDefault;
    [_textField setReturnKeyType : UIReturnKeyDone ];
    //    _textField.clearButtonMode = UITextFieldViewModeAlways;
    [bgView addSubview:_textField];

    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"确定" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:submitButton];

    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@10);
        make.right.equalTo(footerView).offset(@0);
        make.height.equalTo(@88);
    }];

    [customLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(bgView).offset(@0);
        make.height.equalTo(@44);
    }];

    [_textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@50);
        make.right.equalTo(bgView).offset(-10);
        make.height.equalTo(@40);
    }];


    [submitButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.bottom.equalTo(footerView).offset(-20);
        make.right.equalTo(footerView).offset(-50);
        make.height.equalTo(@40);
    }];

    _interiorTable.tableFooterView = footerView;

}
- (void)submitButtonClick:(UIButton *)button{


    if ([_textField.text isEqualToString:@""] || _textField.text == nil) {
        SHOW_ALERT(@"请选择你需要的颜色")
    }else{

        if (_interior == 0) {
            [LCCoolHUD showLoading:@"正在加载" inView:self.view];
            LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

            [NetworkRequest postGetAllTheModelsOfInteriorColorSetRequestWithCarUserId:login.userId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {

                [LCCoolHUD hideInView:self.view];
                if ([errorMessage isEqualToString:@"0"]) {
                    _interior = 1;
                    _appearanceStr = _textField.text;

                    _textField.text = @"";
                    _nav.titleLabel.text = @"内饰颜色";
                    _interiorArray = saleArray;
                    [_interiorTable reloadData];
                    
                }
            }];


        }else{
             self.interiorColor(_appearanceStr,_textField.text,nil,nil);
            [self.navigationController popViewControllerAnimated:YES];
        }



    }


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _interiorArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    InteriorColorViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[InteriorColorViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];

    if (_interior == 0) {
        ExteriorColorModel *exterior = [_interiorArray objectAtIndex:indexPath.row];
        cell.colorlabel.text = [NSString stringWithFormat:@"%@",exterior.modelsExteriorColourName];
        NSArray *array = [exterior.modelsExteriorColorCodes componentsSeparatedByString:@"#"]; //从字符A中分隔成2个元素的数组
        if (array.count == 1) {
            cell.colorImage.backgroundColor = [UIColor whiteColor];
        }else{

            NSScanner *scanner=[NSScanner scannerWithString:[NSString stringWithFormat:@"0x%@",[array objectAtIndex:1]]];
            unsigned int temp;
            [scanner scanHexInt:&temp];
//            NSLog(@"temp = %d",temp);
            cell.colorImage.backgroundColor = [self colorWithRGB:temp alpha:1];

        }

    }else{

        InteriorColorModel *interior = [_interiorArray objectAtIndex:indexPath.row];
        cell.colorlabel.text = [NSString stringWithFormat:@"%@",interior.modelsInteriorColourName];
        NSArray *array = [interior.modelsInteriorColorCodes componentsSeparatedByString:@"#"]; //从字符A中分隔成2个元素的数组
        if (array.count == 1) {
            cell.colorImage.backgroundColor = [UIColor whiteColor];
        }else{
            NSScanner *scanner=[NSScanner scannerWithString:[NSString stringWithFormat:@"0x%@",[array objectAtIndex:1]]];
            unsigned int temp;
            [scanner scanHexInt:&temp];
            //            NSLog(@"temp = %d",temp);
            cell.colorImage.backgroundColor = [self colorWithRGB:temp alpha:1];

        }

    }
    return cell;

}
-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{

    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_interior == 0) {

         ExteriorColorModel *exterior = [_interiorArray objectAtIndex:indexPath.row];
        [LCCoolHUD showLoading:@"正在加载" inView:self.view];
        LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

        [NetworkRequest postGetAllTheModelsOfInteriorColorSetRequestWithCarUserId:login.userId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {

            [LCCoolHUD hideInView:self.view];
            if ([errorMessage isEqualToString:@"0"]) {
                _appearanceStr = exterior.modelsExteriorColourName;
                _appearanceId = exterior.modelsExteriorColourId;

                _interior = 1;
                _nav.titleLabel.text = @"内饰颜色";
                _interiorArray = saleArray;
                [_interiorTable reloadData];
                
            }
        }];

    }else{

         InteriorColorModel *interior = [_interiorArray objectAtIndex:indexPath.row];
        self.interiorColor(_appearanceStr,interior.modelsInteriorColourName,_appearanceId,interior.modelsInteriorColourId);
        [self.navigationController popViewControllerAnimated:YES];

    }

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
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
