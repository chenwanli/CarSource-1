//
//  Header.h
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#ifndef Header_h
#define Header_h
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "SkinManager.h"
#import "NavView.h"
#import "RequestClass.h"
#import "LCCoolHUD.h"
#import "Serialization.h"
#import "LoginModel.h"
#import "NetworkRequest.h"
#import "ResourcesRequest.h"
#import "ChatInterfaceRequest.h"
#import "MyInformationRequest.h"
#import "DateFormater.h"
//容联
#import "MBProgressHUD.h"
#import "DeviceDelegateHelper.h"
#import "ECDeviceHeaders.h"
#import "DemoGlobalClass.h"

////APP外网接口
//#define HTTPREQUEST @"http://www.m8ba.com/carsource/"
////图片地址
//#define PICTUREADDRESS @"http://www.m8ba.com/"
//APP内网接口
#define HTTPREQUEST @"http://matches.zicp.net:12000/carsource/"
//图片地址
#define PICTUREADDRESS @"http://matches.zicp.net:12000/"

#define STRING_SIZE_FONT(_width_, _string_, _fsize_) [_string_ boundingRectWithSize:CGSizeMake(_width_, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:_fsize_]} context:nil].size;
//获取屏幕 宽度、高度
#define SCREEN_FRAME ([UIScreen mainScreen].applicationFrame)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES:NO)
#define SHOW_ALERT(msg) UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];\
[alert show];\

#define IMAGE 0.3 //压缩图片
#define BLACK [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1]
#define COLOR [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]
#define GRAY [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1]
#define LIGHTBLUE  [UIColor colorWithRed:233/255.0 green:244/255.0 blue:254/255.0 alpha:1]
#endif /* Header_h */
