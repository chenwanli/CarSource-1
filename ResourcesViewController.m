//
//  ResourcesViewController.m
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ResourcesViewController.h"
#import "SalesView.h"
#import "AreLookingView.h"


@interface ResourcesViewController ()<UIScrollViewDelegate>{
    UIButton *_salesBtn;
    UIButton *_lookingBtn;
    UIScrollView *_scrollView;
    NSInteger _integer;
    SalesView *_sales;
    AreLookingView *_looking;
    NSInteger _salesCount;
    NSInteger _lookingCount;
    UIView *_bouncedView;
    UIButton *_releaseBtn;


}

@end

@implementation ResourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//     self.view.backgroundColor = [UIColor redColor];
    _salesCount = 1;
    _lookingCount = 1;
    _integer = 1;
    [self initResourcesViewTitle];
    [self initButton];
    [self bouncedView];

}
- (void)bouncedView{
     _bouncedView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 64, 90, 80)];
    _bouncedView.alpha = 0;
    [self.view addSubview:_bouncedView];
    _bouncedView.hidden = YES;


    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 90, 80)];
    bgView.image = [UIImage imageNamed:@"bounced"];
    [_bouncedView addSubview:bgView];

    NSArray *array = [[NSArray alloc]initWithObjects:@"发布资源",@"发布求购", nil];
    for (int i = 0; i < array.count; i++) {

        UIButton *releaseBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        releaseBtn.frame = CGRectMake(10, 40 *i+10, 70, 30);

        [releaseBtn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        releaseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [releaseBtn addTarget:self action:@selector(releaseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        releaseBtn.tag = i +1;
        [_bouncedView addSubview:releaseBtn];

        if (i == 1) {
            UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40 *i +5, 70, 1)];
            lineImage.backgroundColor = [UIColor whiteColor];
            [_bouncedView addSubview:lineImage];
        }

    }



}
- (void)releaseBtnClick:(UIButton *)button{
    [UIView animateWithDuration:0.5 animations:^{
        _bouncedView.alpha = 0;
        _bouncedView.hidden = YES;

    }];
    _releaseBtn.selected = NO;
    
    self.releaseTag(button.tag);

}

- (void)initResourcesViewTitle{

    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    titleView.backgroundColor = COLOR;
    [self.view addSubview:titleView];

    UIButton *guaranteeBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    guaranteeBtn.frame = CGRectMake(10, 20, 70, 40);
    [guaranteeBtn setTitle:@"交易担保" forState:UIControlStateNormal];
    guaranteeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [guaranteeBtn addTarget:self action:@selector(guaranteeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:guaranteeBtn];


    _salesBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    _salesBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 65, 20, 60, 40);
    [_salesBtn setTitle:@"销售" forState:UIControlStateNormal];
    _salesBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _salesBtn.tag = 100;
    [_salesBtn addTarget:self action:@selector(salesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_salesBtn];

    _lookingBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    _lookingBtn.frame = CGRectMake(SCREEN_WIDTH/2 +5, 20, 60, 40);
    [_lookingBtn setTitle:@"求购" forState:UIControlStateNormal];
    [_lookingBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    _lookingBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _lookingBtn.tag = 101;
    [_lookingBtn addTarget:self action:@selector(salesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lookingBtn];

    UIImageView *releaseImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, 30, 5, 25)];
    releaseImage.image = [UIImage imageNamed:@"release"];
    [self.view addSubview:releaseImage];

    _releaseBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    _releaseBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 20, 50, 40);
//    [_releaseBtn setTitle:@"发布" forState:UIControlStateNormal];
//    [_releaseBtn setImage:[UIImage imageNamed:@"release"] forState:UIControlStateNormal];
    _releaseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_releaseBtn addTarget:self action:@selector(releaseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_releaseBtn];

    for (int i = 0; i < 2; i++) {
        UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 65, 60, 60, 4)];
        bgImage.tag = 20 +i;
        bgImage.alpha = 0.3;
        [self.view addSubview:bgImage];
        if (i == 1) {
            UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 22, 1, 36)];
            lineImage.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:lineImage];

            bgImage.frame = CGRectMake(SCREEN_WIDTH/2 +5, 60, 60, 4);

        }else{
            bgImage.backgroundColor = GRAY;
        }
    }

}
- (void)initButton{

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 109)];
    // 是否支持滑动最顶端
    //    scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    // 设置内容大小
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2,SCREEN_HEIGHT - 109);
    // 是否反弹
    _scrollView.bounces = NO;
    // 是否分页
    _scrollView.pagingEnabled = YES;
    // 是否滚动
    //    scrollView.scrollEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:_scrollView];


    _sales = [[SalesView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _scrollView.frame.size.height)];
//    sales.backgroundColor = [UIColor blueColor];
    [_scrollView addSubview:_sales];
    __weak ResourcesViewController *resourcesView = self;
    _sales.brandTag = ^(NSInteger brandTag){
        resourcesView.brandTag(brandTag);
    };
    _sales.imageUrlArr = ^(NSMutableArray *array, NSInteger imageCount){
        resourcesView.imageUrlArray(array,imageCount);
    };
    _sales.searchStr = ^(NSString *str){
        resourcesView.search(str);
    };
    _sales.details = ^(NSMutableArray *array){
        resourcesView.details(array);
    };


    _looking = [[AreLookingView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _scrollView.frame.size.height)];
//    looking.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_looking];

    _looking.brandTag = ^(NSInteger brand){

        resourcesView.brand(brand);

    };

}
//搜索
- (void)searchName:(NSString *)name string:(NSString *)string{
    [_sales searchName:name string:string];
}

- (void)initReleaseSalesViewControllerCount:(NSInteger)count{

    [_sales initReleaseSalesViewControllerCount:count];
}
- (void)areLookingView{
    [_looking areLookingView];
}
- (void)initProvincesStr:(NSString *)provincesStr provincesIdStr:(NSString *)provincesIdStr areaStr:(NSString *)areaStr isAop:(BOOL)isAop{

    if (isAop == YES) {
        [_sales provincesStr:provincesStr provincesIdStr:provincesIdStr areaStr:areaStr];
    }else{
        [_looking provincesStr:provincesStr provincesIdStr:provincesIdStr areaStr:areaStr];
    }

}
- (void)initMemberType:(NSString *)memberType memberTypeId:(NSString *)memberTypeId{
    [_sales initMemberType:memberType memberTypeId:memberTypeId];
}
- (void)initVehicleId:(NSString *)vehicleId vehicleName:(NSString *)vehicleName specificationId:(NSString *)specificationId isAop:(BOOL)isAop{
    if (isAop == YES) {
        [_sales initVehicleId:vehicleId vehicleName:vehicleName specificationId:specificationId];
    }else{
        [_looking initVehicleId:vehicleId vehicleName:vehicleName specificationId:specificationId];
    }

}

- (void)releaseButtonClick:(UIButton *)button{

    button.selected = !button.selected;
//    NSLog(@"_integer = %ld",_integer);
    if ( button.selected) {
        _bouncedView.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _bouncedView.alpha = 1;

        }];
    }else{
        _bouncedView.hidden = YES;
        [UIView animateWithDuration:0.5 animations:^{
            _bouncedView.alpha = 0;

        }];
    }



}
- (void)guaranteeButtonClick:(UIButton *)button{

    self.guarantee(nil);

}
- (void)salesButtonClick:(UIButton *)button{

    if (button.tag == 100) {
        _lookingCount = 1;
        _integer = 1;
        [_salesBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [_lookingBtn setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
        CGPoint position = CGPointMake(0, 0);
        [_scrollView setContentOffset:position animated:YES];
        _salesCount ++;
        if (_salesCount == 3) {
            _salesCount = 1;
            [_sales installationMJRefresh];
        }
        UIImageView *image = (UIImageView *)[self.view viewWithTag:20];
        image.backgroundColor = GRAY;
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:21];
        imageView.backgroundColor = [UIColor clearColor];


    }else{
        _integer = 2;
        _salesCount = 1;
        [_salesBtn setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
        [_lookingBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        CGPoint position = CGPointMake(SCREEN_WIDTH, 0);
        [_scrollView setContentOffset:position animated:YES];
        [_looking initinstallationMJRefresh];
        _lookingCount ++;
        if (_lookingCount == 3) {
            _lookingCount = 1;
            [_looking initDefaultMJRefresh];
        }
        UIImageView *image = (UIImageView *)[self.view viewWithTag:20];
        image.backgroundColor = [UIColor clearColor];;
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:21];
        imageView.backgroundColor = GRAY;


    }


}
// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"scrollViewDidScroll  %f",scrollView.contentOffset.x );

    if (scrollView.contentOffset.x == SCREEN_WIDTH) {
        _integer = 2;
        [_looking initinstallationMJRefresh];
        [_salesBtn setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
        [_lookingBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        UIImageView *image = (UIImageView *)[self.view viewWithTag:20];
        image.backgroundColor = [UIColor clearColor];;
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:21];
        imageView.backgroundColor = GRAY;


    }else if(scrollView.contentOffset.x == 0){
        UIImageView *image = (UIImageView *)[self.view viewWithTag:20];
        image.backgroundColor = GRAY;
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:21];
        imageView.backgroundColor = [UIColor clearColor];

        _integer = 1;
        [_salesBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [_lookingBtn setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
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
