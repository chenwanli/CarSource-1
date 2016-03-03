//
//  BulkImportView.m
//  CarSource
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//
// 批量导入
#import "BulkImportView.h"
@interface BulkImportView ()
{

}

@end

@implementation BulkImportView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    UIImageView *bgIamge = [[UIImageView alloc]init];
    bgIamge.backgroundColor = GRAY;
    [self addSubview:bgIamge];
    
    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"长按链接复制" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitButton];

    UITextView *textview = [[UITextView alloc] init];
    textview.backgroundColor=[UIColor whiteColor]; //背景色
    textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    textview.editable = NO;        //是否允许编辑内容，默认为“YES”
    textview.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    textview.layer.borderWidth = 1.0;
    textview.textColor = [UIColor grayColor];
    textview.layer.cornerRadius = 5;
    textview.layer.masksToBounds = YES;
    textview.textAlignment = UIControlContentHorizontalAlignmentCenter;
    textview.text = @"www.chexinyuan.cn.com";

    textview.font=[UIFont fontWithName:@"Arial" size:15.0]; //设置字体名字和字体大小;
    textview.returnKeyType = UIReturnKeyDone;//return键的类型
    textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    //    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    textview.textColor = [UIColor grayColor];
    //    textview.text = @"UITextView详解";//设置显示的文本内容
    [self addSubview:textview];

    UIImageView *imageView= [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"process"];
    [self addSubview:imageView];

    [bgIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@70);
    }];

    [textview makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@20);
        make.right.equalTo(self).offset(- 120);
        make.height.equalTo(@30);
    }];

    [submitButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.right.equalTo(self).offset(- 10);
        make.size.equalTo(CGSizeMake(100, 30));
    }];

    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@70);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@230);
    }];


}
- (void)submitButtonClick{

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
