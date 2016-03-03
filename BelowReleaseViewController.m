//
//  BelowReleaseViewController.m
//  CarSource
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 apple. All rights reserved.
//
//展车发布
#import "BelowReleaseViewController.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
#import "BelowReleaseView.h"
#import "ChooseBrandViewController.h"
#import "InteriorColorViewController.h"

@interface BelowReleaseViewController ()
@property (nonatomic,strong)BelowReleaseView *releaseView;
@property (nonatomic,strong)NSMutableArray *belowArray;
@end

@implementation BelowReleaseViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"展车发布";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    self.belowArray = [[NSMutableArray alloc]init];

    self.releaseView = [[BelowReleaseView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64)];
    [self.view addSubview:self.releaseView];
    __weak typeof(self) weakSelf = self;


//    车型颜色
    self.releaseView.colorButton = ^(NSString *colorButton){

        InteriorColorViewController *interior = [[InteriorColorViewController alloc]init];
        [weakSelf.navigationController pushViewController:interior animated:YES];
        interior.interiorColor = ^(NSString *appearance, NSString *interiorColor,NSString *appearanceId, NSString *interiorColorId){

            [weakSelf.releaseView appearance:appearance interiorColor:interiorColor appearanceId:appearanceId interiorColorId:interiorColorId];

        };

    };

//    车型选择
    self.releaseView.typeBtn = ^(NSString *typeBtn){

        ChooseBrandViewController *brand = [[ChooseBrandViewController alloc]init];
        brand.navCount = 2;
        brand.isChoose = YES;
        brand.isExhibition = YES;
        [weakSelf.navigationController pushViewController:brand animated:YES];
        brand.exhibition = ^(NSString *carSeriesTypeName,NSString *carSeriesTypeId,NSString *specificationId ,NSString *specifications){
            [weakSelf.releaseView initCarSeriesTypeName:carSeriesTypeName carSeriesTypeId:carSeriesTypeId specificationId:specificationId specifications:specifications];
        };



    };

// 添加图片
    self.releaseView.addImage = ^(NSString *addImage){
        [weakSelf selectPhotos];

    };

//    取消删除
    self.releaseView.canceldelete = ^(NSString *canceldelete){

        [weakSelf.releaseView initAddImageArray:weakSelf.belowArray];
    };

//    删除图片
    self.releaseView.deleteImage = ^(NSInteger deleteImage){

        [weakSelf.belowArray removeObjectAtIndex:deleteImage];
        [weakSelf.releaseView initAddImageArray:weakSelf.belowArray];

    };
// 查看大图
    self.releaseView.toViewImage = ^(NSInteger toViewImage){

        MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
        browserVc.currentPage = toViewImage;
        browserVc.photos = weakSelf.belowArray;
        weakSelf.navigationController.navigationBarHidden = NO;
        [weakSelf.navigationController pushViewController:browserVc animated:YES];
    };

    self.releaseView.submit = ^(NSString *string){
        weakSelf.belowRelease(nil);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };

}

#pragma mark - 选择相册
- (void)selectPhotos {
    // 创建控制器
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.status = PickerViewShowStatusCameraRoll;

    if (self.belowArray.count == 0) {
        pickerVc.maxCount = 9;
    }else{
        pickerVc.maxCount = 9 - self.belowArray.count;
    }

    [pickerVc showPickerVc:self];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets){

        [weakSelf.belowArray addObjectsFromArray:assets];
        [self.releaseView initAddImageArray:weakSelf.belowArray];
    };
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
