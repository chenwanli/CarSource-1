//
//  PasswordBouncedView.m
//  CarSource
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//
#define ZCKeyboardBtnCount 12
#define KEYBOARD_HEIGHT ((SCREEN_WIDTH * 0.14375)*4 + (SCREEN_WIDTH * 0.015625)*4 + 10)

#import "PasswordBouncedView.h"
@interface PasswordBouncedView (){

    UIView *_bgView;
    NSMutableArray *_passwordArray;
    UIView *_bouncedView;
    UIView *_keyboard;

}
@end
@implementation PasswordBouncedView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgView.backgroundColor = [UIColor grayColor];
    _bgView.alpha = 0.5;
    [self addSubview:_bgView];

    _passwordArray = [[NSMutableArray alloc]init];

    [self initpasswordView];

    [self setupAllBtns];

    
}
- (void)initpasswordView{

    [_bouncedView removeFromSuperview];

    _bouncedView = [[UIView alloc]initWithFrame:CGRectMake(20, 150, SCREEN_WIDTH -40, (SCREEN_WIDTH -60)/6 +40 )];
    _bouncedView.backgroundColor = [UIColor whiteColor];
    _bouncedView.layer.cornerRadius = 5;
    _bouncedView.layer.masksToBounds = YES;
    [self addSubview:_bouncedView];

       for (int i = 0; i < 6; i++) {
        UIButton *passwordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        passwordBtn.frame = CGRectMake((SCREEN_WIDTH -60)/6*i +10, 20, (SCREEN_WIDTH -60)/6+1, (SCREEN_WIDTH -60)/6+1);
        if (i < _passwordArray.count) {
            [passwordBtn setBackgroundImage:[UIImage imageNamed:@"esy"] forState:UIControlStateNormal];
        }else{
            [passwordBtn setBackgroundImage:[UIImage imageNamed:@"sugars"] forState:UIControlStateNormal];
        }

        [passwordBtn addTarget:self action:@selector(passwordClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bouncedView addSubview:passwordBtn];
    }
}
/** 添加所有按键 */
- (void)setupAllBtns
{
    _keyboard = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - KEYBOARD_HEIGHT, SCREEN_WIDTH, KEYBOARD_HEIGHT)];
    _keyboard.backgroundColor = [UIColor whiteColor];
    [self addSubview:_keyboard];
    // 定义总列数
    NSInteger totalCol = 3;

    // 定义间距
    CGFloat pad = SCREEN_WIDTH * 0.015625;

    // 定义x y w h
    CGFloat x;
    CGFloat y;
    CGFloat w = SCREEN_WIDTH * 0.3125;
    CGFloat h = SCREEN_WIDTH * 0.14375;

    // 列数 行数
    NSInteger row;
    NSInteger col;

    for (int i = 0; i < ZCKeyboardBtnCount; i++) {
        row = i / totalCol;
        col = i % totalCol;
        x = pad + col * (w + pad);
        y = row * (h + pad) + pad;

        // 创建按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, w, h);
        [_keyboard addSubview:btn];
        // 按钮音效监听
        [btn addTarget:self action:@selector(playTock) forControlEvents:UIControlEventTouchDown];
        // 按钮公共属性
        [btn setBackgroundImage:[UIImage imageNamed:@"trade.bundle/number_bg"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

        if (i == 9) {  // 取消按钮
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH * 0.046875];
            [btn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        } else if (i == 10) {  // 0 按钮
            [btn setTitle:@"0" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:SCREEN_WIDTH * 0.06875];
            btn.tag = 0;
            [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        } else if (i == 11) {  // 删除按钮
            [btn setTitle:@"删除" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH * 0.046875];
            [btn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        } else {  // 其他数字按钮
            [btn setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:SCREEN_WIDTH * 0.06875];
            btn.tag = i + 1;
            [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)cancelButtonClick{
    self.cancelBtn(nil);
}
//键盘弹起
- (void)passwordClick:(UIButton *)button{

//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        _keyboard.frame = CGRectMake(0, SCREEN_HEIGHT - KEYBOARD_HEIGHT, SCREEN_WIDTH, KEYBOARD_HEIGHT);
//    } completion:^(BOOL finished) {
//
//    }];
}

- (void)playTock{

}
//键盘下去
- (void)okBtnClick{
//
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        _keyboard.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, KEYBOARD_HEIGHT);
//    } completion:^(BOOL finished) {
//
//    }];

}
- (void)numBtnClick:(UIButton *)button{

//    if (_passwordArray.count < 6) {
        [_passwordArray addObject:[NSString stringWithFormat:@"%ld",button.tag]];
        [self initpasswordView];

    if (_passwordArray.count == 6) {
        self.password(_passwordArray);
    }
//    }else{
//        SHOW_ALERT(@"只能输入六位数密码")
//    }



}
- (void)deleteBtnClick{

    if (_passwordArray.count != 0) {
        for (int i = 0; i<_passwordArray.count ; i++) {
            if (_passwordArray.count -1 == i) {
                [_passwordArray removeObjectAtIndex:i];
                //                NSLog(@",button.tag = %@",_passwordArray);
                [self initpasswordView];
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
