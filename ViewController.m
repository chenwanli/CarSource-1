//
//  ViewController.m
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "ResourcesViewController.h"
#import "MessageViewController.h"
#import "MyProfileViewController.h"
#import "PKResultsViewController.h"
#import "UserCenterViewController.h"
#import "ModelsViewController.h"
#import "CarPicturesViewController.h"
#import "ProvincesViewController.h"
#import "ContrastViewController.h"
#import "MyEntrustViewController.h"
#import "NextViewController.h"
#import "GuaranteeViewController.h"
#import "OptionsViewController.h"
#import "ExhibitionViewController.h"
#import "WalletViewController.h"
#import "SetUpViewController.h"
#import "HomeViewController.h"
#import "MoveViewController.h"
#import "ReleaseSalesViewController.h"
#import "LookingForViewController.h"
#import "TradingViewController.h"
#import "ChooseBrandViewController.h"
#import "MemberTypeViewController.h"
#import "SelectAreaViewController.h"
#import "ServiceViewController.h"
#import "PersonalViewController.h"
#import "ImageViewController.h"
#import "SalesDetailsViewController.h"
#import "SearchViewController.h"

@interface ViewController (){
    UIView *_contentView;
    UIView *_tabBar;
    NSArray *_viewControllers;
    UIButton *btn;
    NSMutableArray *_roomArray;

}
@property (nonatomic,strong)ResourcesViewController *mall ;
@end

@implementation ViewController
//- (void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBarHidden = YES;
//}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
    _roomArray = [[NSMutableArray alloc]init];
    self.navigationController.navigationBarHidden = YES;

    [self initTabBar];
//    [[SkinManager sharedSkinManager]addObserver:self forKeyPath:@"countTest" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    if (IOS8) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
    }else{
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]];
    }
    
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    NSInteger count = [[change objectForKey:@"new"] integerValue];
//    switch (count) {
//        case 1:
//        {
//            UserCenterViewController *user = [[UserCenterViewController alloc]init];
//            [self.navigationController pushViewController:user animated: YES];
//
//        }
//            break;
//        case 2:
//        {
//            CarPicturesViewController *pictures = [[CarPicturesViewController alloc]init];
//            [self.navigationController pushViewController:pictures animated: YES];
//
//        }
//            break;
//
//        default:
//            break;
//    }
//
//}

- (void)initTabBar{
    __weak ViewController *VC = self;
    //  首页
//    HomeViewController *home = [[HomeViewController alloc]init];
//    home.homeIndex = ^(NSInteger home ,NSMutableArray *contentViews){
//        NSArray *titles = @[@"汽车图片",@"车型对比",@"拖车服务"];
////        NSLog(@"-----第一个controll －－－ %ld   %@",home,contentViews);
//
//        ContentModel *model = [[ContentModel alloc] init];
//        model.titleArray = titles;
////        model.contentViews = contentViews;
//        MoveViewController *move = [MoveViewController new];
//        move.selectNum = home;
//        move.content = model;
//        move.isSelectImage = YES;
//        move.imageHeight = 42;
//        // *************** 以下是可选设置
//        move.normalColor = [UIColor grayColor];
//        move.titleSelectColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];;
//        move.titleFont = [UIFont systemFontOfSize:16];
//
//        [self.navigationController pushViewController:move animated:YES];
//        move = nil;
//        model = nil;
//
//
//    };
//
//    home.pkResults = ^(NSString *pkResults){
//
//        PKResultsViewController *pk = [[PKResultsViewController alloc]init];
//        [self.navigationController pushViewController:pk animated: YES];
//
//    };
//
//    home.promotionUrl = ^(NSInteger promotionUrl,NSMutableArray *array){
//        //展厅
//        ExhibitionViewController *exhibition = [[ExhibitionViewController alloc]init];
//        exhibition.promotionId = [array objectAtIndex:promotionUrl];
//        exhibition.isAop = NO;
//        [self.navigationController pushViewController:exhibition animated: YES];
//
//    };

    //  资源
    self.mall = [[ResourcesViewController alloc]init];
    self.mall.releaseTag = ^(NSInteger releaseTag){

        if (releaseTag == 1) {
//            发布销售
            ReleaseSalesViewController *sales = [[ReleaseSalesViewController alloc]init];
            [VC.navigationController pushViewController:sales animated: YES];

            sales.submitBtn = ^(NSInteger submitStr){
                [VC.mall initReleaseSalesViewControllerCount:submitStr];
            };

        }else{
//            发布求购
            LookingForViewController *lookingFor = [[LookingForViewController alloc]init];
            [VC.navigationController pushViewController:lookingFor animated: YES];
            lookingFor.looking = ^(NSString *str){
                [VC.mall areLookingView];
            };
        }

    };


    self.mall.guarantee = ^(NSString *guarantee){

        TradingViewController *trading = [[TradingViewController alloc]init];
        [VC.navigationController pushViewController:trading animated: YES];

    };

    self.mall.brandTag = ^(NSInteger brandTag){

        switch (brandTag) {
            case 10:
            {
                ChooseBrandViewController *chooseBrand = [[ChooseBrandViewController alloc]init];
                 chooseBrand.chooseBrand = 12;
                [VC.navigationController pushViewController:chooseBrand animated: YES];
                chooseBrand.vehicleId = ^(NSString *vehicleId,NSString *vehicleName,NSString *specificationId,NSString *specifications){
                    [VC.mall initVehicleId:vehicleId vehicleName:vehicleName specificationId:specificationId isAop:YES];
                };

            }
                break;
            case 11:
            {

                MemberTypeViewController *memberType = [[MemberTypeViewController alloc]init];
                [VC.navigationController pushViewController:memberType animated: YES];
                memberType.memberType = ^(NSString *memberType,NSString *memberTypeId){
                    [VC.mall initMemberType:memberType memberTypeId:memberTypeId];
                };
            }
                break;
            case 12:
            {
                SelectAreaViewController *selectArea = [[SelectAreaViewController alloc]init];
                [VC.navigationController pushViewController:selectArea animated: YES];
                selectArea.provinces = ^(NSString *provincesStr,NSString *provincesIdStr,NSString *areaStr){
                    [VC.mall initProvincesStr:provincesStr provincesIdStr:provincesIdStr areaStr:areaStr isAop:YES];
                };
            }
                break;

            default:
                break;
        }

    };

    self.mall.brand = ^(NSInteger brand){

        if (brand == 0) {
            ChooseBrandViewController *chooseBrand = [[ChooseBrandViewController alloc]init];
            chooseBrand.chooseBrand = 12;
            [VC.navigationController pushViewController:chooseBrand animated: YES];
            chooseBrand.vehicleId = ^(NSString *vehicleId,NSString *vehicleName,NSString *specificationId,NSString *specifications){
                [VC.mall initVehicleId:vehicleId vehicleName:vehicleName specificationId:specificationId isAop:NO];
            };

        }else{
            SelectAreaViewController *selectArea = [[SelectAreaViewController alloc]init];
            [VC.navigationController pushViewController:selectArea animated: YES];
             selectArea.provinces = ^(NSString *provincesStr,NSString *provincesIdStr,NSString *areaStr){
                [VC.mall initProvincesStr:provincesStr provincesIdStr:provincesIdStr areaStr:areaStr isAop:NO];
            };
        }

    };

    self.mall.imageUrlArray = ^(NSMutableArray *array,NSInteger imageCount){
//        查看大图
        ImageViewController *imageView = [[ImageViewController alloc]init];
        imageView.imageArray = array;
        imageView.index = imageCount;
        [VC.navigationController pushViewController:imageView animated:YES];
    };
    //搜索
    self.mall.search = ^(NSString *str){

        SearchViewController *search = [[SearchViewController alloc]init];
        [VC.navigationController pushViewController:search animated: YES];
        search.searchView = ^(NSString *nameStr,NSString *string){
            [VC.mall searchName:nameStr string:string];
        };
    };

//    车源详情
    self.mall.details = ^(NSMutableArray *array){

        SalesDetailsViewController *salesDetails = [[SalesDetailsViewController alloc]init];
        salesDetails.salesArray = array;
        [VC.navigationController pushViewController:salesDetails animated: YES];
    };


    //  消息
    MessageViewController *community = [[MessageViewController alloc]init];
    community.nextArray = ^(NSMutableArray *next,UIViewController *viewController){
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:viewController animated: YES];
    };
    
    
    //  我的
    MyProfileViewController *myProfile = [[MyProfileViewController alloc]init];

    myProfile.nextArray = ^(NSMutableArray *next){

        PersonalViewController *personal = [[PersonalViewController alloc]init];
        personal.dataArray = next;
        [self.navigationController pushViewController:personal animated: YES];

//        NextViewController *nextView = [[NextViewController alloc]init];
//        [self.navigationController pushViewController:nextView animated: YES];
    };

    myProfile.btnTag = ^(NSInteger btnTag){

        if (btnTag == 1) {
            //我的车源
            OptionsViewController *options = [[OptionsViewController alloc]init];
            [self.navigationController pushViewController:options animated: YES];
        }else if (btnTag == 2){
            //我的担保
            GuaranteeViewController *options = [[GuaranteeViewController alloc]init];
            [self.navigationController pushViewController:options animated: YES];

        }else{

            //我的定金
            MyEntrustViewController *myEntrust = [[MyEntrustViewController alloc]init];
            [self.navigationController pushViewController:myEntrust animated: YES];
            
        }

    };

    myProfile.userBtn = ^(NSString *userBtn){



    };

    myProfile.loginBtn = ^(NSString *profile){

       
    };


    myProfile.row = ^(NSInteger row,BOOL isProfile){

        switch (row) {
            case 1:
            {
                //展厅
                ExhibitionViewController *exhibition = [[ExhibitionViewController alloc]init];
                exhibition.isAop = YES;
                [self.navigationController pushViewController:exhibition animated: YES];

            }
                break;
            case 2:
            {
                //钱包
                WalletViewController *wallet = [[WalletViewController alloc]init];
                [self.navigationController pushViewController:wallet animated:YES];
            }
                break;
            case 3:
            {
                //服务
                ServiceViewController *service = [[ServiceViewController alloc]init];
                [self.navigationController pushViewController:service animated:YES];
            }
                break;
            case 4:
            {
                //设置
                SetUpViewController *setup = [[SetUpViewController alloc]init];
                [self.navigationController pushViewController:setup animated:YES];
            }
                break;


            default:
                break;
        }
    };

    _viewControllers = [[NSArray alloc]initWithObjects:self.mall,community,myProfile, nil];
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    [self.view addSubview:_contentView];
    _tabBar=[[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT -49, SCREEN_WIDTH, 49)];
    _tabBar.backgroundColor =  [UIColor whiteColor];
    [self.view addSubview:_tabBar];
    NSInteger count = [_viewControllers count];
//     NSArray *tabBarArray = @[@"首页",@"资源",@"消息",@"我的"];
    for (int i = 0; i < count; i++)
    {
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((SCREEN_WIDTH/3)*i +((SCREEN_WIDTH/3)/2-20), 2, 40 , 45);
        button.tag = i;
//        button.adjustsImageWhenHighlighted = NO;

//        [button setTitle:[tabBarArray objectAtIndex:i] forState:UIControlStateNormal];
//       [button setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"flat%d",i+2]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"sky%d",i+2]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBar addSubview:button];

        if (i == 0)
        {
            [self tabBarButtonClick:button];
        }
    }
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [_tabBar addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_tabBar).offset(-48);
        make.right.equalTo(_tabBar).offset(@0);
        make.left.equalTo(@0);
        make.height.equalTo(@1);
    }];

}
- (void)tabBarButtonClick:(UIButton *)button
{
    btn.selected = NO;
    button.selected = YES;
    btn = button;
    UIViewController *vc = _viewControllers[button.tag];
    if ([_contentView.subviews containsObject:vc.view])
    {
        [_contentView bringSubviewToFront:vc.view];
    }
    else
    {
        [_contentView addSubview:vc.view];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
