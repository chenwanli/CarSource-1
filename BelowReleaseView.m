//
//  BelowReleaseView.m
//  CarSource
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BelowReleaseView.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"

@interface BelowReleaseView ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate>{
    UIScrollView *_scrollView;
    UITextView *_textview;
    NSInteger _editing;
    UIButton *_cancelButton;
    UIView *_addView;
    UIButton *_addButton;
    UIView *_submitView;
    NSInteger _cancel;
    NSMutableArray *_imageArray;
    NSString *_carSeriesTypeId;
    UITextField *_numberField;
    NSString *_colorId;
    NSString *_text;
    NSString *_specificationId;//规格ID

}
@end

@implementation BelowReleaseView
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
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,(SCREEN_WIDTH - 20)/3 +530);
    // 是否反弹
    _scrollView.bounces = NO;
    // 是否滚动
    //    scrollView.scrollEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    // 是否同时运动,lock
    _scrollView.directionalLockEnabled = YES;
    //    _scrollView.layer.borderColor = [UIColor colorWithRed:219/255.0 green:230/255.0 blue:239/255.0 alpha:1].CGColor;
    //    _scrollView.layer.borderWidth = 1.0;
    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollView];

    NSArray *typeArray = [[NSArray alloc]initWithObjects:@"选择车型",@"车源价格",@"车型颜色",@"展车介绍", nil];

    for (int i = 0; i < typeArray.count; i++) {
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 *i, 70, 50)];
        textLabel.text = [typeArray objectAtIndex:i];
        textLabel.textColor = [UIColor grayColor];
        textLabel.font = [UIFont systemFontOfSize:16];
        [_scrollView addSubview:textLabel];

        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50*i +50, SCREEN_WIDTH - 20, 1)];
        image.backgroundColor = GRAY;
        [_scrollView addSubview:image];

    }
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

    UILabel *unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 35, 50, 20, 50)];
    unitLabel.textColor = [UIColor grayColor];
    unitLabel.text = @"万";
    unitLabel.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:unitLabel];

    _numberField = [[UITextField alloc]initWithFrame:CGRectMake(80 , 52, SCREEN_WIDTH -120, 46)];
    _numberField.font = [UIFont systemFontOfSize:15];
    _numberField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _numberField.delegate = self;
    _numberField.textAlignment = UIControlContentHorizontalAlignmentRight;
    //    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _numberField.textColor = [UIColor grayColor];
    _numberField.placeholder = @"输入车源价格";
    //    _numberField.backgroundColor = [UIColor yellowColor];
    _numberField.keyboardType = UIKeyboardTypeDecimalPad;
    [_numberField setReturnKeyType : UIReturnKeyDone ];
    //    _numberField.clearButtonMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_numberField];

    _colorBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    _colorBtn.frame = CGRectMake(80, 100, SCREEN_WIDTH - 120, 50);
    _colorBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _colorBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_colorBtn setTitleColor:COLOR forState:UIControlStateNormal];
    [_colorBtn addTarget:self action:@selector(colorButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_colorBtn];

    UIImageView *colorImage = [[UIImageView alloc]init];
    colorImage.frame = CGRectMake(SCREEN_WIDTH - 30, 116, 15, 18);
    colorImage.image = [UIImage imageNamed:@"milled"];
    [_scrollView addSubview:colorImage];


    //初始化并定义大小
    _textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 210, SCREEN_WIDTH -20, 140)];
    _textview.backgroundColor=[UIColor whiteColor]; //背景色
    _textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    _textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    _textview.delegate = self;       //设置代理方法的实现类
    _textview.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    _textview.layer.borderWidth = 1.0;
    _textview.textColor = [UIColor grayColor];
    _textview.text = @"输入展车详细介绍";
    _textview.font=[UIFont fontWithName:@"Arial" size:15.0]; //设置字体名字和字体大小;
    _textview.returnKeyType = UIReturnKeyDone;//return键的类型
    _textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    _textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    //    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    _textview.textColor = [UIColor grayColor];
    //    textview.text = @"UITextView详解";//设置显示的文本内容
    [_scrollView addSubview:_textview];

    UILabel *imageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 360, SCREEN_WIDTH, 50)];
    imageLabel.text = @"  展车图片";
    imageLabel.textColor = [UIColor grayColor];
    imageLabel.backgroundColor = [UIColor colorWithRed:211/255.0 green:238/255.0 blue:254/255.0 alpha:1];
    imageLabel.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:imageLabel];

    _cancelButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(SCREEN_WIDTH - 120, 360, 120, 50);
    [_cancelButton setTitle:@"取消删除" forState:UIControlStateNormal];
    [_cancelButton setTitle:@"删除" forState:UIControlStateSelected];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancelButton setTitleColor:COLOR forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_cancelButton];
    _cancelButton.hidden = YES;

    _addView = [[UIView alloc]initWithFrame:CGRectMake(0, 410, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3 +20)];
    [_scrollView addSubview:_addView];


    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(10, 10, (SCREEN_WIDTH - 10)/3 - 10, (SCREEN_WIDTH - 20)/3-10);
    [_addButton setBackgroundImage:[UIImage imageNamed:@"gift"] forState:UIControlStateNormal];

    [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addView addSubview:_addButton];

    _submitView = [[UIView alloc]initWithFrame:CGRectMake(0, 430 +(SCREEN_WIDTH - 20)/3 , SCREEN_WIDTH, 100)];
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
- (void)initCarSeriesTypeName:(NSString *)carSeriesTypeName carSeriesTypeId:(NSString *)carSeriesTypeId specificationId:(NSString *)specificationId specifications:(NSString *)specifications{
    _carSeriesTypeId = carSeriesTypeId;
    _specificationId = specificationId;
    if ([specifications isEqualToString:@""] || specifications== nil) {
        [_typeButton setTitle:carSeriesTypeName forState:UIControlStateNormal];
    }else{
        [_typeButton setTitle:[NSString stringWithFormat:@"%@/%@",specifications,carSeriesTypeName] forState:UIControlStateNormal];
    }

}

- (void)appearance:(NSString *)appearance interiorColor:(NSString *)interiorColor appearanceId:(NSString *)appearanceId interiorColorId:(NSString *)interiorColorId{

    _colorId = [NSString stringWithFormat:@"%@/%@",appearanceId,interiorColorId];
     [self.colorBtn setTitle:[NSString stringWithFormat:@"%@/%@",appearance,interiorColor] forState:UIControlStateNormal];
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
        _addView.frame = CGRectMake(0,410, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3 +20);
        _addButton.frame = CGRectMake(10, 10, (SCREEN_WIDTH - 10)/3 - 10, (SCREEN_WIDTH - 20)/3-10);
        _submitView.frame = CGRectMake(0, 430 +(SCREEN_WIDTH - 20)/3 , SCREEN_WIDTH, 100);

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
                    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,530 +(SCREEN_WIDTH - 20)/3*(line +1));
                    _addView.frame = CGRectMake(0, 410, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3*(line +1) +20);
                    _addButton.frame = CGRectMake(x+10, y +10, (SCREEN_WIDTH - 20)/3 - 10, (SCREEN_WIDTH - 20)/3 - 10);
                    _submitView.frame = CGRectMake(0, 430 +(SCREEN_WIDTH - 20)/3*(line +1) , SCREEN_WIDTH, 100);
                }else{
                    _addButton.hidden = YES;
                    _addView.frame = CGRectMake(0, 410, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3*line +20);
                    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,530 +(SCREEN_WIDTH - 20)/3*line );
                    _submitView.frame = CGRectMake(0, 430 +(SCREEN_WIDTH - 20)/3*line, SCREEN_WIDTH, 100);
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

//车型颜色
- (void)colorButtonClick:(UIButton *)button{
    self.colorButton(nil);
}
//确定发布
- (void)submitButtonClick:(UIButton *)button{

    if ([_carSeriesTypeId isEqualToString:@""] || _carSeriesTypeId == nil) {
        SHOW_ALERT(@"请选择车型")
        return;
    }

    if ([_numberField.text isEqualToString:@""] || _numberField.text == nil) {
        SHOW_ALERT(@"请填写车源价格")
        return;
    }

    if ([_colorId isEqualToString:@""] || _colorId == nil) {
        SHOW_ALERT(@"请选择颜色")
        return;
    }

    if ([_textview.text isEqualToString:@""] || _textview.text == nil) {
        SHOW_ALERT(@"请填写展车介绍")
        return;
    }

    if (_imageArray.count == 0) {
        SHOW_ALERT(@"请添加图片");
         return;
    }

    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [LCCoolHUD showLoading:@"正在发布,请稍等" inView:self];

    [MyInformationRequest postAddTheShowInformationRequestWithUserId:login.userId carSeriesTypeId:_carSeriesTypeId imageArray:_imageArray price:_numberField.text introduction:_textview.text colour:_colorId specificationId:_specificationId showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
        [LCCoolHUD hideInView:self];
        if ([errorMessage isEqualToString:@"0"] ) {

            [LCCoolHUD showSuccess:@"展车发布成功" zoom:YES shadow:YES];
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

//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeNone;
    if (_editing == 1) {
        _textview.text = @"";
        _textview.textColor = [UIColor blackColor];
    }else{
        _text = textView.text;
    }

    return YES;
}

//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
}

//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    _editing = 2;
    if ([textView.text isEqualToString:@""] || textView.text == nil ) {
        _editing = 1;
        _textview.text = @"输入展车详细介绍";
        _textview.textColor = [UIColor grayColor];
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
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
