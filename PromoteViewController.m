//
//  PromoteViewController.m
//  CarSource
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//
//展厅推广
#import "PromoteViewController.h"
#import "PromoteView.h"

@interface PromoteViewController ()
{
    UIScrollView *_promoteScroll;
}

@end

@implementation PromoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"展厅推广";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _promoteScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
//    _promoteScroll.delegate = self;
    _promoteScroll.bounces = NO;
    _promoteScroll.backgroundColor = GRAY;
    _promoteScroll.contentSize = CGSizeMake(SCREEN_WIDTH, 670);
    //    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_promoteScroll];

    PromoteView *promote = [[PromoteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 670)];
    [_promoteScroll addSubview:promote];
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"1", @"2",nil];

    [promote initPromoteViewArray:array];

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
