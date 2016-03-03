//
//  ReleaseSalesViewController.m
//  CarSource
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//
//发布销售
#import "ReleaseSalesViewController.h"
#import "UlesPublishedView.h"
#import "ParallelImportsView.h"
#import "BulkImportView.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
#import "ModelsToChooseViewController.h"
#import "InteriorColorViewController.h"
#import "ChooseBrandViewController.h"
#import "MemberTypeViewController.h"

@interface ReleaseSalesViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIButton *_btn;
    NSInteger _integer;

}
@property (nonatomic,strong) NSMutableArray *salesArray;
@property (nonatomic,strong)UlesPublishedView *ules;
@property (nonatomic,strong)NSMutableArray *parallelArray;
@property (nonatomic,strong)ParallelImportsView *parallel;
@end

@implementation ReleaseSalesViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;

    [self.parallel initTypeButtontext];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.salesArray = [[NSMutableArray alloc]init];
    self.parallelArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];

    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"发布销售";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
//         清除本地保存的平行进口车型ID
        NSString*appDomain = [[NSBundle mainBundle]bundleIdentifier];

        [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
        [self.navigationController popViewControllerAnimated:YES];
    };

    [self initReleaseSalesViewController];

}
- (void)initReleaseSalesViewController{

    NSArray *arr = [[NSArray alloc]initWithObjects:@"中规发布",@"平行进口",@"批量导入", nil];

    for (int i = 0; i < arr.count; i++) {
        UIButton *salesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        salesButton.frame = CGRectMake(SCREEN_WIDTH/3*i, 64, SCREEN_WIDTH/3, 44);
        [salesButton setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        [salesButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        salesButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [salesButton setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateSelected];
        salesButton.tag = 10 +i;
        [salesButton addTarget:self action:@selector(salesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:salesButton];

        if (i != 0) {
            UIImageView *image  = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*i, 66, 1, 36)];
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
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3,SCREEN_HEIGHT - 108);
    // 是否反弹
    _scrollView.bounces = NO;
    // 是否分页
    _scrollView.pagingEnabled = YES;
    // 是否滚动
    //    scrollView.scrollEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:_scrollView];

    self.ules = [[UlesPublishedView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108)];
    [_scrollView addSubview:self.ules];

     __weak typeof(self) weakSelf = self;

    self.ules.chooseButton = ^(NSInteger chooseButton){

        if (chooseButton == 401) {
            ChooseBrandViewController *chooseBrand = [[ChooseBrandViewController alloc]init];
            chooseBrand.chooseBrand = 12;
            chooseBrand.isChoose = YES;
            [weakSelf.navigationController pushViewController:chooseBrand animated: YES];
            chooseBrand.vehicleId = ^(NSString *vehicleId,NSString *vehicleName,NSString *specificationId,NSString *specifications){
                [weakSelf.ules initVehicleId:vehicleId vehicleName:vehicleName specificationId:specificationId specifications:specifications];
            };
        }else{
            MemberTypeViewController *memberType = [[MemberTypeViewController alloc]init];
            memberType.isMember = YES;
            [weakSelf.navigationController pushViewController:memberType animated: YES];
            memberType.memberType = ^(NSString *memberType,NSString *memberTypeId){

                [weakSelf.ules initMemberType:memberType memberTypeId:memberTypeId];
            };
        }

    };
    self.ules.submit = ^(NSString *submitBtn){

        weakSelf.submitBtn(1);
        [weakSelf.navigationController popViewControllerAnimated:YES];

    };

    self.ules.addBtn = ^(NSString *addBtn){
        _integer = 1;
        [weakSelf selectPhotos];
    };

    self.ules.cancelBtn = ^(NSString *cancelBtn){
        [weakSelf.ules initAddImagesViewImageArray:weakSelf.salesArray];

    };

    self.ules.deleteBtn = ^(NSInteger deleteBtn){

        [weakSelf.salesArray removeObjectAtIndex:deleteBtn];
         [weakSelf.ules initAddImagesViewImageArray:weakSelf.salesArray];

    };

    self.ules.imageBtn = ^(NSInteger imageBtn){

        MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
        browserVc.currentPage = imageBtn;
        browserVc.photos = weakSelf.salesArray;
        weakSelf.navigationController.navigationBarHidden = NO;
        [weakSelf.navigationController pushViewController:browserVc animated:YES];


    };

    self.parallel = [[ParallelImportsView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108)];
    [_scrollView addSubview:self.parallel];

    self.parallel.submitStr = ^(NSString *submitStr){
        weakSelf.submitBtn(2);
        [weakSelf.navigationController popViewControllerAnimated:YES];

    };

    self.parallel.addImage = ^(NSString *addImage){

        _integer = 2;
        [weakSelf selectPhotos];

    };
    self.parallel.canceldelete = ^(NSString *canceldelete){

        [weakSelf.parallel initAddImageArray:weakSelf.parallelArray];
    };

    self.parallel.deleteImage = ^(NSInteger deleteImage){

        [weakSelf.parallelArray removeObjectAtIndex:deleteImage];
        [weakSelf.parallel initAddImageArray:weakSelf.parallelArray];

    };

    self.parallel.toViewImage = ^(NSInteger toViewImage){

        MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
        browserVc.currentPage = toViewImage;
        browserVc.photos = weakSelf.parallelArray;
        weakSelf.navigationController.navigationBarHidden = NO;
        [weakSelf.navigationController pushViewController:browserVc animated:YES];
    };

    self.parallel.models = ^(NSString *models){

        ModelsToChooseViewController *modelsView = [[ModelsToChooseViewController alloc]init];
        [weakSelf.navigationController pushViewController:modelsView animated:YES];
        modelsView.isChooseType = YES;
        modelsView.chooseType = ^(NSString *chooseType,NSString *specifications){
        };
        
    };

    self.parallel.colorBtn = ^(NSString *colorBtn){

        InteriorColorViewController *interior = [[InteriorColorViewController alloc]init];
        [weakSelf.navigationController pushViewController:interior animated:YES];

        interior.interiorColor = ^(NSString *appearance, NSString *interiorColor,NSString *appearanceId, NSString *interiorColorId){
            [weakSelf.parallel initColorAppearance:appearance interior:interiorColor];
        };

    };



    BulkImportView *bulk = [[BulkImportView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH *2, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108)];
    bulk.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:bulk];
}
#pragma mark - 选择相册
- (void)selectPhotos {
    // 创建控制器
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.status = PickerViewShowStatusCameraRoll;

    if (_integer == 1) {
        if (_salesArray.count == 0) {
            pickerVc.maxCount = 9;
        }else{
            pickerVc.maxCount = 9 - _salesArray.count;
        }
    }else{
        if (_parallelArray.count == 0) {
            pickerVc.maxCount = 9;
        }else{
            pickerVc.maxCount = 9 - _parallelArray.count;
        }
    }


    [pickerVc showPickerVc:self];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets){

        if (_integer == 1) {
            [weakSelf.salesArray addObjectsFromArray:assets];
            [self.ules initAddImagesViewImageArray:weakSelf.salesArray];

        }else{
            [weakSelf.parallelArray addObjectsFromArray:assets];
            [self.parallel initAddImageArray:weakSelf.parallelArray];

        }

    };
}

- (void)salesButtonClick:(UIButton *)button{
    _btn.selected = NO;
    button.selected = YES;
    _btn = button;

    switch (button.tag) {
        case 10:
        {
            CGPoint position = CGPointMake(0, 0);
            [_scrollView setContentOffset:position animated:YES];

        }
            break;
        case 11:
        {
            CGPoint position = CGPointMake(SCREEN_WIDTH, 0);
            [_scrollView setContentOffset:position animated:YES];

        }
            break;
        case 12:
        {
            CGPoint position = CGPointMake(SCREEN_WIDTH*2, 0);
            [_scrollView setContentOffset:position animated:YES];

        }
            break;
        default:
            break;
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

    if(scrollView.contentOffset.x == SCREEN_WIDTH*2){
        UIButton *button = (UIButton *)[self.view viewWithTag:12];
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
