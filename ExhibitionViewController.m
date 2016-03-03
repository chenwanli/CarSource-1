
//
//  ExhibitionViewController.m
//  CarSource
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 apple. All rights reserved.
//
//展厅
#import "ExhibitionViewController.h"
#import "ExhibitionTableHeardView.h"
#import "ExhibitionViewCell.h"
#import "LatestBelowViewController.h"
#import "MemorialViewController.h"
#import "InTheCarViewController.h"
#import "BelowReleaseViewController.h"
#import "ExhibitionModel.h"
#import "ShowCarModel.h"
#import "TransactionVehicles.h"
#import "ShowroomViewController.h"
#import "ScreenshotsViewController.h"

@interface ExhibitionViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIImageView *_titleImage;
    UITableView *_exhibitionTable;
    NSMutableArray *_exhibitionArray;
    NSString *_phoneStr;
    NSMutableArray *_dataArray;
    ExhibitionTableHeardView *_exhibition;
    CGFloat _introduction;
    CGFloat _address;
    NSInteger _state;
    NSInteger _stateCount;
    BOOL _userStatus;
    NSString *_ScreenshotsPickPath;
    NSInteger ScreenshotIndex;
}
@property (nonatomic,strong)UIButton *incarBtn;
@property (nonatomic,strong)UIButton *belowBtn;
@property (nonatomic,strong)UIButton *editorBtn;
@property (nonatomic,strong)UIButton *addButton;
@end

@implementation ExhibitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _introduction = 0;
    _address = 0;
    _state = 1;
    _stateCount = 1;
    if ([[UIDevice currentDevice] systemVersion].floatValue>=7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];

    _exhibitionArray = [[NSMutableArray alloc]initWithObjects:@"展车介绍",@"我的地址",@"星级评分",@"联系电话",@"经营品牌",@"公司销售",@"全部展车",@"交车纪念", nil];

    _dataArray = [[NSMutableArray alloc]init];
    
    _exhibitionTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _exhibitionTable.delegate = self;
    // 设置数据源
    _exhibitionTable.dataSource = self;
//    _exhibitionTable.bounces = NO;
    _exhibitionTable.backgroundColor = [UIColor whiteColor];
    _exhibitionTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_exhibitionTable];

    [self initTitleView];

    [self installationMJRefresh_2_GIF];
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

    _exhibitionTable.mj_header = header;
    // 马上进入刷新状态
    [_exhibitionTable.mj_header beginRefreshing];
    
}
- (void)refresh
{
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    if (self.isAop == YES) {
        [NetworkRequest postMyShowroomRequestWithUserId:login.userId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage){
            if ([errorMessage isEqualToString:@"0"]) {
                [_dataArray removeAllObjects];
                _state = 2;
                for (ExhibitionModel *model in saleArray) {
                    [_dataArray addObject:model];
                }
//                NSLog(@" showCarList = %@",showCarList);
                self.promotionId = showCarList;

                ExhibitionModel *model = [saleArray objectAtIndex:0];
                if ([model.userStatus boolValue] == YES) {
                    self.incarBtn.hidden = NO;
                    self.belowBtn.hidden = NO;
                    self.editorBtn.hidden = NO;
                    self.addButton.hidden = NO;
                    _userStatus = YES;
                }else{
                    _userStatus = NO;
                }
            }
             _stateCount = 2;
        }];
    }else{
        [NetworkRequest postExhibitionInformationRequestWithUserId:login.userId showroomId:self.promotionId Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {

            if ([errorMessage isEqualToString:@"0"]) {
                [_dataArray removeAllObjects];
                _state = 2;
                for (ExhibitionModel *model in saleArray) {
                    [_dataArray addObject:model];
                }
                ExhibitionModel *model = [saleArray objectAtIndex:0];

                if ([model.userStatus boolValue] == YES) {
                    self.incarBtn.hidden = NO;
                    self.belowBtn.hidden = NO;
                    self.editorBtn.hidden = NO;
                    self.addButton.hidden = NO;
                    _userStatus = YES;
                }else{
                    _userStatus = NO;
                }

            }
            _stateCount = 2;
        }];

    }

    // 为了看效果 延长3秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        if (_state == 2) {
            _state = 1;
            [_exhibitionTable reloadData];
        }
        if (_stateCount == 2) {
            _stateCount = 1;
            [_exhibitionTable.mj_header endRefreshing];
        }

    });

}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _exhibitionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    ExhibitionViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ExhibitionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];;
        switch (indexPath.row) {
                case 1:
            {
//                 [cell theExhibitionHallisIntroducedHeight:55];
            }
                break;
            case 2:
            {
                [cell initLHRatingView];
            }
                break;
            case 3:
            {
                [cell initContactPhoneNumber];
            }
                break;
                case 6:
            {
                [cell initAllofTheBelow];
            }
                break;
            case 7:
            {
                [cell initItForMemorial];
            }
                break;

                
            default:
                break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:245/255.0 green:251/255.0 blue:255/255.0 alpha:1];
    cell.typeLabel.text = [_exhibitionArray objectAtIndex:indexPath.row];
    if (_dataArray.count != 0) {

        ExhibitionModel *model = [_dataArray objectAtIndex:0];
        switch (indexPath.row) {
            case 0:
            {
                CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH - 100, model.showroomBriefIntroduction, 14);

                [cell theExhibitionHallisIntroducedHeight:size.height +10];

                _introduction = size.height +30;

                cell.introduceLabel.text = [NSString stringWithFormat:@"%@",model.showroomBriefIntroduction];
                [_exhibition initExhibitionTableHeardViewArray:_dataArray];
            }
                break;
            case 1:
            {
                CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH - 100, model.showrooAddress, 14);

                [cell theExhibitionHallisIntroducedHeight:size.height +10];
                _address = size.height +30;

                cell.introduceLabel.text = [NSString stringWithFormat:@"%@",model.showrooAddress];
            }
                break;
            case 2:
            {
                cell.rView.score = [model.score integerValue];


            }
                break;
            case 3:
            {
                [cell.phoneBtn setTitle:[NSString stringWithFormat:@"%@",model.showrooUserTel] forState:UIControlStateNormal];
                _phoneStr = [NSString stringWithFormat:@"%@",model.showrooUserTel] ;
                [cell.phoneBtn addTarget:self action:@selector(phoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 4:
            {

                 [cell initBrandManagementImageArray:model.brandUrlList];
            }
                break;
            case 5:
            {
                [cell initCompanySalesArray:model.customerServiceUserList];

            }
                break;
            case 6:
            {
                ShowCarModel *show = [model.showCar objectAtIndex:0];
                [cell.belowIamge sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,show.showCarUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
                cell.carLabel.text = [NSString stringWithFormat:@"%@",show.showCarModels];
                cell.priceLabel.text = [NSString stringWithFormat:@"%@ 万",show.showCarPrice];
                cell.detailedLabel.text = [NSString stringWithFormat:@"%@",show.showCarIntroduction];
                
            }
                break;
                
            case 7:
            {
                TransactionVehicles *vehicles = [model.transactionVehicles objectAtIndex:0];
                [cell.memorialImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,vehicles.transactionVehiclesUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
                cell.carLabel.text = [NSString stringWithFormat:@"%@",vehicles.transactionVehiclesModels];

                cell.detailedLabel.text = [NSString stringWithFormat:@"%@",vehicles.transactionVehiclesIntroduction];

                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",vehicles.transactionVehiclesTime] doubleValue] / 1000];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                NSString *dateString = [dateFormat stringFromDate:date];

                 cell.priceLabel.text = dateString;

            }
                break;
                
            default:
                break;
        }

    }


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
        case 0:
        {
            if (_introduction == 0) {
                return 50;
            }else{
                return _introduction;
            }

        }
            break;
        case 1:
        {
            if (_address == 0) {
                return 50;
            }else{
                return _address;
            }

        }
            break;
        case 2:
        {
            return 50;
        }
            break;
        case 3:
        {
            return 50;
        }
            break;
        case 4:
        {
            return 110;
        }
            break;
        case 5:
        {
            return 160;
        }
            break;
        case 6:
        {
            return 190;
        }
            break;
        case 7:
        {
            return 270;
        }
            break;


        default:
            break;
    }

    return 0;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 6:
        {
            if (_dataArray.count != 0) {
                LatestBelowViewController *latest = [[LatestBelowViewController alloc]init];
                latest.showroomId = self.promotionId;
                latest.userStatus = _userStatus;
                [self.navigationController pushViewController:latest animated:YES];

            }else{
                SHOW_ALERT(@"数据异常，请下拉刷新界面");
            }
        }
            break;
        case 7:
        {
            if (_dataArray.count != 0) {
                MemorialViewController *memorial = [[MemorialViewController alloc]init];
                memorial.showroomId = self.promotionId;
                memorial.userStatus = _userStatus;
                [self.navigationController pushViewController:memorial animated:YES];

            }else{
                SHOW_ALERT(@"数据异常，请下拉刷新界面");
            }


        }
            break;


        default:
            break;
    }
}

- (void)phoneButtonClick:(UIButton *)button{

    if (_phoneStr != nil || [_phoneStr isEqualToString:@""]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_phoneStr]]];

    }
}


- (void)initTitleView{

    _exhibition = [[ExhibitionTableHeardView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280)];
    _exhibitionTable.tableHeaderView = _exhibition;

    _titleImage = [[UIImageView alloc]init];
//    _titleImage.backgroundColor = COLOR;
    [self.view addSubview:_titleImage];

//    _titleImage.alpha = 0;


    UIImageView *image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"return"];
    [self.view addSubview:image];

    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setTitle:@"我的展厅" forState:UIControlStateNormal];
//    [returnButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    returnButton.titleLabel.font = [UIFont systemFontOfSize:16];
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

    self.incarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.incarBtn.frame = CGRectMake(SCREEN_WIDTH- 70, SCREEN_HEIGHT-70, 50, 50);
    [self.incarBtn setImage:[UIImage imageNamed:@"sunshine"] forState:UIControlStateNormal];
    [self.incarBtn addTarget:self action:@selector(incarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.incarBtn];
    self.incarBtn.hidden = YES;

    self.belowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.belowBtn.frame = CGRectMake(SCREEN_WIDTH- 70, SCREEN_HEIGHT-70, 50, 50);
    [self.belowBtn setImage:[UIImage imageNamed:@"sweetheart"] forState:UIControlStateNormal];
    [self.belowBtn addTarget:self action:@selector(belowButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.belowBtn];
    self.belowBtn.hidden = YES;

    self.editorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editorBtn.frame = CGRectMake(SCREEN_WIDTH- 70, SCREEN_HEIGHT-70, 50, 50);
    self.editorBtn.layer.cornerRadius = 25;
    self.editorBtn.layer.masksToBounds = YES;
    self.editorBtn.backgroundColor = COLOR;
    [self.editorBtn setImage:[UIImage imageNamed:@"editor"] forState:UIControlStateNormal];
    [self.editorBtn addTarget:self action:@selector(editorButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editorBtn];
    self.editorBtn.hidden = YES;


    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton setImage:[UIImage imageNamed:@"gorgeous"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
    self.addButton.hidden = YES;


    [_titleImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(self.view).offset(@0);
        make.height.equalTo(64);

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

    [self.addButton makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.right.equalTo(self.view).offset(-20);
        make.size.equalTo(CGSizeMake(50, 50));
    }];

}

- (void)addButtonClick:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {

        [UIView animateWithDuration:0.3 animations:^{

            self.incarBtn.frame = CGRectMake(SCREEN_WIDTH- 70, SCREEN_HEIGHT-150, 50, 50);
            self.belowBtn.frame = CGRectMake(SCREEN_WIDTH- 150, SCREEN_HEIGHT-70, 50, 50);
            self.editorBtn.frame = CGRectMake(SCREEN_WIDTH- 150, SCREEN_HEIGHT-150, 50, 50);

        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.incarBtn.frame = CGRectMake(SCREEN_WIDTH- 70, SCREEN_HEIGHT-130, 50, 50);
                self.belowBtn.frame = CGRectMake(SCREEN_WIDTH- 130, SCREEN_HEIGHT-70, 50, 50);
                self.editorBtn.frame = CGRectMake(SCREEN_WIDTH- 130, SCREEN_HEIGHT-130, 50, 50);
            } completion:nil];


        }];

    }else{


        [UIView animateWithDuration:0.2 animations:^{

            self.incarBtn.frame = CGRectMake(SCREEN_WIDTH- 70, SCREEN_HEIGHT-150, 50, 50);
            self.belowBtn.frame = CGRectMake(SCREEN_WIDTH- 150, SCREEN_HEIGHT-70, 50, 50);
            self.editorBtn.frame = CGRectMake(SCREEN_WIDTH- 150, SCREEN_HEIGHT-150, 50, 50);

        } completion:^(BOOL finished) {

            [UIView animateWithDuration:0.3 animations:^{
                self.incarBtn.frame = CGRectMake(SCREEN_WIDTH- 70, SCREEN_HEIGHT-70, 50, 50);
                self.belowBtn.frame = CGRectMake(SCREEN_WIDTH- 70, SCREEN_HEIGHT-70, 50, 50);
                self.editorBtn.frame = CGRectMake(SCREEN_WIDTH- 70, SCREEN_HEIGHT-70, 50, 50);
                
            } completion:nil];
        }];
        
        
    }
    
}
//展车发布
- (void)belowButtonClick{
    BelowReleaseViewController *below = [[BelowReleaseViewController alloc]init];
    [self.navigationController pushViewController:below animated:YES];
    below.belowRelease = ^(NSString *str){

        [self installationMJRefresh_2_GIF];

    };

}
//交车发布
- (void)incarButtonClick{
    InTheCarViewController *carView = [[InTheCarViewController alloc]init];
    carView.showroomId = self.promotionId;
    [self.navigationController pushViewController:carView animated:YES];
    carView.inTheCar = ^(NSString *str){

        [self installationMJRefresh_2_GIF];
        
    };

}
//编辑资料
- (void)editorButtonClick{

    if (_dataArray.count != 0) {
        ShowroomViewController *showroom = [[ShowroomViewController alloc]init];
        showroom.showroomArray = _dataArray;
        showroom.showroomId = self.promotionId;
        [self.navigationController pushViewController:showroom animated:YES];

        showroom.showroomView = ^(NSString *str){
             [self installationMJRefresh_2_GIF];
        };

    }else{
        SHOW_ALERT(@"数据异常，请下拉刷新界面");
    }

}

- (void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareButtonClick{
    [self screenShot];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"------ %.1f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <= 280)
    {
        _titleImage.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:scrollView.contentOffset.y/280];
    }

}

/**
 *截图
 */
- (void)screenShot{
    UIImage* image = nil;
//    UIGraphicsBeginImageContext(_exhibitionTable.contentSize);
    UIGraphicsBeginImageContextWithOptions(_exhibitionTable.contentSize, YES, 0);

    {
        CGPoint savedContentOffset = _exhibitionTable.contentOffset;
        CGRect savedFrame = _exhibitionTable.frame;
        _exhibitionTable.contentOffset = CGPointZero;

        _exhibitionTable.frame = CGRectMake(0, 0, _exhibitionTable.contentSize.width, _exhibitionTable.contentSize.height);
        [_exhibitionTable.layer renderInContext: UIGraphicsGetCurrentContext()];

        image = UIGraphicsGetImageFromCurrentImageContext();

        _exhibitionTable.contentOffset = savedContentOffset;
        _exhibitionTable.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    

    if (image != nil) {
        NSLog(@"截图成功!");
        ScreenshotsViewController *screenshots = [ [ScreenshotsViewController alloc]init];
        screenshots.screenshotsImage = image;
        [self.navigationController pushViewController:screenshots animated:YES];


    }
}
//-(void)ScreenShot{
//      //这里因为我需要全屏接图所以直接改了，宏定义iPadWithd为1024，iPadHeight为768，
//  //    UIGraphicsBeginImageContextWithOptions(CGSizeMake(640, 960), YES, 0);     //设置截屏大小
//      UIGraphicsBeginImageContextWithOptions(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT), YES, 0);     //设置截屏大小
//      [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
//      UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//      UIGraphicsEndImageContext();
//       CGImageRef imageRef = viewImage.CGImage;
//   //    CGRect rect = CGRectMake(166, 211, 426, 320);//这里可以设置想要截图的区域
//       CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT);//这里可以设置想要截图的区域
//       CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
//       UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
//       UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);//保存图片到照片库
//       NSData *imageViewData = UIImagePNGRepresentation(sendImage);
//  
//       NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//       NSString *documentsDirectory = [paths objectAtIndex:0];
//       NSString *pictureName= [NSString stringWithFormat:@"screenShow_%ld.png",ScreenshotIndex];
//       NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
//       NSLog(@"截屏路径打印: %@", savedImagePath);
//       //这里我将路径设置为一个全局String，这里做的不好，我自己是为了用而已，希望大家别这么写
//       [self SetPickPath:savedImagePath];
//  
//       [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
//       CGImageRelease(imageRefRect);
//       ScreenshotIndex++;
//}
// //设置路径
//- (void)SetPickPath:(NSString *)PickImage {
//     _ScreenshotsPickPath = PickImage;
//}
// //获取路径<这里我就直接用于邮件推送的代码中去了，能达到效果，但肯定有更好的写法>
// - (NSString *)GetPickPath {
//         return _ScreenshotsPickPath;
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
