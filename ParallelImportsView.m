//
//  ParallelImportsView.m
//  CarSource
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//
// 平行进口
#import "ParallelImportsView.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"

@interface ParallelImportsView ()<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_bgImage;
    UILabel *_unitLabel;
    UITextField *_textField;
    UITextView *_textview;
    NSInteger _editing;
    UIButton *_btn;
    UITextField *_numberField;
    UIButton *_addButton;
    NSInteger _cancel;
    UIButton *_cancelButton;
    UIView *_addView;
    UIView *_submitView;
    NSString *_specificationId;//规格id
    NSString *_carSeriesTypeId;//车型id
    NSString *_appearance;//外观
    NSString *_interior;//内饰
    NSString *_text;
    NSString *_typeStr;
    NSMutableArray *_imageArray;
}

@end

@implementation ParallelImportsView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{
    _editing = 1;
    _cancel = 1;
    _imageArray = [[NSMutableArray alloc]init];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 99)];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor whiteColor];
    // 设置内容大小
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,600 + (SCREEN_WIDTH - 20)/3);
    // 是否反弹
    _scrollView.bounces = NO;
    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _scrollView.scrollEnabled = YES;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    //        _scrollView.directionalLockEnabled = YES;
    [self addSubview:_scrollView];

    NSArray *arr = [[NSArray alloc]initWithObjects:@"选择车型",@"颜色", @"报价", @"配置",  nil];

    for (int i = 0; i <arr.count; i++) {

        if (i == 3) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44 *i, SCREEN_WIDTH, 44)];
            image.backgroundColor = LIGHTBLUE;
            [_scrollView addSubview:image];

        }

        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 44 *i +14, 16, 16)];
        numberLabel.layer.cornerRadius = 8;
        numberLabel.layer.masksToBounds = YES;
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.font = [UIFont systemFontOfSize:13];
        numberLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
        numberLabel.text = [NSString stringWithFormat:@"%d",i+1];
        [_scrollView addSubview:numberLabel];

        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(36, 44 *i, 90, 44)];
        textLabel.textColor = [UIColor grayColor];
        textLabel.font = [UIFont systemFontOfSize:16];
        textLabel.text = [arr objectAtIndex:i];
        [_scrollView addSubview:textLabel];

        if (i < 2 ) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 44 *i +12, 15, 18)];
            imageView.image = [UIImage imageNamed:@"milled"];
            [_scrollView addSubview:imageView];
        }

        UIImageView *bottomImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44 *i, SCREEN_WIDTH, 1)];
        bottomImage.backgroundColor = LIGHTBLUE;
        [_scrollView addSubview:bottomImage];
    }

    _typeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeButton.frame = CGRectMake(120, 0, SCREEN_WIDTH -160, 44);
    _typeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [_typeButton setTitle:@"美规 奥迪A7 15款豪华版" forState:UIControlStateNormal];
    _typeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_typeButton setTitleColor:COLOR forState:UIControlStateNormal];
    [_typeButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_typeButton];


    _colorButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    _colorButton.frame = CGRectMake(130, 44, SCREEN_WIDTH -170, 44);
    _colorButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [_colorButton setTitle:@"黑／白" forState:UIControlStateNormal];
    _colorButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_colorButton setTitleColor:COLOR forState:UIControlStateNormal];
    [_colorButton addTarget:self action:@selector(colorButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_colorButton];

    _unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -30, 88, 20, 44)];
    _unitLabel.textColor = COLOR;
//    _unitLabel.textAlignment = NSTextAlignmentRight;
    _unitLabel.font = [UIFont systemFontOfSize:14];
    _unitLabel.text = @"万";
    [_scrollView addSubview:_unitLabel];

    _textField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 90, 110, 40)];
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.delegate = self;
    _textField.textAlignment = UIControlContentHorizontalAlignmentRight;
//    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.textColor = [UIColor grayColor];
    _textField.placeholder = @"请输入销售价格";
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.keyboardType = UIKeyboardTypeDecimalPad;
    [_textField setReturnKeyType : UIReturnKeyDone ];
//    _textField.clearButtonMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_textField];


    //初始化并定义大小
    _textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 190, SCREEN_WIDTH -20, 140)];
    _textview.backgroundColor=[UIColor whiteColor]; //背景色
    _textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    _textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    _textview.delegate = self;       //设置代理方法的实现类
    _textview.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    _textview.layer.borderWidth = 1.0;
    _textview.textColor = [UIColor grayColor];

    _textview.text = @"填写详细赠送、配置、手续信息";

    _textview.font=[UIFont fontWithName:@"Arial" size:15.0]; //设置字体名字和字体大小;
    _textview.returnKeyType = UIReturnKeyDone;//return键的类型
    _textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    _textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    //    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    _textview.textColor = [UIColor grayColor];
    //    textview.text = @"UITextView详解";//设置显示的文本内容
    [_scrollView addSubview:_textview];

    NSArray *array = [[NSArray alloc]initWithObjects:@"类型",@"车架号",@"添加图片", nil];

    for (int i = 0; i < array.count ; i++) {
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 44 *i +354, 16, 16)];
        numberLabel.layer.cornerRadius = 8;
        numberLabel.layer.masksToBounds = YES;
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.font = [UIFont systemFontOfSize:13];
        numberLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
        numberLabel.text = [NSString stringWithFormat:@"%d",i+5];
        [_scrollView addSubview:numberLabel];

        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(36, 44 *i + 340, 90, 44)];
        textLabel.textColor = [UIColor grayColor];
        textLabel.font = [UIFont systemFontOfSize:16];
        textLabel.text = [array objectAtIndex:i];
        [_scrollView addSubview:textLabel];

        UIImageView *bottomImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44 *i + 340, SCREEN_WIDTH, 1)];
        bottomImage.backgroundColor = LIGHTBLUE;
        [_scrollView addSubview:bottomImage];


    }

    UIImageView *bottomImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44 *3 + 340, SCREEN_WIDTH, 1)];
    bottomImage.backgroundColor = LIGHTBLUE;
    [_scrollView addSubview:bottomImage];

    NSArray *typeArray = [[NSArray alloc]initWithObjects:@"现车", @"期货",nil];
    for (int i = 0; i < typeArray.count; i++) {
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(130 + (SCREEN_WIDTH - 140)/2 *i, 352 , 20, 20);
        button.tag = i +1;
        [button setImage:[UIImage imageNamed:@"highlighted"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"for"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];

        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(160 + (SCREEN_WIDTH - 140)/2 *i, 340 , 50, 44)];
        textLabel.textColor = [UIColor grayColor];
        textLabel.font = [UIFont systemFontOfSize:16];
        textLabel.text = [typeArray objectAtIndex:i];
        [_scrollView addSubview:textLabel];


    }

    _numberField = [[UITextField alloc]initWithFrame:CGRectMake(100, 385, SCREEN_WIDTH - 120, 40)];
    _numberField.font = [UIFont systemFontOfSize:15];
    _numberField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _numberField.delegate = self;
    _numberField.textAlignment = UIControlContentHorizontalAlignmentRight;
    //    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _numberField.textColor = [UIColor grayColor];
    _numberField.placeholder = @"请输入正确的车架号码";
//    _numberField.backgroundColor = [UIColor yellowColor];
    _numberField.keyboardType = UIKeyboardTypeDecimalPad;
    [_numberField setReturnKeyType : UIReturnKeyDone ];
//    _numberField.clearButtonMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_numberField];


    _cancelButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(SCREEN_WIDTH - 120, 428, 120, 44);
    [_cancelButton setTitle:@"取消删除" forState:UIControlStateNormal];
    [_cancelButton setTitle:@"删除" forState:UIControlStateSelected];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancelButton setTitleColor:COLOR forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_cancelButton];
    _cancelButton.hidden = YES;

    _addView = [[UIView alloc]initWithFrame:CGRectMake(0, 472, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3 +20)];
    [_scrollView addSubview:_addView];


    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(10, 10, (SCREEN_WIDTH - 10)/3 - 10, (SCREEN_WIDTH - 20)/3-10);
    [_addButton setBackgroundImage:[UIImage imageNamed:@"gift"] forState:UIControlStateNormal];

    [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addView addSubview:_addButton];

    _submitView = [[UIView alloc]initWithFrame:CGRectMake(0, 492 +(SCREEN_WIDTH - 20)/3 , SCREEN_WIDTH, 100)];
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
        _addView.frame = CGRectMake(0, 472, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3 +20);
        _addButton.frame = CGRectMake(10, 10, (SCREEN_WIDTH - 10)/3 - 10, (SCREEN_WIDTH - 20)/3-10);
        _submitView.frame = CGRectMake(0, 492 +(SCREEN_WIDTH - 20)/3 , SCREEN_WIDTH, 100);

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
                    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,600 +(SCREEN_WIDTH - 20)/3*(line +1));
                     _addView.frame = CGRectMake(0, 472, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3*(line +1) +20);
                    _addButton.frame = CGRectMake(x+10, y +10, (SCREEN_WIDTH - 20)/3 - 10, (SCREEN_WIDTH - 20)/3 - 10);

                    _submitView.frame = CGRectMake(0, 492 +(SCREEN_WIDTH - 20)/3*(line +1) , SCREEN_WIDTH, 100);
                }else{
                    _addButton.hidden = YES;
                     _addView.frame = CGRectMake(0, 472, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3*line +20);
                    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,600 +(SCREEN_WIDTH - 20)/3*line );
                   _submitView.frame = CGRectMake(0, 492 +(SCREEN_WIDTH - 20)/3*line, SCREEN_WIDTH, 100);
                }
            }
        }
    }

}
//
- (NSData *)imageQuality1500kb:(UIImage *)img{
    if (img) {
        int perMBBytes = 1024*1024;
        CGImageRef cgimage = img.CGImage;
        size_t bpp = CGImageGetBitsPerPixel(cgimage);
        size_t bpc = CGImageGetBitsPerComponent(cgimage);
        size_t bytes_per_pixel = bpp/bpc;

        long lPixelsPerMB = perMBBytes/bytes_per_pixel;
        long totalpixel = CGImageGetWidth(img.CGImage)*CGImageGetHeight(img.CGImage);
        if (totalpixel/lPixelsPerMB > 4) {
            NSData *imgData = UIImageJPEGRepresentation(img, IMAGE);

            return imgData;
        }else{
            return UIImageJPEGRepresentation(img, 1.0);
        }
    }
    return UIImageJPEGRepresentation(img, 1.0);
}

//获取车的颜色
- (void)initColorAppearance:(NSString *)appearance interior:(NSString *)interior{
     [_colorButton setTitle:[NSString stringWithFormat:@"%@/%@",appearance,interior] forState:UIControlStateNormal];
    _appearance = [NSString stringWithFormat:@"%@/%@",appearance,interior] ;
    _interior = interior;

}

//获取车型内容
- (void)initTypeButtontext{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *specificationText = [defaults objectForKey:@"specificationText"];//根据键值取出name
    NSString *specificationId = [defaults objectForKey:@"specificationId"];//根据键值取出name
    NSString *carSeriesTypeName = [defaults objectForKey:@"carSeriesTypeName"];//根据键值取出name
    NSString *carSeriesTypeId = [defaults objectForKey:@"carSeriesTypeId"];//根据键值取出name

//    NSLog(@"specificationText %@",  [defaults valueForKey:@"specificationText"]);
    if ([[defaults valueForKey:@"specificationText"] isEqualToString:@"(null)"] || specificationText == nil) {

    }else{
         [self.typeButton setTitle:[NSString stringWithFormat:@"%@/%@",specificationText,carSeriesTypeName] forState:UIControlStateNormal];
    }

    _carSeriesTypeId = carSeriesTypeId;
    _specificationId = specificationId;
    
//    NSLog(@"hh  %@ --- %@  ---%@  ----%@",specificationText,specificationId,carSeriesTypeName,carSeriesTypeId);

}

//车型选择
- (void)typeButtonClick:(UIButton *)button{
    self.models(nil);
}
//车颜色选择
- (void)colorButtonClick:(UIButton *)button{

    self.colorBtn(nil);

}

//确定发布
- (void)submitButtonClick:(UIButton *)button{

    if ([_carSeriesTypeId isEqualToString:@"(null)"] || _carSeriesTypeId == nil ||[_specificationId isEqualToString:@"(null)"] || _specificationId == nil) {
        SHOW_ALERT(@"请选择车型")
        return;
    }
    if ([_appearance isEqualToString:@""] || _appearance == nil ||[_interior isEqualToString:@""] || _interior == nil) {
        SHOW_ALERT(@"请选择颜色")
        return;
    }

    if ([_textField.text isEqualToString:@""] || _textField.text == nil) {
        SHOW_ALERT(@"请填写报价")
        return;
    }

    if ([_text isEqualToString:@""] || _text == nil) {
        SHOW_ALERT(@"请填写配置信息")
        return;
    }

    if ([_typeStr isEqualToString:@""] || _typeStr == nil) {
        SHOW_ALERT(@"请选择现车或者期货")
        return;
    }

    if ([_numberField.text isEqualToString:@""] || _numberField.text == nil) {
        SHOW_ALERT(@"请填车架号")
        return;
    }

//    if (_imageArray.count == 0) {
//        SHOW_ALERT(@"请添加图片")
//        return;
//    }
    [LCCoolHUD showLoading:@"正在发布，请稍等" inView:self];

    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [ResourcesRequest postParallelImportSalesVehiclesRequestWithUserId:login.userId salesText:_text imageArray:_imageArray carsSalesModelsId:_carSeriesTypeId salesCarsType:_typeStr colour:_appearance salesSpecificationId:_specificationId salesShelfNumber:_numberField.text salesImportedCarsPrice:_textField.text showCarList:^(NSMutableArray *saleArray, NSString *showCarList, NSString *errorMessage) {
        [LCCoolHUD hideInView:self];
        if ([errorMessage isEqualToString:@"0"]) {
            [LCCoolHUD showSuccess:@"发布成功" zoom:YES shadow:YES];
            //         清除本地保存的平行进口车型ID
            NSString*appDomain = [[NSBundle mainBundle]bundleIdentifier];

            [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
            self.submitStr(nil);
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
//选择 现车   期货
- (void)buttonClick:(UIButton *)button{
    _btn.selected = NO;
    button.selected = YES;
    _btn = button;
    if (button.tag == 1) {
        _typeStr = @"0";
    }else{
        _typeStr = @"1";
    }

}
//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

     _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeNone;
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
     _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    _editing = 2;
    if ([textView.text isEqualToString:@""] || textView.text == nil ) {
        _editing = 1;
        _textview.text = @"填写详细赠送、配置、手续信息";
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
