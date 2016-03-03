//
//  ScreenshotsViewController.m
//  CarSource
//
//  Created by apple on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ScreenshotsViewController.h"

@interface ScreenshotsViewController ()

@end

@implementation ScreenshotsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"截图";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    //    scrollView.delegate = self;
    // 设置内容大小

    // 是否反弹
    scrollView.bounces = NO;
    scrollView.scrollEnabled = YES;
    scrollView.backgroundColor = GRAY;
    scrollView.showsHorizontalScrollIndicator = NO;
    //        _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:scrollView];


    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 900)];
    imageView.image = self.screenshotsImage;
    [scrollView addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.screenshotsImage.size.height);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.screenshotsImage.size.height);


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
