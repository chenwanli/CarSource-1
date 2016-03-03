//
//  LookingForViewController.m
//  CarSource
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//
//发布求购
#import "LookingForViewController.h"
#import "RulesCarView.h"
#import "ParallelView.h"
#import "ModelsToChooseViewController.h"
#import "InteriorColorViewController.h"
#import "MemberTypeViewController.h"
#import "LookingForViewCell.h"
#import "ChooseBrandViewController.h"

@interface LookingForViewController ()<UITextViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
//    UIScrollView *_scrollView;
//    UIButton *_btn;
    UITextView *_textview;
    UITableView *_lookingTable;
    NSMutableArray *_lookingArray;
    NSInteger _editing;
    NSString *_vehicleId;
    NSString *_memberTypeId;
    NSString *_vehicleName;
    NSString *_memberType;
    NSString *_text;
    NSString *_specifications;
    NSString *_specificationId;
}
//@property (nonatomic,strong)RulesCarView *rules;
//@property (nonatomic,strong)ParallelView *parallel;
@end

@implementation LookingForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _editing = 1;
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"寻车";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };
    _lookingArray = [[NSMutableArray alloc]initWithObjects:@"选择品牌",@"会员类型", nil];

    _lookingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _lookingTable.delegate = self;
    // 设置数据源
    _lookingTable.dataSource = self;
    _lookingTable.bounces = NO;
    _lookingTable.backgroundColor = GRAY;
    _lookingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_lookingTable];

    [self initTableHeaderView];

}
- (void)initTableHeaderView{

    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
    headerView.backgroundColor = GRAY;


    _textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH -20, 150)];
    _textview.backgroundColor=[UIColor whiteColor]; //背景色
    _textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    _textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    _textview.delegate = self;       //设置代理方法的实现类
    //                _textview.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    //                _textview.layer.borderWidth = 1.0;
    _textview.textColor = [UIColor grayColor];

    _textview.text = @"请输入详细的寻车需求，包括配置，价格需求，提车时间，现车期货等...";

    _textview.font=[UIFont fontWithName:@"Arial" size:15.0]; //设置字体名字和字体大小;
    _textview.returnKeyType = UIReturnKeyDone;//return键的类型
    _textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    _textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    //    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    _textview.textColor = [UIColor grayColor];
    //    textview.text = @"UITextView详解";//设置显示的文本内容
    [headerView addSubview:_textview];

    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 170, SCREEN_WIDTH, 40)];
    headerLabel.font = [UIFont systemFontOfSize:16];
//    headerLabel.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
//    headerLabel.layer.borderWidth = 1.0;
    headerLabel.backgroundColor = LIGHTBLUE;
    headerLabel.text = @"  谁可以看";
    headerLabel.textColor = BLACK;
    [headerView addSubview:headerLabel];

    UIImageView *lineImage = [[UIImageView alloc]init];
    lineImage.backgroundColor = [UIColor colorWithRed:175/255.0 green:219/255.0 blue:246/255.0 alpha:1];
    [headerView addSubview:lineImage];
    [lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(@0);
        make.right.equalTo(headerView).offset(-0);
        make.height.equalTo(@1);
    }];
    
    _lookingTable.tableHeaderView = headerView;

    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    footerView.backgroundColor = GRAY;
    UIButton *depositButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [depositButton setTitle:@"提交" forState:UIControlStateNormal];
    depositButton.frame = CGRectMake(50,30, SCREEN_WIDTH - 100, 50);
    depositButton.titleLabel.font = [UIFont systemFontOfSize:18];
    depositButton.backgroundColor = COLOR;
    depositButton.layer.cornerRadius = 5;
    depositButton.layer.masksToBounds = YES;
    [depositButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    [depositButton addTarget:self action:@selector(depositButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:depositButton];
    _lookingTable.tableFooterView = footerView;

}
- (void)depositButtonClick:(UIButton *)button{

    [self.view endEditing:YES];

    if (_text == nil || [_text isEqualToString:@""]) {
        SHOW_ALERT(@"请填写寻车内容")
        return;
    }

    if (_vehicleId == nil || [_vehicleId isEqualToString:@""]) {
        SHOW_ALERT(@"请选择品牌")
        return;
//        _vehicleId = @"1";
    }
    
    if (_memberTypeId == nil || [_memberTypeId isEqualToString:@""]) {
        SHOW_ALERT(@"请选择会员类型")
        return;
    }

    [LCCoolHUD showLoading:@"正在加载" inView:self.view];
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [ResourcesRequest postAddRulesFoundInCarsRequestWithUserId:login.userId text:_textview.text userTypeId:_memberTypeId seriesTypeId:_vehicleId specificationId:_specificationId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"]) {

            [LCCoolHUD showSuccess:@"寻车发布成功" zoom:YES shadow:YES];
            self.looking(nil);
            [self.navigationController popViewControllerAnimated:YES];
        }


    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return _lookingArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"Cell";
    LookingForViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[LookingForViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.membersLabel.text = [_lookingArray objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        if (_specifications == nil || [_specifications isEqualToString:@""]) {
            cell.typeLabel.text = _vehicleName;
        }else{
            cell.typeLabel.text = [NSString stringWithFormat:@"%@/%@",_specifications,_vehicleName];
        }

    }else{
        cell.typeLabel.text = _memberType;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        ChooseBrandViewController *chooseBrand = [[ChooseBrandViewController alloc]init];
        chooseBrand.chooseBrand = 12;
        [self.navigationController pushViewController:chooseBrand animated: YES];
        chooseBrand.vehicleId = ^(NSString *vehicleId,NSString *vehicleName,NSString *specificationId,NSString *specifications){
            _vehicleId = vehicleId;
            _vehicleName = vehicleName;
            _specifications = specifications;
            _specificationId = specificationId;
            [tableView reloadData];
        };
    }else{
        MemberTypeViewController *memberType = [[MemberTypeViewController alloc]init];
        memberType.isMember = YES;
        [self.navigationController pushViewController:memberType animated: YES];
        memberType.memberType = ^(NSString *memberType,NSString *memberTypeId){
            _memberTypeId = memberTypeId;
            _memberType = memberType;
            [tableView reloadData];
        };

    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    if (_editing == 1) {
        _textview.text = @"";
        _textview.textColor = [UIColor blackColor];
    }

    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    _editing = 2;
    if ([textView.text isEqualToString:@""] || textView.text == nil ) {
        _editing = 1;
        _textview.text = @"请输入详细的寻车需求，包括配置，价格需求，提车时间，现车期货等...";
        _textview.textColor = [UIColor grayColor];
    }else{
        _text = textView.text;
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return YES; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }

    return YES;
}

/*
- (void)initLookingForView{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    view.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
    [self.view addSubview:view];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 15, 18)];
    image.image = [UIImage imageNamed:@"return"];
    [self.view addSubview:image];
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 0, 60, 64);
    //    returnBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //    [_returnBtn setBackgroundImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];

    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(60, 24, SCREEN_WIDTH - 70, 30)];
    textField.font = [UIFont systemFontOfSize:14];
    //    textField.placeholder = @"输入你要找的车型、车号、价格";
    UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Search"]];
    textField.rightView = imgv;
    textField.delegate = self;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textColor = [UIColor whiteColor];
    textField.backgroundColor = [UIColor colorWithRed:17/255.0 green:143/255.0 blue:218/255.0 alpha:1];
    [textField setReturnKeyType : UIReturnKeySearch ];
    textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"输入你要找的车型、车号、价格" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} ];
    textField.clearButtonMode = UITextFieldViewModeAlways;

    [self.view addSubview:textField];

    NSArray *arr = [[NSArray alloc]initWithObjects:@"中规寻车",@"平行进口", nil];

    for (int i = 0; i < arr.count; i++) {
        UIButton *salesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        salesButton.frame = CGRectMake(SCREEN_WIDTH/2*i, 64, SCREEN_WIDTH/2, 44);
        [salesButton setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        [salesButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        salesButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [salesButton setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateSelected];
        salesButton.tag = 10 +i;
        [salesButton addTarget:self action:@selector(salesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:salesButton];

        if (i != 0) {
            UIImageView *image  = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2*i, 66, 1, 36)];
            image.backgroundColor = [UIColor colorWithRed:175/255.0 green:198/255.0 blue:225/255.0 alpha:1];
            [self.view addSubview:image];

        }else{
            [self salesButtonClick:salesButton];
        }
    }
    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 107, SCREEN_WIDTH, 1)];
    lineImage.backgroundColor = LIGHTBLUE;
    [self.view addSubview:lineImage];

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 108, SCREEN_WIDTH, SCREEN_HEIGHT - 108)];
    // 是否支持滑动最顶端
    //    scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    // 设置内容大小
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2,SCREEN_HEIGHT - 108);
    // 是否反弹
    _scrollView.bounces = NO;
    // 是否分页
    _scrollView.pagingEnabled = YES;
    // 是否滚动
    //    scrollView.scrollEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:_scrollView];

    self.rules = [[RulesCarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108)];
    [_scrollView addSubview:self.rules];

    __weak LookingForViewController *looking = self;

    self.rules.rulesCar = ^(NSInteger rulesCar){
        switch (rulesCar) {
            case 0:
            {
                ModelsToChooseViewController *modelsView = [[ModelsToChooseViewController alloc]init];
                [looking.navigationController pushViewController:modelsView animated:YES];

                modelsView.chooseType = ^(NSString *chooseType){
                    [looking.rules initTypeStr:chooseType];
                };


            }
                break;
            case 1:
            {
                InteriorColorViewController *interior = [[InteriorColorViewController alloc]init];
                [looking.navigationController pushViewController:interior animated:YES];

                interior.interiorColor = ^(NSString *appearance, NSString *interiorColor,NSString *appearanceId, NSString *interiorColorId){
                    [looking.rules initColorStr:interiorColor];
                };

            }
                break;
            case 2:
            {
                
            }
                break;
                
            default:
                break;
        }


    };

    self.rules.members = ^(NSString *members){
        MemberTypeViewController *memberType = [[MemberTypeViewController alloc]init];
        [looking.navigationController pushViewController:memberType animated: YES];

    };

    self.parallel = [[ParallelView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108)];
    [_scrollView addSubview:self.parallel];
    self.parallel.rulesCar = ^(NSInteger rulesCar){
        switch (rulesCar) {
            case 0:
            {
                ModelsToChooseViewController *modelsView = [[ModelsToChooseViewController alloc]init];
                [looking.navigationController pushViewController:modelsView animated:YES];

                modelsView.chooseType = ^(NSString *chooseType){
                    [looking.parallel initTypeStr:chooseType];
                };


            }
                break;
            case 1:
            {
                InteriorColorViewController *interior = [[InteriorColorViewController alloc]init];
                [looking.navigationController pushViewController:interior animated:YES];

                interior.interiorColor = ^(NSString *appearance, NSString *interiorColor,NSString *appearanceId, NSString *interiorColorId){
                    [looking.parallel initColorStr:interiorColor];
                };

            }
                break;
            case 2:
            {

            }
                break;

            default:
                break;
        }


    };

    self.parallel.members = ^(NSString *members){
        MemberTypeViewController *memberType = [[MemberTypeViewController alloc]init];
        [looking.navigationController pushViewController:memberType animated: YES];
        
    };


}
- (void)salesButtonClick:(UIButton *)button{
    _btn.selected = NO;
    button.selected = YES;
    _btn = button;

    if (button.tag == 10) {
        CGPoint position = CGPointMake(0, 0);
        [_scrollView setContentOffset:position animated:YES];
    }else{
        CGPoint position = CGPointMake(SCREEN_WIDTH, 0);
        [_scrollView setContentOffset:position animated:YES];
    }

}
// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"scrollViewDidScroll  %f",scrollView.contentOffset.x );
    if (scrollView.contentOffset.x == SCREEN_WIDTH) {
        UIButton *button = (UIButton *)[self.view viewWithTag:11];
        _btn.selected = NO;
        button.selected = YES;
        _btn = button;
    }
    if(scrollView.contentOffset.x == 0){
        UIButton *button = (UIButton *)[self.view viewWithTag:10];
        _btn.selected = NO;
        button.selected = YES;
        _btn = button;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}


- (void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
 */
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
