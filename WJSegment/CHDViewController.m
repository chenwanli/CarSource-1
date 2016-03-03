
//
//  CHDViewController.m
//  CHDControllerScroll
//
//  Created by chd on 15-4-10.
//  Copyright (c) 2015年 chd. All rights reserved.
//
#define statusBar 44
#define Tablebar 0
#define TopScHeight 44
#define BottomScHeight [UIScreen mainScreen].bounds.size.height - TopScHeight - statusBar - Tablebar
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ButtonFont 16
#define LineHeght 3
//按钮之间的间隔
#define GapOfButton 20.0
#import "CHDViewController.h"

@interface CHDViewController ()
{
    UIScrollView *topScroll;
    UIScrollView *bottomScroll;
    UILabel *line;
    NSMutableArray *centerArr;
    NSMutableArray *widthArr;
    float lastP;
    NSInteger FinalPage;
    BOOL isBtnClick;
}
@end

@implementation CHDViewController
- (id)init
{
    self = [super init];
    if ([super init]) {
        self.ScrollControllersArr = [NSMutableArray array];
        self.nameArr = [NSMutableArray array];
        centerArr = [NSMutableArray array];
        widthArr = [NSMutableArray array];
        line = [[UILabel alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR;
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 15, 18)];
    image.image = [UIImage imageNamed:@"return"];
    [self.view addSubview:image];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 80, 50);
//    [button setImage:[UIImage imageNamed:@"return"] forState: UIControlStateNormal];
    [button addTarget:self action:@selector(returnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 15, 200 , 40)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = _titleStr;
    [self.view addSubview:_titleLabel];

    [self setUI];

    // Do any additional setup after loading the view.
}
- (void)returnButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setUI
{
    topScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, statusBar, ScreenWidth, TopScHeight)];
    topScroll.showsHorizontalScrollIndicator = NO;
//    topScroll.backgroundColor = COLOR ;
    //根据传入字符串创建按钮，并计算contentSize
    //按钮的高与TopScroll一致
    float contenX = GapOfButton;
    for (int i =0 ; i < _nameArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:_nameArr[i] forState:UIControlStateNormal];
        button.titleLabel.font  = [UIFont systemFontOfSize:ButtonFont];
        CGSize size = [button.currentTitle sizeWithFont:[UIFont systemFontOfSize:ButtonFont] constrainedToSize:CGSizeMake(1000, 40)];
        button.frame = CGRectMake(contenX, 0, size.width, TopScHeight - 4);
        //button.backgroundColor = [UIColor orangeColor];
        contenX = button.frame.origin.x + size.width + GapOfButton;
        button.tag = 200 + i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [topScroll addSubview:button];
        NSNumber *num = [NSNumber numberWithFloat:button.center.x];
        [centerArr addObject:num];
        NSNumber *num2 = [NSNumber numberWithFloat:button.frame.size.width];
        [widthArr addObject:num2];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    topScroll.contentSize = CGSizeMake(contenX, TopScHeight);
    [self.view addSubview:topScroll];
    NSNumber *num = [centerArr firstObject];
    NSNumber *num2 = [widthArr firstObject];
    line.frame = CGRectMake(num.floatValue - num2.floatValue/2, TopScHeight - LineHeght, num2.floatValue, LineHeght);
    [topScroll addSubview:line];
    line.backgroundColor = [UIColor blueColor];
//    NSLog(@"%@",NSStringFromCGRect(line.frame));
    
    
    bottomScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, statusBar+TopScHeight, ScreenWidth, BottomScHeight)];
    bottomScroll.delegate = self;
    [self.view addSubview:bottomScroll];
    bottomScroll.contentSize = CGSizeMake(ScreenWidth * _ScrollControllersArr.count, BottomScHeight);
    bottomScroll.pagingEnabled = YES;
    bottomScroll.clipsToBounds = YES;
    bottomScroll.bounces = NO;
    int j =0 ;
    for (UIViewController *controller in _ScrollControllersArr) {
        controller.view.frame = CGRectMake(ScreenWidth * j , 0, ScreenWidth, BottomScHeight);
        //NSLog(@"%@",NSStringFromCGRect(controller.view.frame));
        [bottomScroll addSubview:controller.view];
        
        
        j++;
    }

    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!isBtnClick) {
        float needChange = 0;
        int a =0;
        for (int i =0;i<centerArr.count;i++) {
            NSNumber *num = centerArr[i];
            
            if (num.floatValue >= line.center.x) {
//                NSLog(@"num--%f  line ---%f",num.floatValue,line.center.x);
                
                if (i-1>=0) {
                    needChange = [centerArr[i] floatValue] - [centerArr[i-1] floatValue];
                    //NSLog(@"%f",needChange);
                    a = i;
                    break;
                }
            }
        }
        
        float offset = 0;
        offset = needChange/ScreenWidth *(scrollView.contentOffset.x - (a -1) *ScreenWidth);
        if (a != 0) {
            line.center = CGPointMake([centerArr[a -1] floatValue] +  offset, TopScHeight - LineHeght/2.0);
        }
        line.bounds = CGRectMake(0, 0, [widthArr[a -1] floatValue] + ([widthArr[a] floatValue] - [widthArr[a - 1] floatValue])/ScreenWidth *(scrollView.contentOffset.x - (a -1) *ScreenWidth), LineHeght);
        lastP = scrollView.contentOffset.x;
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        FinalPage = (NSInteger)scrollView.contentOffset.x/ScreenWidth;
        [self changeTop];
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    FinalPage = (NSInteger)scrollView.contentOffset.x/ScreenWidth;
    [self changeTop];
}
- (void)changeTop
{
    isBtnClick = NO;
    float x = [centerArr[FinalPage] floatValue];
    [UIView animateWithDuration:0.3 animations:^{
        if (x>ScreenWidth/2.0&&x<topScroll.contentSize.width - ScreenWidth/2.0) {
            topScroll.contentOffset = CGPointMake(x-ScreenWidth/2.0, 0);
        }
        else if (x>=topScroll.contentSize.width - ScreenWidth/2.0) {
            topScroll.contentOffset = CGPointMake(topScroll.contentSize.width - ScreenWidth, 0);
        }
        else{
            topScroll.contentOffset = CGPointMake(0, 0);
        }
        
    }];
    
    NSLog(@"%ld",FinalPage);
    [self initTag:FinalPage];
}
- (void)btnClick:(UIButton *)button
{
    isBtnClick = YES;
    FinalPage = button.tag - 200;
    
    [self changeBottom];
    [self changeTop];
    //[self changeLine];
    //[self changeLineWithBtn:button];
    [self changeLine];
    
}
- (void)initTag:(NSInteger)tag{
    
   

}
- (void)changeLineWithBtn:(UIButton *)btn
{
    [UIView animateWithDuration:0.3 animations:^{
        line.bounds = CGRectMake(0, 0, btn.frame.size.width, LineHeght);
        line.center = CGPointMake(btn.center.x, TopScHeight - LineHeght/2.0);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)changeLine
{
    [UIView animateWithDuration:0.3 animations:^{
//        line.center = CGPointMake([centerArr[FinalPage] floatValue], TopScHeight - LineHeght/2.0);
//        line.bounds = CGRectMake(0, 0, [widthArr[FinalPage] floatValue], LineHeght);
        line.frame = CGRectMake([centerArr[FinalPage] floatValue] -[widthArr[FinalPage] floatValue]/2.0, TopScHeight - LineHeght, [widthArr[FinalPage] floatValue], LineHeght);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)changeBottom
{
    [UIView animateWithDuration:0.3 animations:^{
        bottomScroll.contentOffset = CGPointMake(ScreenWidth *FinalPage, 0);
    } completion:^(BOOL finished) {
        
    }];
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
