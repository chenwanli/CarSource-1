//
//  WithdrawalViewController.m
//  CarSource
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//
// 提现
#import "WithdrawalViewController.h"
#import "WithdrawalView.h"
#import "PasswordBouncedView.h"

@interface WithdrawalViewController ()
@property (nonatomic,strong)WithdrawalView *withdrawal;
@property (nonatomic,strong)PasswordBouncedView *passwordView;
@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"零钱提现";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _withdrawal = [[WithdrawalView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:_withdrawal];
    [_withdrawal initWithdrawalViewArray:nil];

   __weak WithdrawalViewController *withdrawalView = self;

    _withdrawal.submit = ^(NSString *submit){

        [withdrawalView.view endEditing:YES];

        withdrawalView.passwordView = [[PasswordBouncedView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT )];
        [withdrawalView.view addSubview:withdrawalView.passwordView];

        withdrawalView.passwordView.password = ^(NSMutableArray *password){
//            NSLog(@"password = %@",password);
            [withdrawalView.passwordView removeFromSuperview ];

        };


        withdrawalView.passwordView.cancelBtn = ^(NSString *str){
            [withdrawalView.passwordView removeFromSuperview ];
        };


    };

}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [_passwordView removeFromSuperview];
//}
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
