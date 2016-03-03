//
//  RegisteredViewController.m
//  CarSource
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisteredViewController.h"
#import "RegisteredView.h"
#import "MemberViewController.h"

@interface RegisteredViewController ()

@end

@implementation RegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    RegisteredView *registered = [[RegisteredView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:registered];
    registered.submit = ^(NSString *tel,NSString *code,NSString *password){

        MemberViewController *member = [[MemberViewController alloc]init];
        member.tel = tel;
        member.code = code;
        member.password = password;
        [self.navigationController pushViewController:member animated:YES];

    };

    registered.returnBtn = ^(NSString *returnBtn){
        [self.navigationController popViewControllerAnimated:YES];
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
