//
//  SetPasswordViewController.m
//  CarSource
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//
//设置密码
#define ZCKeyboardBtnCount 12
#define KEYBOARD_HEIGHT ((SCREEN_WIDTH * 0.14375)*4 + (SCREEN_WIDTH * 0.015625)*4 + 10)

#import "SetPasswordViewController.h"

@interface SetPasswordViewController ()<UITextFieldDelegate>{
    UITextField *_passwordText;
    UIView *_keyboard;
    UIView *_setView;
    UIView *_passwordView;
    NSMutableArray *_passwordArray;
}

@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];
    _passwordArray = [[NSMutableArray alloc]init];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"设置密码";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    [self initSetPasswordView];
}
- (void)initSetPasswordView{

    _setView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_HEIGHT, (SCREEN_WIDTH -60)/6 +80)];
    _setView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_setView];

    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, SCREEN_WIDTH - 60, 30)];
    passwordLabel.textAlignment = NSTextAlignmentCenter;
    passwordLabel.textColor = [UIColor grayColor];
    passwordLabel.font = [UIFont systemFontOfSize:16];
    passwordLabel.text = @"请输入六位数密码，用于加密支付";
    [_setView addSubview:passwordLabel];


    [self setupAllBtns];
    [self initpasswordView];

    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(50,240, SCREEN_WIDTH - 100, 50);
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18];

    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];

}
// 提交
- (void)submitButtonClick:(UIButton *)button{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _keyboard.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, KEYBOARD_HEIGHT);
    } completion:^(BOOL finished) {
        
    }];


}
- (void)initpasswordView{

    _passwordView = [[UIView alloc]initWithFrame:CGRectMake(30, 60, SCREEN_WIDTH -60, (SCREEN_WIDTH -60)/6)];
    [_setView addSubview:_passwordView];
        for (int i = 0; i < 6; i++) {
            UIButton *passwordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            passwordBtn.frame = CGRectMake((SCREEN_WIDTH -60)/6*i, 0, (SCREEN_WIDTH -60)/6+1, (SCREEN_WIDTH -60)/6+1);
            if (i < _passwordArray.count) {
                [passwordBtn setBackgroundImage:[UIImage imageNamed:@"esy"] forState:UIControlStateNormal];
            }else{
                [passwordBtn setBackgroundImage:[UIImage imageNamed:@"sugars"] forState:UIControlStateNormal];
            }

            [passwordBtn addTarget:self action:@selector(passwordClick:) forControlEvents:UIControlEventTouchUpInside];
            [_passwordView addSubview:passwordBtn];
        }
}
/** 添加所有按键 */
- (void)setupAllBtns
{
    _keyboard = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, KEYBOARD_HEIGHT)];
    _keyboard.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_keyboard];

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

        if (i == 9) {  // 确定按钮
            [btn setTitle:@"确定" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH * 0.046875];
            [btn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
//键盘弹起
- (void)passwordClick:(UIButton *)button{

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _keyboard.frame = CGRectMake(0, SCREEN_HEIGHT - KEYBOARD_HEIGHT, SCREEN_WIDTH, KEYBOARD_HEIGHT);
    } completion:^(BOOL finished) {

    }];
}

- (void)playTock{

}
//键盘下去
- (void)okBtnClick{

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _keyboard.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, KEYBOARD_HEIGHT);
    } completion:^(BOOL finished) {

    }];

}
- (void)numBtnClick:(UIButton *)button{

    if (_passwordArray.count < 6) {
        [_passwordArray addObject:[NSString stringWithFormat:@"%ld",button.tag]];
//        NSLog(@",button.tag = %ld",button.tag);
         [_passwordView removeFromSuperview];
        [self initpasswordView];
    }else{
        SHOW_ALERT(@"只能输入六位数密码")
    }



}
- (void)deleteBtnClick{

    if (_passwordArray.count != 0) {
        for (int i = 0; i<_passwordArray.count ; i++) {
            if (_passwordArray.count -1 == i) {
                [_passwordArray removeObjectAtIndex:i];
//                NSLog(@",button.tag = %@",_passwordArray);
                [_passwordView removeFromSuperview];
                [self initpasswordView];
            }
        }
    }
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        _keyboard.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 208);
//    } completion:^(BOOL finished) {
//
//    }];
//}



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
