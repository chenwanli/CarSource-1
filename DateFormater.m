//
//  DateFormater.m
//  FishAdjacent
//
//  Created by luoluo on 15/9/17.
//  Copyright (c) 2015年 luoluo. All rights reserved.
//

#import "DateFormater.h"

@implementation DateFormater

/**
 * NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
 NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
 NSLog(@"date:%@",[detaildate description]);
 //实例化一个NSDateFormatter对象
 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
 //设定时间格式,这里可以设置成自己需要的格式
 [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
 
 NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
 
 NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",searchCar.searchCarTime] doubleValue] / 1000];
 NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
 [dateFormat setDateFormat:@"MM-dd"];
 NSString *dateString = [dateFormat stringFromDate:date];
 */

+(NSString *)numberString:(NSString *)str
{
//    NSTimeInterval time=[str doubleValue];
//    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:[str doubleValue] / 1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return [self format:currentDateStr];
}

/**
 *  仿QQ空间时间显示
 *  @param string eg:2015年5月24日 02时21分30秒
 */

+(NSString *)format:(NSString *)string{
    
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //get date str
    NSString *str = string;// [outputFormatter stringFromDate:inputDate]
    //str to nsdate
    NSDate *strDate = [outputFormatter dateFromString:str];
    //修正8小时的差时
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: strDate];
    NSDate *endDate = [strDate  dateByAddingTimeInterval: interval];
//    NSLog(@"endDate:%@",endDate);
    NSString *lastTime = [self compareDate:endDate];
    return lastTime;
//    NSLog(@"lastTime = %@",lastTime);
   
}


+(NSString *)compareDate:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    //修正8小时之差
    NSDate *date1 = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date1];
    NSDate *localeDate = [date1  dateByAddingTimeInterval: interval];
    
    //NSLog(@"nowdate=%@\nolddate = %@",localeDate,date);
    NSDate *today = localeDate;
    NSDate *yesterday,*beforeOfYesterday;
    //今年
    NSString *toYears;
    
    toYears = [[today description] substringToIndex:4];
    
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    beforeOfYesterday = [yesterday dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString *todayString = [[today description] substringToIndex:10];
    NSString *yesterdayString = [[yesterday description] substringToIndex:10];
    NSString *beforeOfYesterdayString = [[beforeOfYesterday description] substringToIndex:10];
    
    NSString *dateString = [[date description] substringToIndex:10];
    NSString *dateYears = [[date description] substringToIndex:4];
    
    NSString *dateContent;
    if ([dateYears isEqualToString:toYears]) {//同一年
        //今 昨 前天的时间
        NSString *time = [[date description] substringWithRange:(NSRange){11,5}];
        //其他时间
        NSString *time2 = [[date description] substringWithRange:(NSRange){0,11}];
        if ([dateString isEqualToString:todayString]){
            dateContent = [NSString stringWithFormat:@"今天 %@",time];
            return dateContent;
        } else if ([dateString isEqualToString:yesterdayString]){
            dateContent = [NSString stringWithFormat:@"昨天 %@",time];
            return dateContent;
        }else if ([dateString isEqualToString:beforeOfYesterdayString]){
            dateContent = [NSString stringWithFormat:@"前天 %@",time];
            return dateContent;
        }else{
            return time2;
        }
    }else{
        return dateString;
    }
}



@end
