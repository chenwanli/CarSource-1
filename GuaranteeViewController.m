//
//  GuaranteeViewController.m
//  CarSource
//
//  Created by apple on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//
//我的担保
#import "GuaranteeViewController.h"
#import "OtherGuaranteeView.h"
#import "MyGuaranteeView.h"
#import "PayViewController.h"
#import "ArefundViewController.h"
#import "ImageViewController.h"

@interface GuaranteeViewController ()<UIScrollViewDelegate>{
    UIButton *_btn;
    UIScrollView *_scrollView;
    UIButton *_otherButton;
    UIButton *_myGuaranteeBtn;
}

@end

@implementation GuaranteeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"我的担保";
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

    OtherGuaranteeView *other = [[OtherGuaranteeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _scrollView.frame.size.height)];
//    other.backgroundColor = [UIColor blueColor];
    [_scrollView addSubview:other];

    other.payRefund = ^(NSInteger pay){
        if (pay == 1) {
            PayViewController *payView = [[PayViewController alloc]init];
            [self.navigationController pushViewController:payView animated:YES];
        }else{
            ArefundViewController *arefund = [[ArefundViewController alloc]init];
            [self.navigationController pushViewController:arefund animated:YES];

        }

    };

    other.credentials = ^(NSMutableArray *array){

        ImageViewController *imageView = [[ImageViewController alloc]init];
        imageView.imageArray = array;
        imageView.index = 0;
        [self.navigationController pushViewController:imageView animated:YES];
    };

    MyGuaranteeView *myyGuarantee = [[MyGuaranteeView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _scrollView.frame.size.height)];
//    myyGuarantee.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:myyGuarantee];

    myyGuarantee.payRefund = ^(NSInteger pay){
        if (pay == 1) {
            PayViewController *payView = [[PayViewController alloc]init];
            [self.navigationController pushViewController:payView animated:YES];
        }else{
            ArefundViewController *arefund = [[ArefundViewController alloc]init];
            [self.navigationController pushViewController:arefund animated:YES];
        }

    };

    myyGuarantee.credentials = ^(NSMutableArray *array){

        ImageViewController *imageView = [[ImageViewController alloc]init];
        imageView.imageArray = array;
        imageView.index = 0;
        [self.navigationController pushViewController:imageView animated:YES];
    };
    

    _otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _otherButton.frame = CGRectMake(SCREEN_WIDTH/2*0, 64, SCREEN_WIDTH/2, 49);
    [_otherButton setTitle:@"对方担保" forState:UIControlStateNormal];
    [_otherButton setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateNormal];
    _otherButton.tag = 1;
    [_otherButton addTarget:self action:@selector(otherButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_otherButton];

    _myGuaranteeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _myGuaranteeBtn.frame = CGRectMake(SCREEN_WIDTH/2*1, 64, SCREEN_WIDTH/2, 49);
    [_myGuaranteeBtn setTitle:@"我的担保" forState:UIControlStateNormal];
    [_myGuaranteeBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    _myGuaranteeBtn.tag = 2;
    [_myGuaranteeBtn addTarget:self action:@selector(otherButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_myGuaranteeBtn];


    UIImageView *image  = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 66, 1, 46)];
    image.backgroundColor = [UIColor colorWithRed:175/255.0 green:198/255.0 blue:225/255.0 alpha:1];
    [self.view addSubview:image];
    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 113, SCREEN_WIDTH, 1)];
    lineImage.backgroundColor = [UIColor colorWithRed:215/255.0 green:234/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:lineImage];



}
- (void)otherButtonClick:(UIButton *)button{
    if (button.tag == 1) {

        [_otherButton setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateNormal];

        [_myGuaranteeBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        CGPoint position = CGPointMake(0, 0);

        [_scrollView setContentOffset:position animated:YES];
    }else{
        [_otherButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        [_myGuaranteeBtn setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateNormal];

        CGPoint position = CGPointMake(SCREEN_WIDTH, 0);

        [_scrollView setContentOffset:position animated:YES];
    }
}
// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"scrollViewDidScroll  %f",scrollView.contentOffset.x );

    if (scrollView.contentOffset.x == SCREEN_WIDTH) {

        [_otherButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        [_myGuaranteeBtn setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateNormal];

    }else{
        
        [_otherButton setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateNormal];
        [_myGuaranteeBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        
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
