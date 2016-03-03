//
//  HomeViewController.m
//  CarSource
//
//  Created by apple on 15/12/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "CommissionedView.h"
#import "CarPicturesView.h"
#import "ModelsContrastView.h"
#import "TrailerServiceView.h"
#import "CommissionedToFindCarView.h"

@interface HomeViewController ()<UITextFieldDelegate>
@property (nonatomic, retain)NSMutableArray *contentViews;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
     self.contentViews = [NSMutableArray array];
    [self initTitle];

    CommissionedView *commissioned = [[CommissionedView alloc]initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104-49)];
    [self.view addSubview:commissioned];

    commissioned.pkResults = ^(NSString *pkResults){

        self.pkResults(pkResults);

    };
    commissioned.promotion = ^(NSInteger promotion,NSMutableArray *array){
        self.promotionUrl(promotion,array);
    };
}
- (void)initTitle{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    view.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
    [self.view addSubview:view];

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 60, 44)];
    titleLabel.text = @"车信源";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:titleLabel];

    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(80, 27, SCREEN_WIDTH - 100, 30)];
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

    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
//    bgview.backgroundColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:238/255.0 alpha:1];
    [self.view addSubview:bgview];
      NSArray *array = @[@"汽车图片",@"车型对比",@"拖车服务"];

    for (int i = 0; i <array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(SCREEN_WIDTH/array.count *i, 64, SCREEN_WIDTH/array.count, 39);
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
         button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        button.tag = i +1;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 103, SCREEN_WIDTH, 1)];
    lineImage.backgroundColor = [UIColor colorWithRed:215/255.0 green:234/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:lineImage];


}
- (void)buttonClick:(UIButton *)button{

    self.homeIndex(button.tag,_contentViews);

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
