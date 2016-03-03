//
//  MoveViewController.m
//  MoveSelect
//
//  Created by ChaoRen on 15/12/23.
//  Copyright © 2015年 ChaoRen. All rights reserved.
//

#define DeviceWidth [[UIScreen mainScreen] bounds].size.width
#define DeviceHeight [[UIScreen mainScreen] bounds].size.height

#import "MoveViewController.h"
#import "CarPicturesView.h"
#import "ModelsContrastView.h"
#import "TrailerServiceView.h"
#import "CommissionedToFindCarView.h"
#import "ProvincesViewController.h"
#import "ContrastViewController.h"

@implementation ContentModel

- (void)dealloc
{
    self.titleArray = nil;
    self.contentViews = nil;
}

@end

@interface MoveViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    UIScrollView *_selectContaintView;
    UIScrollView *_containtView;
    
    UIImageView *_moveImageView;
    
    CGFloat _selectBtnWidt;
    
    UIButton *_selectBtn;
    
    NSInteger _selectIndex;
    
    BOOL _isFrist;
    
    UIView *_current;
    UIView *_next;
    UIView *_last;
}


@end

@implementation MoveViewController

- (void)dealloc
{
    self.titleFont = nil;
    self.titleSelectColor = nil;
    self.normalColor = nil;
}

- (void)loadView
{
    [super loadView];
    
    self.title = @"移动的选项";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;

    _selectIndex = _selectNum - 2;
    
    @autoreleasepool
    {
        [self initTitle];
        self.contentViewArr = [[NSMutableArray alloc]init];
//        CommissionedToFindCarView *commissioned = [[CommissionedToFindCarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
//        commissioned.backgroundColor = [UIColor whiteColor];
//        [self.contentViewArr addObject:commissioned];

        CarPicturesView *carPictures = [[CarPicturesView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
        carPictures.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:240/255.0 alpha:1];
;
        carPictures.carView = ^(NSString *carView){


        };
        [self.contentViewArr addObject:carPictures];

        ModelsContrastView *models = [[ModelsContrastView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
        models.backgroundColor = [UIColor whiteColor];
        [self.contentViewArr addObject:models];

        models.contrast = ^(NSString *contrast){

            ContrastViewController *contrastView = [[ContrastViewController alloc]init];
            [self.navigationController pushViewController:contrastView animated: YES];
        };


        TrailerServiceView *trailer = [[TrailerServiceView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
        trailer.searchProvinces = ^(NSString *searchProvinces){
            ProvincesViewController *provinces = [[ProvincesViewController alloc]init];
            [self.navigationController pushViewController:provinces animated: YES];
        };
        trailer.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];
        
        [self.contentViewArr addObject:trailer];
        

        [self installationHeaderSelectView];
    }
    
//    NSLog(@"--- %ld =====--- %ld",_selectIndex,_selectNum);

}

- (void)installationHeaderSelectView
{
    {
        _containtView = [[UIScrollView alloc] init];
        _containtView.frame = CGRectMake(0,114, DeviceWidth, DeviceHeight-114);
        _containtView.delegate = self;
        _containtView.tag = 99999;
        _containtView.backgroundColor = [UIColor whiteColor];
        _containtView.contentSize = CGSizeMake(DeviceWidth * 3, 0);
        _containtView.pagingEnabled = YES;
        _containtView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_containtView];
        if (_selectNum)
        {
            [self enterFrist];
        }
    }
    
    _selectContaintView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, DeviceWidth, 50)];
    _selectContaintView.backgroundColor = [UIColor whiteColor];
    _selectContaintView.tag = 99998;
    
    _selectContaintView.delegate = self;
    [self.view addSubview:_selectContaintView];
    
    {
        
        [_selectContaintView addSubview:_moveImageView];
        
        _selectBtnWidt = DeviceWidth/3;
        _selectContaintView.contentSize = CGSizeMake(_selectBtnWidt*self.content.titleArray.count, 0);
        
//        NSLog(@"-=-=-=  %.1f",_selectBtnWidt);

        _moveImageView = [UIImageView new];
        _moveImageView.frame = CGRectMake(0, 34, 35, 16);
        [_selectContaintView addSubview:_moveImageView];
        
        if (_isSelectImage)
        {
            _moveImageView.image = [UIImage imageNamed:@"che"];
        }
        else
        {
            _moveImageView.frame = CGRectMake(0, 30, _selectBtnWidt, 19);
//            _moveImageView.backgroundColor = [UIColor colorWithRed:110/255.0 green:188/255.0 blue:1 alpha:1];
            
            _moveImageView.layer.cornerRadius = 1.5;
        }
        
        UIColor *color = self.normalColor ? self.normalColor:[UIColor grayColor];
        UIColor *selectColor = self.titleSelectColor ? self.titleSelectColor : [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];;
        UIFont *font = self.titleFont ? self.titleFont : [UIFont systemFontOfSize:16];
        
        for (int i = 0; i < self.content.titleArray.count; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(_selectBtnWidt*i, 0, _selectBtnWidt, 44);
            [button setTitle:[NSString stringWithFormat:@"%@",self.content.titleArray[i]] forState:UIControlStateNormal];
            [button setTitleColor:color forState:UIControlStateNormal];
            [button setTitleColor:selectColor forState:UIControlStateSelected];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 9, 0);
            button.tag = i + 1;
            button.titleLabel.font = font;
            [button addTarget:self action:@selector(clickPresson:) forControlEvents:UIControlEventTouchUpInside];
            [_selectContaintView addSubview:button];
            
            if (self.selectNum)
            {
                if (i == _selectIndex)
                {
                    [self clickPresson:button];
                }
                
            }
            else if (i == 0 && _selectIndex == 0)
            {
                [self clickPresson:button];
            }
        }

        UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 113, SCREEN_WIDTH, 1)];
        lineImage.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
        [self.view addSubview:lineImage];
    }
}

- (void)clickPresson:(UIButton *)button
{
//    NSLog(@"--- %ld",button.tag);

    _selectBtn.selected = NO;
    _selectBtn = button;
    _selectBtn.selected = YES;
    
    [self moveImageAnimation:button];
    
}

- (void)moveImageAnimation:(UIButton *)indexBtn
{
    if (_isSelectImage)
    {
        [UIView animateWithDuration:.5 animations:^{
            _moveImageView.center = CGPointMake(indexBtn.center.x, self.imageHeight);
        } completion:nil];
    }
    else
    {
        [UIView animateWithDuration:.5 animations:^{
            _moveImageView.center = CGPointMake(indexBtn.center.x, self.imageHeight);
        } completion:nil];
    }
    
    if (_isFrist)
    {
        NSInteger idx = indexBtn.tag;
        _selectNum = idx;
        [self moveToLeft];
        
//        NSLog(@"---- ==== %ld",_selectNum);
    }
    _isFrist = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
//    if ([[UIDevice currentDevice] systemVersion].floatValue>=7.0) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }



}
- (void)initTitle{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    view.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
    [self.view addSubview:view];

//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 50, 44)];
//    titleLabel.text = @"主页";
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.font = [UIFont systemFontOfSize:18];
//    [self.view addSubview:titleLabel];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 15, 18)];
    image.image = [UIImage imageNamed:@"return"];
    [self.view addSubview:image];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 20, 60, 44);

    [button addTarget:self action:@selector(homeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];


    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(60, 27, SCREEN_WIDTH - 80, 30)];
    textField.font = [UIFont systemFontOfSize:14];
    //    textField.placeholder = @"输入你要找的车型、车号、价格";
    UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Search"]];
    textField.rightView = imgv;
    textField.delegate = self;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textColor = [UIColor whiteColor];
    textField.backgroundColor = [UIColor colorWithRed:17/255.0 green:143/255.0 blue:218/255.0 alpha:1];
    [textField setReturnKeyType : UIReturnKeySearch ];
    textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"输入你要找的车型、车号、价格" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} ];
    textField.clearButtonMode = UITextFieldViewModeAlways;

    [self.view addSubview:textField];
}
- (void)homeButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}

//这个函数的最后一个参数text代表你每次输入的的那个字，所以：
- (BOOL)textView:(UITextField *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

// scrollView 重用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_containtView)
    {
        return;
    }
    @autoreleasepool
    {
        if (scrollView.tag == 99999)
        {
            if (scrollView.contentOffset.x >= DeviceWidth*2)
            {
                [self moveToRight];
            }
            else if (scrollView.contentOffset.x <= 0)
            {
                [self moveToLeft];
            }
        }
    }
}

// 首次进入的时候触发
- (void)enterFrist
{
    _next = nil;
    _current = nil;
    _last = nil;
    
    if (_selectIndex == -1)
    {
        _selectIndex = self.contentViewArr.count - 1;
    }
    
    _last = self.contentViewArr[_selectIndex];
    _selectIndex++;
    
    if (_selectIndex == self.contentViewArr.count)
    {
        _selectIndex = 0;
    }
    _current = self.contentViewArr[_selectIndex];
    
    NSInteger temp = 0;
    if (_selectIndex == self.contentViewArr.count - 1)
    {
        temp = 0;
    }
    else
    {
        temp = _selectIndex + 1;
    }
    
    _next = self.contentViewArr[temp];
    
    _last.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight - 108);
    _current.frame = CGRectMake(DeviceWidth, 0, DeviceWidth, DeviceHeight - 108);
    _next.frame = CGRectMake(DeviceWidth*2, 0, DeviceWidth, DeviceHeight - 108);
    
    [_containtView addSubview:_last];
    [_containtView addSubview:_current];
    [_containtView addSubview:_next];
    
    [_containtView setContentOffset:CGPointMake(DeviceWidth, 0)];
    
    _selectNum = _selectIndex;
    
}

// 正面移动跟定时跳动 相同部分
- (void)moveToRight
{
    _next = nil;
    _current = nil;
    _last = nil;
    
    _last = self.contentViewArr[_selectNum];
    _selectNum++;
    
    if (_selectNum == self.contentViewArr.count)
    {
        _selectNum = 0;
    }
    _current = self.contentViewArr[_selectNum];
    
    NSInteger temp = 0;
    if (_selectNum == self.contentViewArr.count - 1)
    {
        temp = 0;
    }
    else
    {
        temp = _selectNum + 1;
    }
    
    _next = self.contentViewArr[temp];
    
    [self publicInstallation];
}

// 反方向移动
- (void)moveToLeft
{
    _next = nil;
    _current = nil;
    _last = nil;
    
    if (_selectNum == self.content.titleArray.count)
    {
        _selectNum = 0;
    }
    
    _next = self.contentViewArr[_selectNum];
    _selectNum--;
    
    if (_selectNum == -1)
    {
        _selectNum = self.contentViewArr.count - 1;
    }
    
    _current = self.contentViewArr[_selectNum];
    
    NSInteger temp = 0;
    if (_selectNum == 0) {
        temp = self.contentViewArr.count-1;
    }
    else
    {
        temp = _selectNum - 1;
    }
    
    _last = self.contentViewArr[temp];
    

    
    [self publicInstallation];
}

- (void)publicInstallation
{
    _last.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight - 108);
    _current.frame = CGRectMake(DeviceWidth, 0, DeviceWidth, DeviceHeight - 108);
    _next.frame = CGRectMake(DeviceWidth*2, 0, DeviceWidth, DeviceHeight - 108);
    
    [_containtView addSubview:_last];
    [_containtView addSubview:_current];
    [_containtView addSubview:_next];
    
    [_containtView setContentOffset:CGPointMake(DeviceWidth, 0)];
    
    UIButton *button = (UIButton *)[_selectContaintView viewWithTag:_selectNum+1];
    for (UIButton *view in _selectContaintView.subviews)
    {
        if (view.tag == 0)
        {
            continue;
        }
        if (view.tag == button.tag)
        {
            UIColor *selectColor = self.titleSelectColor ? self.titleSelectColor : [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];;
            view.selected = YES;
            [view setTitleColor:selectColor forState:UIControlStateSelected];
        }
        else
        {
            UIColor *color = self.normalColor ? self.normalColor:[UIColor grayColor];
            view.selected = NO;
            [view setTitleColor:color forState:UIControlStateNormal];
        }
    }
    
    if (_isSelectImage)
    {
        [UIView animateWithDuration:.5 animations:^{
            _moveImageView.center = CGPointMake(button.center.x, self.imageHeight);
        } completion:nil];
    }
    else
    {
        [UIView animateWithDuration:.5 animations:^{
            _moveImageView.center = CGPointMake(button.center.x, self.imageHeight);
        } completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

