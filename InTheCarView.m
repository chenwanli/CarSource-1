//
//  InTheCarView.m
//  CarSource
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "InTheCarView.h"
#import "HZQDatePickerView.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"

@interface InTheCarView ()<UIScrollViewDelegate,HZQDatePickerViewDelegate,UITextViewDelegate>{
    UIButton *_typeButton;
    UIScrollView *_scrollView;
    UILabel *_monthLabel;
    UILabel *_dayLabel;
     HZQDatePickerView *_pikerView;
    UITextView *_textview;
    NSInteger _editing;
    UIButton *_cancelButton;
    UIView *_addView;
    UIButton *_addButton;
    UIView *_submitView;
    NSInteger _cancel;
    NSMutableArray *_imageArray;
    NSString *_text;
    NSString *_carSeriesTypeId;
    NSString *_timeStr;
    NSString *_promotionId;
    NSString *_specificationId;//规格ID

}
@end
@implementation InTheCarView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{
    _cancel = 1;
    _editing = 1;
    _imageArray = [[NSMutableArray alloc]init];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    //    scrollView.delegate = self;
    // 设置内容大小
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,(SCREEN_WIDTH - 20)/3 +480);
    // 是否反弹
    _scrollView.bounces = NO;
    // 是否滚动
    //    scrollView.scrollEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    // 是否同时运动,lock
    _scrollView.directionalLockEnabled = YES;
//    _scrollView.layer.borderColor = [UIColor colorWithRed:219/255.0 green:230/255.0 blue:239/255.0 alpha:1].CGColor;
//    _scrollView.layer.borderWidth = 1.0;
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollView];

    NSArray *typeArray = [[NSArray alloc]initWithObjects:@"交车车型",@"交车日期",@"交车感言", nil];

    for (int i = 0; i < typeArray.count; i++) {
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 *i, 70, 50)];
        textLabel.text = [typeArray objectAtIndex:i];
        textLabel.textColor = BLACK;
        textLabel.font = [UIFont systemFontOfSize:16];
        [_scrollView addSubview:textLabel];

        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50*i +50, SCREEN_WIDTH - 20, 1)];
        image.backgroundColor = GRAY;
        [_scrollView addSubview:image];

    }

    _monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 60 , 60, 30)];
    _monthLabel.layer.cornerRadius = 5;
    _monthLabel.layer.masksToBounds = YES;
    _monthLabel.textAlignment = NSTextAlignmentCenter;
    _monthLabel.textColor = [UIColor grayColor];
    _monthLabel.layer.borderColor = COLOR.CGColor;
    _monthLabel.layer.borderWidth = 1.0;
    _monthLabel.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:_monthLabel];

    _dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 60 , 60, 30)];
    _dayLabel.layer.cornerRadius = 5;
    _dayLabel.layer.masksToBounds = YES;
    _dayLabel.textAlignment = NSTextAlignmentCenter;
    _dayLabel.textColor = [UIColor grayColor];
    _dayLabel.layer.borderColor = COLOR.CGColor;
    _dayLabel.layer.borderWidth = 1.0;
    _dayLabel.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:_dayLabel];

    UIButton *timeBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame = CGRectMake(80, 50, 150, 50);
    [timeBtn addTarget:self action:@selector(timeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:timeBtn];


    _typeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeButton.frame = CGRectMake(80, 0, SCREEN_WIDTH - 120, 50);
    _typeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    _typeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_typeButton setTitleColor:COLOR forState:UIControlStateNormal];
    [_typeButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_typeButton];

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(SCREEN_WIDTH - 30, 16, 15, 18);
    imageView.image = [UIImage imageNamed:@"milled"];
    [_scrollView addSubview:imageView];

    //初始化并定义大小
    _textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 160, SCREEN_WIDTH -20, 140)];
    _textview.backgroundColor=[UIColor whiteColor]; //背景色
    _textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    _textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    _textview.delegate = self;       //设置代理方法的实现类
    _textview.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    _textview.layer.borderWidth = 1.0;
    _textview.textColor = [UIColor grayColor];

    _textview.text = @"可知天底下生意没那么难做，发表下感言吧";

    _textview.font=[UIFont fontWithName:@"Arial" size:15.0]; //设置字体名字和字体大小;
    _textview.returnKeyType = UIReturnKeyDone;//return键的类型
    _textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    _textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    //    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    _textview.textColor = [UIColor grayColor];
    //    textview.text = @"UITextView详解";//设置显示的文本内容
    [_scrollView addSubview:_textview];

    UILabel *imageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 310, SCREEN_WIDTH, 50)];
    imageLabel.text = @"  交车图片";
    imageLabel.textColor = BLACK;
    imageLabel.backgroundColor = [UIColor colorWithRed:211/255.0 green:238/255.0 blue:254/255.0 alpha:1];
    imageLabel.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:imageLabel];

    _cancelButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(SCREEN_WIDTH - 120, 310, 120, 50);
    [_cancelButton setTitle:@"取消删除" forState:UIControlStateNormal];
    [_cancelButton setTitle:@"删除" forState:UIControlStateSelected];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancelButton setTitleColor:COLOR forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_cancelButton];
    _cancelButton.hidden = YES;

    _addView = [[UIView alloc]initWithFrame:CGRectMake(0, 360, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3 +20)];
    [_scrollView addSubview:_addView];


    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(10, 10, (SCREEN_WIDTH - 10)/3 - 10, (SCREEN_WIDTH - 20)/3-10);
    [_addButton setBackgroundImage:[UIImage imageNamed:@"gift"] forState:UIControlStateNormal];

    [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addView addSubview:_addButton];

    _submitView = [[UIView alloc]initWithFrame:CGRectMake(0, 380 +(SCREEN_WIDTH - 20)/3 , SCREEN_WIDTH, 100)];
    _submitView.backgroundColor = GRAY;
    [_scrollView addSubview:_submitView];

    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"确定发布" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(50,30, SCREEN_WIDTH - 100, 50);
    submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_submitView addSubview:submitButton];

}
- (void)initCarSeriesTypeName:(NSString *)carSeriesTypeName carSeriesTypeId:(NSString *)carSeriesTypeId promotionId:(NSString *)promotionId specificationId:(NSString *)specificationId specifications:(NSString *)specifications{
    _carSeriesTypeId = carSeriesTypeId;
    _promotionId = promotionId;
    _specificationId = specificationId;
    if ([specifications isEqualToString:@""]|| specifications == nil) {
        [_typeButton setTitle:carSeriesTypeName forState:UIControlStateNormal];
    }else{
        [_typeButton setTitle:[NSString stringWithFormat:@"%@/%@",specifications,carSeriesTypeName] forState:UIControlStateNormal];
    }


}
- (void)initAddImageArray:(NSMutableArray *)imageArray{

    [_addView removeFromSuperview];
    _addView = [[UIView alloc]init];
    [_scrollView addSubview:_addView];

    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(10, 10, (SCREEN_WIDTH - 10)/3 - 10, (SCREEN_WIDTH - 20)/3-10);
    [_addButton setBackgroundImage:[UIImage imageNamed:@"gift"] forState:UIControlStateNormal];

    [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addView addSubview:_addButton];

    if (imageArray.count == 0) {
        _cancelButton.hidden = YES;
        _addView.frame = CGRectMake(0,360, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3 +20);
        _addButton.frame = CGRectMake(10, 10, (SCREEN_WIDTH - 10)/3 - 10, (SCREEN_WIDTH - 20)/3-10);
        _submitView.frame = CGRectMake(0, 380 +(SCREEN_WIDTH - 20)/3 , SCREEN_WIDTH, 100);

    }

    @autoreleasepool
    {
        [_imageArray removeAllObjects];
        int totalloc=3;
        CGFloat appvieww=(SCREEN_WIDTH- 20)/3-5;
        CGFloat appviewh=(SCREEN_WIDTH- 20)/3-5;
        CGFloat margin=((SCREEN_WIDTH- 20) -totalloc*appvieww)/(totalloc+1);

        for (int i = 0; i < imageArray.count; i++) {

            int row=i/totalloc;//行号
            //1/3=0,2/3=0,3/3=1;
            int loc=i%totalloc;//列号
            CGFloat appviewx=margin+(margin+appvieww)*loc;
            CGFloat appviewy=margin+(margin+appviewh)*row;
            UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            imageButton.frame = CGRectMake(appviewx +10, appviewy +10, (SCREEN_WIDTH - 20)/3 - 10, (SCREEN_WIDTH - 20)/3 - 10);
            // 判断类型来获取Image
            MLSelectPhotoAssets *asset = imageArray[i];
            NSData *imageData = [self imageQuality1500kb:[MLSelectPhotoPickerViewController getImageWithImageObj:asset]];
            [_imageArray addObject:imageData];

            [imageButton setBackgroundImage:[MLSelectPhotoPickerViewController getImageWithImageObj:asset] forState:UIControlStateNormal];

            [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            imageButton.tag = i ;

            [_addView addSubview:imageButton];

            imageButton = nil;

            if (_cancel == 1) {
                UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
                deleteButton.frame = CGRectMake(appviewx +(SCREEN_WIDTH - 20)/3 -22, appviewy +2, 30, 30);
                [deleteButton setBackgroundImage:[UIImage imageNamed:@"esc"] forState:UIControlStateNormal];
                [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                deleteButton.tag = i +1;
                [_addView addSubview:deleteButton];
                deleteButton = nil;

            }

            if (i == imageArray.count -1) {

                _cancelButton.hidden = NO;
                int line=(i +1)/totalloc;//行号
                //1/3=0,2/3=0,3/3=1;
                int column=(i +1)%totalloc;//列号
                CGFloat x=margin+(margin+appvieww)*column;
                CGFloat y=margin+(margin+appviewh)*line;
                if (i<8) {

                    _addButton.hidden = NO;
                    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,480 +(SCREEN_WIDTH - 20)/3*(line +1));
                    _addView.frame = CGRectMake(0, 360, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3*(line +1) +20);
                    _addButton.frame = CGRectMake(x+10, y +10, (SCREEN_WIDTH - 20)/3 - 10, (SCREEN_WIDTH - 20)/3 - 10);

                    _submitView.frame = CGRectMake(0, 380 +(SCREEN_WIDTH - 20)/3*(line +1) , SCREEN_WIDTH, 100);
                }else{
                    _addButton.hidden = YES;
                    _addView.frame = CGRectMake(0, 360, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3*line +20);
                    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,480 +(SCREEN_WIDTH - 20)/3*line );
                    _submitView.frame = CGRectMake(0, 380 +(SCREEN_WIDTH - 20)/3*line, SCREEN_WIDTH, 100);
                }
            }
        }
    }

}
- (NSData *)imageQuality1500kb:(UIImage *)img{
    if (img) {
        int perMBBytes = 1024*1024;
        CGImageRef cgimage = img.CGImage;
        size_t bpp = CGImageGetBitsPerPixel(cgimage);
        size_t bpc = CGImageGetBitsPerComponent(cgimage);
        size_t bytes_per_pixel = bpp/bpc;

        long lPixelsPerMB = perMBBytes/bytes_per_pixel;
        long totalpixel = CGImageGetWidth(img.CGImage)*CGImageGetHeight(img.CGImage);
        if (totalpixel/lPixelsPerMB > 8) {
            NSData *imgData = UIImageJPEGRepresentation(img, IMAGE);

            return imgData;
        }else{
            return UIImageJPEGRepresentation(img, 1.0);
        }
    }
    return UIImageJPEGRepresentation(img, 1.0);
}

- (NSString *)time:(NSString *)time{

    NSString *string = [NSString stringWithFormat:@"%@ 00:00:00",time];

    // 设置时间显示格式:
    //    NSString* timeStr = @"2011-01-26 17:40:50";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [[NSDate alloc] init];
    datenow = [formatter dateFromString:string];//------------将字符串按formatter转成nsdate
    //    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    //    NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
    // 时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
//    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    return timeSp;
}

//确定发布
- (void)submitButtonClick:(UIButton *)button{
    if ([_carSeriesTypeId isEqualToString:@""] || _carSeriesTypeId == nil) {
        SHOW_ALERT(@"请选择车型")
        return;
    }

    if ([_timeStr isEqualToString:@""] || _timeStr == nil) {
        SHOW_ALERT(@"请选择交车时间")
        return;
    }

    if ([_text isEqualToString:@""] || _text == nil) {
        SHOW_ALERT(@"请填写交车感言")
        return;
    }

    if (_imageArray.count == 0) {
        SHOW_ALERT(@"请添加交车图片")
        return;
    }

    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [LCCoolHUD showLoading:@"正在发布,请稍等" inView:self];

    [MyInformationRequest postAddInTheCarRequestWithUserId:login.userId transactionVehiclesTime:[self time:_timeStr]  imageArray:_imageArray transactionVehiclesIntroduction:_text transactionVehiclesCarSeriesTypeId:_carSeriesTypeId transactionVehiclesShowroomId:_promotionId transactionVehiclesSpecificationId:_specificationId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {

        [LCCoolHUD hideInView:self];
        if ([errorMessage isEqualToString:@"0"] ) {

            [LCCoolHUD showSuccess:@"交车车发布成功" zoom:YES shadow:YES];
            self.submit(nil);
        }

    }];

}
//查看大图
- (void)imageButtonClick:(UIButton *)button
{
    self.toViewImage(button.tag);
}
//删除图片
- (void)deleteButtonClick:(UIButton *)button{

    self.deleteImage(button.tag-1);

}
//取消删除
- (void)cancelButtonClick:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        _cancel = 0;
    }else{
        _cancel = 1;
    }
    
    self.canceldelete(nil);
}
//添加图片
- (void)addButtonClick:(UIButton *)button{
    
    self.addImage(nil);
}


- (void)typeButtonClick:(UIButton *)button{
    self.typeBtn(nil);
}
- (void)timeButtonClick{
    [self setupDateView:DateTypeOfStart];
}

- (void)setupDateView:(DateType)type {

    _pikerView = [HZQDatePickerView instanceDatePickerView];
    _pikerView.frame = CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    _pikerView.type = type;
    [_pikerView.datePickerView setMinimumDate:[NSDate date]];
    [self addSubview:_pikerView];
}

- (void)getSelectDate:(NSString *)date type:(DateType)type {
//    NSLog(@"%d - %@", type, date);

    if (type == 0) {
        NSArray *array = [date componentsSeparatedByString:@"-"];
        _monthLabel.text = [NSString stringWithFormat:@"%@ 月",[array objectAtIndex:1]];
        _dayLabel.text = [NSString stringWithFormat:@"%@ 日",[array objectAtIndex:2]];
//        [self time:date];
        _timeStr = date;

    }

}

//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

//    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeNone;
    if (_editing == 1) {
        _textview.text = @"";
        _textview.textColor = [UIColor blackColor];
    }

    return YES;
}

//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
}

//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    _editing = 2;
    if ([textView.text isEqualToString:@""] || textView.text == nil ) {
        _editing = 1;
        _textview.text = @"可知天底下生意没那么难做，发表下感言吧";
        _textview.textColor = [UIColor grayColor];
    }else{
        _text = textView.text;
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return YES; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }

    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
