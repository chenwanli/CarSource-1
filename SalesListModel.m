//
//  SalesListModel.m
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//
//获取发布销售车辆列表
#import "SalesListModel.h"
#import "TFHpple.h"

@implementation SalesListModel
+ (SalesListModel *)salesListModelWithDictionary:(NSDictionary *)dict{
    SalesListModel *sales = [[SalesListModel alloc]init];
    sales.addressCounties = dict[@"addressCounties"];//地址
    sales.authenticateTypeNameList = dict[@"authenticateTypeNameList"];//认证
    sales.carSeriesName = dict[@"carSeriesName"];//简介
    sales.carSeriesTypeName = dict[@"carSeriesTypeName"];//展车型
    sales.imageList = dict[@"imageList"];// 发布销售图
    sales.salesCarsType = dict[@"salesCarsType"];//销售类型（0 现车，1期货）
    sales.salesId = dict[@"salesId"];//销售ID
    sales.salesModelsColour = dict[@"salesModelsColour"];//销售车型颜色 车身颜色/内饰颜色
    sales.salesShelfNumber = dict[@"salesShelfNumber"];//销售车架号
    sales.salesTime = dict[@"salesTime"];//发布销售时间
    sales.specificationText = dict[@"specificationText"];// 展车规格类型
    sales.userName = dict[@"userName"];//用户名称
    sales.userTel = dict[@"userTel"];//展车发布时间
    sales.userUrl = dict[@"userUrl"];//销售用户的头像
    sales.salesSpcificationId = dict[@"salesSpcificationId"];//获取中规ID为1 不进入详情页面

    //字条串是否包含有某字符串
//    NSString *string ;
    if ([dict[@"salesText"] rangeOfString:@"font"].location == NSNotFound) {
         sales.salesText = dict[@"salesText"];//销售详细内容
    } else {

         NSLog(@"dict[ == %@",dict[@"salesText"]);

//        NSString *dataString = [NSString stringWithContentsOfURL:[NSURL URLWithString:dict[@"salesText"]] encoding:NSUTF8StringEncoding error:nil];  //htmlString是html网页的地址
//        NSString *nodeString = @"//p";
//        NSData *htmlData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
//        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
//        NSArray *elements  = [xpathParser searchWithXPathQuery:nodeString];  //这个数组中就有需要的值
//        NSLog(@"elements = %@",elements);
//

//        NSString *imageStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:dict[@"salesText"]] encoding:NSUTF8StringEncoding error:nil];
//
//        NSRange rang1=[imageStr rangeOfString:@"<p>"];
//        NSMutableString *imageStr2=[[NSMutableString alloc]initWithString:[imageStr substringFromIndex:rang1.location]];
//
//        NSRange rang2=[imageStr2 rangeOfString:@"<div class=\"clear\"></div>"];
//        NSMutableString *imageStr3=[[NSMutableString alloc]initWithString:[imageStr2 substringToIndex:rang2.location]];
//        
//
//        NSData *htmlData=[imageStr3 dataUsingEncoding:/*CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)*/NSUTF8StringEncoding];
//
//        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
//        NSArray *elements  = [xpathParser searchWithXPathQuery:@"//p"];
//
//        //NSLog(@"%@",elements);
//
////        _contArray=[[NSMutableArray alloc]init];
//
//        for (TFHppleElement *element in elements) {
//
//            if ([element content]!=nil) {
//
//                 NSLog(@"%@",[element content]);
//
////                [_contArray addObject:[element content]];
//
//            }
//            
//        }

    }
    

    sales.modelsPrice = dict[@"modelsPrice"];//销售价格
    return sales;
}

@end
