//
//  GuaranteeDetailsViewController.m
//  CarSource
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//
//定金担保
#import "GuaranteeDetailsViewController.h"
#import "GuaranteeDetailsViewCell.h"
#import "DetailsHeaderView.h"
#import "DetailsFooterView.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
#import "ModelsToChooseViewController.h"
#import "InteriorColorViewController.h"
#import "FriendsListViewController.h"
#import "ChooseBrandViewController.h"


@interface GuaranteeDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>{

    NSMutableArray *_detailsArray;
    NSString *_carStr;


}
@property (nonatomic,strong)NSString *userFriendsId;
@property (nonatomic,strong)NSString *guarantee;
@property (nonatomic,strong)NSString *priceStr;
@property (nonatomic,strong)NSString *friendsName;
@property (nonatomic,strong)NSString *colorStr;
@property (nonatomic,strong)NSString *carSeriesTypeName;//车型
@property (nonatomic,strong)NSString *carSeriesTypeId;//车型ID
@property (nonatomic,strong)DetailsFooterView *footerView;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)UITableView *detailsTable;
@property (nonatomic,strong)NSString *guaranteeStr;
@end

@implementation GuaranteeDetailsViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GRAY;
    _detailsArray = [[NSMutableArray alloc]initWithObjects:@"选择对象",@"交易车型",@"车辆颜色",@"成交价格",@"定金担保", nil];
    self.imageArray = [[NSMutableArray alloc]init];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"定金担保";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _detailsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _detailsTable.delegate = self;
    // 设置数据源
    _detailsTable.dataSource = self;
    _detailsTable.bounces = NO;
    _detailsTable.backgroundColor = [UIColor whiteColor];
    _detailsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _detailsTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_detailsTable];

//    DetailsHeaderView *headerView = [[DetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 98)];
//    _detailsTable.tableHeaderView = headerView;

    [self initDetailsFooterViewHeight:(SCREEN_WIDTH - 20)/3 +180];

}
- (void)initDetailsFooterViewHeight:(CGFloat)height{
    [self.footerView removeFromSuperview];

    self.footerView = [[DetailsFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    __weak typeof(self) weakSelf = self;
    self.footerView.addImage = ^(NSString *addImage){

        [weakSelf selectPhotos];

    };
    self.footerView.canceldelete = ^(NSString *canceldelete){
//        [weakSelf initDetailsFooterViewHeight:[weakSelf salesHeightViewArray:weakSelf.imageArray]+180];
        [weakSelf.footerView initAddImageArray:weakSelf.imageArray height:[weakSelf salesHeightViewArray:weakSelf.imageArray] cancel:YES];
    };

    self.footerView.deleteImage = ^(NSInteger deleteImage){

        [weakSelf.imageArray removeObjectAtIndex:deleteImage];

        CGFloat  height = [weakSelf salesHeightViewArray:weakSelf.imageArray];
        [weakSelf initDetailsFooterViewHeight: height+180];
        
        [weakSelf.footerView initAddImageArray:weakSelf.imageArray height:height cancel:NO];

    };

    self.footerView.toViewImage = ^(NSInteger toViewImage){

        MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
        browserVc.currentPage = toViewImage;
        browserVc.photos = weakSelf.imageArray;
        weakSelf.navigationController.navigationBarHidden = NO;
        [weakSelf.navigationController pushViewController:browserVc animated:YES];
    };

    self.footerView.imageArr = ^(NSMutableArray *array){

        if ([weakSelf.userFriendsId isEqualToString:@""] || weakSelf.userFriendsId == nil ) {

            SHOW_ALERT(@"请选择你的担保好友")
            return ;

        }
        if ([weakSelf.carSeriesTypeId isEqualToString:@""] || weakSelf.carSeriesTypeId == nil ) {

            SHOW_ALERT(@"请选择交易车型")
            return ;
            
        }
        
        if ([weakSelf.colorStr isEqualToString:@""] || weakSelf.colorStr == nil ) {

            SHOW_ALERT(@"请选择车辆颜色")
            return ;
            
        }
        
        if ([weakSelf.priceStr isEqualToString:@""] || weakSelf.priceStr == nil ) {

            SHOW_ALERT(@"请填写成交价格")
            return ;
            
        }
        
        if ([weakSelf.guarantee isEqualToString:@""] || weakSelf.guarantee == nil ) {

            SHOW_ALERT(@"请填写担保金额")
            return ;
            
        }

        if ([weakSelf.guaranteeStr isEqualToString:@""] || weakSelf.guaranteeStr == nil ) {

            SHOW_ALERT(@"请填约定内容")
            return ;

        }
        if (array.count == 0) {
            SHOW_ALERT(@"请添加图片")
            return ;
        }


        LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
        [LCCoolHUD showLoading:@"正在上传" inView:weakSelf.view];

        [ResourcesRequest postAGuaranteeRequestWithUserId:login.userId vouchTransactionCarSeriesTypeId:weakSelf.carSeriesTypeId imageArray:array vouchTransactionColour:weakSelf.colorStr vouchTransactionDealPrice:weakSelf.priceStr vouchTransactionGuaranteeDepositPrice:weakSelf.guarantee vouchTransactionText:weakSelf.guaranteeStr tel:weakSelf.userFriendsId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
            [LCCoolHUD hideInView:weakSelf.view];
            if ([errorMessage isEqualToString:@"0"] ) {

                [LCCoolHUD showSuccess:@"发布成功" zoom:YES shadow:YES];
            }

        }];

    };


    _detailsTable.tableFooterView = self.footerView;

}
- (CGFloat)salesHeightViewArray:(NSMutableArray *)arr{

    if (arr.count != 0) {
        for (int i = 0; i < arr.count; i++) {
            if (i == arr.count -1) {
                int line= (i + 1)/3;//行号
                //1/3=0,2/3=0,3/3=1;
                if (arr.count<9) {
                    return (SCREEN_WIDTH - 20)/3*(line +1);

                }else{

                    return (SCREEN_WIDTH - 20)/3*line;
                }
            }
        }

    }else{

        return (SCREEN_WIDTH - 20)/3;
    }

    return 0;
}

#pragma mark - 选择相册
- (void)selectPhotos {
    // 创建控制器
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.status = PickerViewShowStatusCameraRoll;

    if (_imageArray.count == 0) {
        pickerVc.maxCount = 9;
    }else{
        pickerVc.maxCount = 9 - _imageArray.count;
    }

    [pickerVc showPickerVc:self];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets){

        if (assets.count != 0) {
            [weakSelf.imageArray addObjectsFromArray:assets];
            CGFloat  height = [weakSelf salesHeightViewArray:weakSelf.imageArray];
            [weakSelf initDetailsFooterViewHeight:height +180];
            [weakSelf.footerView initAddImageArray:weakSelf.imageArray height:height cancel:NO];

        }
    };
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 6;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    GuaranteeDetailsViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[GuaranteeDetailsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        switch (indexPath.row) {
            case 0:
            {
                [cell initGuaranteeDetailsViewCell];
            }
                break;
            case 1:
            {
                [cell initGuaranteeDetailsViewCell];
            }
                break;
            case 2:
            {
                [cell initGuaranteeDetailsViewCell];

            }
                break;
            case 3:
            {
                [cell initGuaranteeDetailsViewCellUnitText:@"万" placeholder:@"请输入报价"];


            }
                break;
            case 4:
            {
                 [cell initGuaranteeDetailsViewCellUnitText:@"元" placeholder:@"请输入定金金额"];

            }
                break;
            case 5:
            {
                 [cell initTextView];
                cell.guarantee = ^(NSString *guarantee){
                    self.guaranteeStr = guarantee;
                };
            }
                break;

            default:
                break;
        }


    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row == 5) {
        cell.typeLabel.hidden = YES;
        cell.image.hidden = YES;
    }else{
        cell.typeLabel.text = [_detailsArray objectAtIndex:indexPath.row];
    }

    switch (indexPath.row) {
        case 0:
        {
            cell.chooseLabel.text = _friendsName;
        }
            break;

        case 1:
        {
            cell.chooseLabel.text = _carSeriesTypeName;
        }
            break;
        case 2:
        {
            cell.chooseLabel.text = _colorStr;
        }
            break;
        case 3:
        {
            cell.numberField.delegate = self;
            cell.numberField.tag = indexPath.row;
            cell.numberField.text = self.priceStr;
        }
            break;
        case 4:
        {
            cell.numberField.delegate = self;
            cell.numberField.tag = indexPath.row;
            cell.numberField.text = self.guarantee;
        }
            break;
        case 5:
        {
            if (![self.guaranteeStr isEqualToString:@""] || self.guaranteeStr != nil ) {
                cell.textview.text = self.guaranteeStr;
            }

        }
            break;
        default:
            break;
    }


    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {
            FriendsListViewController *friendsList = [[FriendsListViewController alloc]init];
            friendsList.isList = YES;
            [self.navigationController pushViewController:friendsList animated:YES];
            friendsList.friendsList = ^(NSString *userFriendsId ,NSString *friendsName){
                _userFriendsId = userFriendsId;
                _friendsName = friendsName;
                [_detailsTable reloadData];
            };
        }
            break;
        case 1:
        {
            ChooseBrandViewController *chooseBrand = [[ChooseBrandViewController alloc]init];
            chooseBrand.isChoose = YES;
            chooseBrand.navCount = 2;
            chooseBrand.isExhibition = YES;
            [self.navigationController pushViewController:chooseBrand animated: YES];

            chooseBrand.exhibition = ^(NSString *carSeriesTypeName,NSString *carSeriesTypeId,NSString *specificationId ,NSString *specifications){

                if ([specifications isEqualToString:@""] || specifications == nil) {
                    _carSeriesTypeName = carSeriesTypeName;
                }else{
                    _carSeriesTypeName = [NSString stringWithFormat:@"%@/%@",specifications,carSeriesTypeName];
                }

                _carSeriesTypeId = carSeriesTypeId;
                [_detailsTable reloadData];
            };
            



        }
            break;
        case 2:
        {
            InteriorColorViewController *interior = [[InteriorColorViewController alloc]init];
            [self.navigationController pushViewController:interior animated:YES];

            interior.interiorColor = ^(NSString *appearance, NSString *interiorColor,NSString *appearanceId, NSString *interiorColorId){
                _colorStr = [NSString stringWithFormat:@"%@/%@",appearance,interiorColor];
                [tableView reloadData];
            };



        }
            break;


        default:
            break;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        return 170;
    }else{
        return 44;
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField.tag == 3) {
        self.priceStr = textField.text;
    }else{
        self.guarantee = textField.text;
    }
    return YES;
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
