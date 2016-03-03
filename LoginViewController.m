//
//  LoginViewController.m
//  CarSource
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegisteredViewController.h"
#import "ForgotPasswordViewController.h"
#import "ViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    LoginView *login = [[LoginView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:login];
    login.submitBtn = ^(NSString *nameText,NSString *password){
        [LCCoolHUD showLoading:@"正在登录" inView:self.view];
        [RequestClass postLoginRequestWithTel:nameText password:password Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
            
            //            容联
            ECLoginInfo * loginInfo = [[ECLoginInfo alloc] init];
            loginInfo.username = nameText;
            loginInfo.userPassword = @"";
            loginInfo.appKey = [DemoGlobalClass sharedInstance].appKey;
            loginInfo.appToken = [DemoGlobalClass sharedInstance].appToken;
            loginInfo.authType = [DemoGlobalClass sharedInstance].loginAuthType;
            loginInfo.mode = LoginMode_InputPassword;
            [DemoGlobalClass sharedInstance].userPassword = @"";
            [[DeviceDBHelper sharedInstance] openDataBasePath:nameText];
            [DemoGlobalClass sharedInstance].isHiddenLoginError = NO;
            [[ECDevice sharedInstance] login:loginInfo completion:^(ECError *error){
                
                
                [LCCoolHUD hideInView:self.view];
                if ([errorMessage isEqualToString:@"0"]) {
                    
                    NSLog(@"%@",saleArray);
                    [Serialization initSerializationArray:saleArray];
                    NSLog(@"Serialization %@",[Serialization initNSKeyedUnarchiver]);
                    //                        ViewController *VC = [[ViewController alloc]init];
                    //                        [self.navigationController pushViewController:VC animated:YES];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onConnected object:error];
                    if (error.errorCode == ECErrorType_NoError) {
                        [DemoGlobalClass sharedInstance].userName = nameText;
                    }
                    
                }
            }];
        }];
    };
    login.registered = ^(NSString *registered){
        RegisteredViewController *registeredView = [[RegisteredViewController alloc]init];
        [self.navigationController pushViewController:registeredView animated:YES];
    };

    login.returnBtn = ^(NSString *str){
        [self.navigationController popViewControllerAnimated:YES];
    };

    login.password = ^(NSString *password){

        ForgotPasswordViewController *forgot = [[ForgotPasswordViewController alloc]init];
        [self.navigationController pushViewController:forgot animated:YES];


    };
    
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [LCCoolHUD hideInView:self.view];
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
