//
//  CarPicturesViewController.m
//  CarSource
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarPicturesViewController.h"

@interface CarPicturesViewController ()

@end

@implementation CarPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    returnBtn.frame = CGRectMake(20, 20, 60, 40);
    //    returnBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [returnBtn setTitle:@"返回" forState:UIControlStateNormal];
    returnBtn.titleLabel.font = [UIFont systemFontOfSize: 18.0];
    [returnBtn addTarget:self action:@selector(returnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
}
- (void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
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
