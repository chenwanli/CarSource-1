//
//  MemberViewController.m
//  CarSource
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MemberViewController.h"
#import "MemberView.h"
#import "ViewController.h"

@interface MemberViewController ()

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[UIDevice currentDevice] systemVersion].floatValue>=7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    NSLog(@"%@ ---   %@   --  %@" ,self.tel ,self.code,self.password);

    MemberView *member = [[MemberView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:member];
    member.returnBtn = ^(NSString *str){
        [self.navigationController popViewControllerAnimated:YES];
    };

    member.submit = ^(NSString *string){
        [LCCoolHUD showLoading:@"正在提交" inView:self.view];
        [RequestClass postRegisteredRequestWithTel:self.tel type:string password:self.password code:self.code Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
            [LCCoolHUD hideInView:self.view];
            if ([errorMessage isEqualToString:@"0"]) {

                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
            }

        }];

    };

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [LCCoolHUD hideInView:self.view];
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
