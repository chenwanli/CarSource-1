//
//  AppDelegate.m
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyBoardManager.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import <RongIMKit/RongIMKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "UIImageView+WebCache.h"

//容联
#import "ECDeviceHeaders.h"
#import "DemoGlobalClass.h"
#import "AddressBookManager.h"
#import "CustomEmojiView.h"

#define LOG_OPEN 0


#define RONGCLOUD_IM_APPKEY @"z3v5yqkbv8v30" // online key

#define UMENG_APPKEY @"563755cbe0f55a5cb300139c"

#define iPhone6                                                                \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(750, 1334),                              \
[[UIScreen mainScreen] currentMode].size)           \
: NO)
#define iPhone6Plus                                                            \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(1242, 2208),                             \
[[UIScreen mainScreen] currentMode].size)           \
: NO)

@interface AppDelegate ()
//<RCWKAppInfoProvider>
@property (nonatomic, strong) NSDateFormatter *dataformater;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];

    [[RCIM sharedRCIM] initWithAppKey:@"YourTestAppKey"];

//    ViewController *image = [[ViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:image];
//    self.window.rootViewController = nav;


//    LoginViewController *login = [[LoginViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
//    self.window.rootViewController = nav;

    [IQKeyBoardManager installKeyboardManager];
    
    //    容联
#if !TARGET_IPHONE_SIMULATOR
    self.dataformater = [[NSDateFormatter alloc] init];
    [self.dataformater setDateFormat:@"yyyyMMddHH"];
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        
        UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
        action.title = @"查看消息";
        action.identifier = @"action1";
        action.activationMode = UIUserNotificationActivationModeForeground;
        
        UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
        category.identifier = @"alert";
        [category setActions:@[action] forContext:UIUserNotificationActionContextDefault];
        
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:[NSSet setWithObjects:category, nil]];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else {
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
#endif
    
    [self redirectNSLogToDocumentFolder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectStateChanged:) name:KNOTIFICATION_onConnected object:nil];
    
#warning 设置代理
    [ECDevice sharedInstance].delegate = [DeviceDelegateHelper sharedInstance];
    
    //是否有登录信息
    [DemoGlobalClass sharedInstance].isAutoLogin = [self getLoginInfo];
    if ([DemoGlobalClass sharedInstance].isAutoLogin) {
        LoginViewController *login = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
        self.window.rootViewController = nav;
        //打开本地数据库
        //        [[DeviceDBHelper sharedInstance] openDataBasePath:[DemoGlobalClass sharedInstance].userName];
        //        self.mainView = [[MainViewController alloc] init];
        //        rootView = [[UINavigationController alloc] initWithRootViewController:_mainView];
    } else {
        LoginViewController *login = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
        self.window.rootViewController = nav;
        
        //        self.loginView = [[LoginViewController alloc] init];
        //        rootView = [[UINavigationController alloc] initWithRootViewController:_loginView];
    }
    
    [self.window makeKeyAndVisible];

    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.window endEditing:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //    容联
    [DeviceDelegateHelper sharedInstance].isB2F = YES;
    [DeviceDelegateHelper sharedInstance].preDate = nil;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //    容联
    [DeviceDelegateHelper sharedInstance].preDate = [NSDate date];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//容联
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    NSLog(@"推送的内容：%@",notificationSettings);
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //    NSError *parseError = nil;
    //    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo
    //                                                        options:NSJSONWritingPrettyPrinted error:&parseError];
    //    NSString *str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"推送内容"
    //                                                    message:str
    //                                                   delegate:nil
    //                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
    //                                          otherButtonTitles:nil];
    //    [alert show];
    //
    //    NSLog(@"远程推送str:%@",str);
    //    NSLog(@"远程推送1:%@",userInfo);
    //    NSLog(@"远程推送r:%@",[userInfo objectForKey:@"r"]);
    //    NSLog(@"远程推送s:%@",[userInfo objectForKey:@"s"]);
    
    self.callid = nil;
    NSString *userdata = [userInfo objectForKey:@"c"];
    NSLog(@"远程推送userdata:%@",userdata);
    if (userdata) {
        NSDictionary*callidobj = [NSJSONSerialization JSONObjectWithData:[userdata dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"远程推送callidobj:%@",callidobj);
        if ([callidobj isKindOfClass:[NSDictionary class]]) {
            self.callid = [callidobj objectForKey:@"callid"];
        }
    }
    
    NSLog(@"远程推送 callid=%@",self.callid);
}

#warning 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
#warning 将获取到的token传给SDK，用于苹果推送消息使用
    [[ECDevice sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

#warning 注册deviceToken失败；此处失败，与SDK无关，一般是您的环境配置或者证书配置有误
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.failToRegisterApns", Fail to register apns)
                                                    message:error.description
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)redirectNSLogToDocumentFolder {
    
#if LOG_OPEN
    if(isatty(STDOUT_FILENO)){
        return;
    }
    
    UIDevice *device = [UIDevice currentDevice];
    if([[device model] hasSuffix:@"Simulator"]){ //在模拟器不保存到文件中
        return;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName =[NSString stringWithFormat:@"%@.log", [self.dataformater stringFromDate:[NSDate date]]];
    NSString *logFilePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
#endif
    
}

-(BOOL)getLoginInfo {
    NSString *loginInfo = [DemoGlobalClass sharedInstance].userName;
    if (loginInfo.length>0) {
        return YES;
    }
    return NO;
}

-(void)toast:(NSString*)message {
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

-(void)updateSoftAlertViewShow:(NSString*)message isForceUpdate:(BOOL)isForce {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新版本发布" message:message delegate:self cancelButtonTitle:isForce?nil:@"下次更新" otherButtonTitles:@"更新", nil];
    alert.tag = 100;
    [alert show];
}

+(AppDelegate*)shareInstance {
    return [[UIApplication sharedApplication] delegate];
}

-(void)connectStateChanged:(NSNotification *)notification {
    ECError* error = notification.object;
    UINavigationController * rootView = (UINavigationController*)self.window.rootViewController;
    if (error) {
        [DemoGlobalClass sharedInstance].isLogin = NO;
        
        if (error.errorCode == ECErrorType_KickedOff || error.errorCode == 10) {
            
            //            if (_loginView == nil) {
            //                self.loginView = [[LoginViewController alloc] init];
            //                rootView = [[UINavigationController alloc] initWithRootViewController:_loginView];
            //            } else {
            //                rootView = self.loginView.navigationController;
            //            }
            //            self.mainView = nil;
            
            [DemoGlobalClass sharedInstance].userName = nil;
            
            if (error.errorCode == ECErrorType_KickedOff){
                UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:error.errorDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }
            
        } else if (error.errorCode == ECErrorType_NoError) {
            
            [DemoGlobalClass sharedInstance].isLogin = YES;
            [DemoGlobalClass sharedInstance].isHiddenLoginError = NO;
            //            if (_mainView == nil) {
            //                self.mainView = [[MainViewController alloc] init];
            //                rootView = [[UINavigationController alloc] initWithRootViewController:_mainView];
            //            } else {
            //                rootView = self.mainView.navigationController;
            //            }
            //            self.loginView = nil;
            ViewController *VC = [[ViewController alloc]init];
            rootView = [[UINavigationController alloc] initWithRootViewController:VC];
            
        } else if (error.errorCode != ECErrorType_Connecting
                   && error.errorCode != ECErrorType_TokenAuthFailed
                   && error.errorCode != ECErrorType_AuthServerException
                   && error.errorCode != ECErrorType_ConnectorServerException) {
            
            if (![DemoGlobalClass sharedInstance].isHiddenLoginError) {
                [DemoGlobalClass sharedInstance].isHiddenLoginError = YES;
                [self toast:[NSString stringWithFormat:@"错误码:%d",(int)error.errorCode]];
            }
        }
    }
    
    [rootView.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
    
    self.window.rootViewController = rootView;
}
@end
