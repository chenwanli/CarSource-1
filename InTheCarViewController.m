//
//  InTheCarViewController.m
//  CarSource
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 apple. All rights reserved.
//
//交车发布
#import "InTheCarViewController.h"
#import "InTheCarView.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
#import "ChooseBrandViewController.h"

@interface InTheCarViewController ()<UIScrollViewDelegate>{
    UIButton *_typeButton;

}
@property (nonatomic,strong)InTheCarView *carView;
@property (nonatomic,strong)NSMutableArray *carArray;
@end

@implementation InTheCarViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"交车发布";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    self.carArray = [[NSMutableArray alloc]init];

    self.carView = [[InTheCarView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64)];
    [self.view addSubview:self.carView];

     __weak typeof(self) weakSelf = self;
    self.carView.addImage = ^(NSString *addImage){
        [weakSelf selectPhotos];

    };
    self.carView.canceldelete = ^(NSString *canceldelete){

        [weakSelf.carView initAddImageArray:weakSelf.carArray];
    };

    self.carView.deleteImage = ^(NSInteger deleteImage){

        [weakSelf.carArray removeObjectAtIndex:deleteImage];
        [weakSelf.carView initAddImageArray:weakSelf.carArray];

    };

    self.carView.toViewImage = ^(NSInteger toViewImage){

        MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
        browserVc.currentPage = toViewImage;
        browserVc.photos = weakSelf.carArray;
        weakSelf.navigationController.navigationBarHidden = NO;
        [weakSelf.navigationController pushViewController:browserVc animated:YES];
    };

    self.carView.typeBtn = ^(NSString *str){

        ChooseBrandViewController *brand = [[ChooseBrandViewController alloc]init];
        brand.navCount = 2;
        brand.isChoose = YES;
        brand.isExhibition = YES;
        [weakSelf.navigationController pushViewController:brand animated:YES];

        brand.exhibition = ^(NSString *carSeriesTypeName,NSString *carSeriesTypeId,NSString *specificationId ,NSString *specifications){
            [weakSelf.carView initCarSeriesTypeName:carSeriesTypeName carSeriesTypeId:carSeriesTypeId promotionId:weakSelf.showroomId specificationId:specificationId specifications:specifications  ];
        };


    };
    self.carView.submit = ^(NSString *string){
        weakSelf.inTheCar(nil);
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

        if (self.carArray.count == 0) {
            pickerVc.maxCount = 9;
        }else{
            pickerVc.maxCount = 9 - self.carArray.count;
        }

    [pickerVc showPickerVc:self];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets){

            [weakSelf.carArray addObjectsFromArray:assets];
            [self.carView initAddImageArray:weakSelf.carArray];
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
