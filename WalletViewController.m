//
//  WalletViewController.m
//  CarSource
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 apple. All rights reserved.
//
//钱包
#import "WalletViewController.h"
#import "WalletView.h"
#import "TopupViewController.h"
#import "WithdrawalViewController.h"
#import "TiedCardViewController.h"
#import "PromoteViewController.h"
#import "PasswordViewController.h"

@interface WalletViewController ()

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"钱包";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    [self initScrollView];

}
- (void)initScrollView{

    WalletView *wallet = [[WalletView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:wallet];

    wallet.wallet = ^(NSInteger wallet){

        switch (wallet) {
            case 1:
            {
                TopupViewController *topup = [[TopupViewController alloc]init];
                [self.navigationController pushViewController:topup animated:YES];

            }
                break;
            case 2:
            {
                WithdrawalViewController *withdrawal = [[WithdrawalViewController alloc]init];
                [self.navigationController pushViewController:withdrawal animated:YES];

            }
                break;
//            case 3:
//            {
//                TiedCardViewController *tiedCard = [[TiedCardViewController alloc]init];
//                [self.navigationController pushViewController:tiedCard animated:YES];
//
//            }
//                break;
//            case 4:
//            {
//                PromoteViewController *promote = [[PromoteViewController alloc]init];
//                [self.navigationController pushViewController:promote animated:YES];
//
//            }
//                break;

            default:
                break;
        }

    };
    wallet.set = ^(NSString *set){
        PasswordViewController *password = [[PasswordViewController alloc]init];
        [self.navigationController pushViewController:password animated:YES];

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
