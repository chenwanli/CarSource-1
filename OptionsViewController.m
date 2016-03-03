//
//  OptionsViewController.m
//  CarSource
//
//  Created by apple on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//
//我的车源
#import "OptionsViewController.h"
#import "SalesOptionsView.h"
#import "LookingOptionsView.h"
#import "ImageViewController.h"

@interface OptionsViewController ()<UIScrollViewDelegate>{
    UIButton *_btn;
    UIScrollView *_scrollView;
    UIButton *_salesButton;
    UIButton *_lookingButton;
    LookingOptionsView *_looking;
}

@end

@implementation OptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"我的车源";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    [self initButton];

}
- (void)initButton{

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT - 114)];
    // 是否支持滑动最顶端
    //    scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    // 设置内容大小
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2,SCREEN_HEIGHT - 114);
    // 是否反弹
        _scrollView.bounces = NO;
    // 是否分页
        _scrollView.pagingEnabled = YES;
    // 是否滚动
    //    scrollView.scrollEnabled = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    // 设置indicator风格
//        scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    // 设置内容的边缘和Indicators边缘
    //    scrollView.contentInset = UIEdgeInsetsMake(0, 50, 50, 0);
    //    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    // 提示用户,Indicators flash
//    [scrollView flashScrollIndicators];
    _scrollView.scrollEnabled = NO;
    // 是否同时运动,lock
    _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:_scrollView];

    SalesOptionsView *sales = [[SalesOptionsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _scrollView.frame.size.height)];
//    sales.backgroundColor = [UIColor blueColor];
    [_scrollView addSubview:sales];

    _looking = [[LookingOptionsView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _scrollView.frame.size.height)];
//    looking.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_looking];

    sales.salesImage = ^(NSMutableArray *array,NSInteger count){

        //        查看大图
        ImageViewController *imageView = [[ImageViewController alloc]init];
        imageView.imageArray = array;
        imageView.index = count;
        [self.navigationController pushViewController:imageView animated:YES];

    };


    _salesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _salesButton.frame = CGRectMake(SCREEN_WIDTH/2*0, 64, SCREEN_WIDTH/2, 49);
    [_salesButton setTitle:@"销售车源" forState:UIControlStateNormal];
    [_salesButton setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateNormal];
    _salesButton.tag = 1;
    [_salesButton addTarget:self action:@selector(guaranteeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_salesButton];

    _lookingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _lookingButton.frame = CGRectMake(SCREEN_WIDTH/2*1, 64, SCREEN_WIDTH/2, 49);
    [_lookingButton setTitle:@"求购车源" forState:UIControlStateNormal];
    [_lookingButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    _lookingButton.tag = 2;
    [_lookingButton addTarget:self action:@selector(guaranteeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lookingButton];


    UIImageView *image  = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 66, 1, 46)];
    image.backgroundColor = [UIColor colorWithRed:175/255.0 green:198/255.0 blue:225/255.0 alpha:1];
    [self.view addSubview:image];
    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 113, SCREEN_WIDTH, 1)];
    lineImage.backgroundColor = [UIColor colorWithRed:215/255.0 green:234/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:lineImage];



}
- (void)guaranteeButtonClick:(UIButton *)button{
    if (button.tag == 1) {

          [_salesButton setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateNormal];

          [_lookingButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        CGPoint position = CGPointMake(0, 0);

        [_scrollView setContentOffset:position animated:YES];
    }else{
        [_salesButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        [_lookingButton setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateNormal];

        CGPoint position = CGPointMake(SCREEN_WIDTH, 0);

        [_scrollView setContentOffset:position animated:YES];
        [_looking installationMJRefresh];
    }
}
// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewDidScroll  %f",scrollView.contentOffset.x );

    if (scrollView.contentOffset.x == SCREEN_WIDTH) {
        [_salesButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        [_lookingButton setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateNormal];

    }else{
        [_salesButton setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateNormal];

        [_lookingButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        
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
