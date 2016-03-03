//
//  CommissionedToFindCarView.m
//  CarSource
//
//  Created by apple on 15/12/22.
//  Copyright © 2015年 apple. All rights reserved.
//
//委托找车
#import "CommissionedToFindCarView.h"

@interface CommissionedToFindCarView ()<UITextViewDelegate,UIScrollViewDelegate>{
    NSInteger _editing;
    UIScrollView *_scroll;
}
@property (nonatomic,strong)UITextView *textView;
@end

@implementation CommissionedToFindCarView
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
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
    _scroll.delegate = self;
    _scroll.bounces = NO;
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH, 540);
    _scroll.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];
    [self addSubview:_scroll];

    self.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];

    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    bgView.backgroundColor = [UIColor whiteColor];
    [_scroll addSubview:bgView];

    UIButton *demandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    demandBtn.frame = CGRectMake(80, 20, 50, 50);
    [demandBtn setImage:[UIImage imageNamed:@"Us"] forState:UIControlStateNormal];
    [_scroll addSubview:demandBtn];

    UILabel *demandLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 70, 60, 30)];
    demandLabel.text = @"填写需求";
    demandLabel.textColor = [UIColor grayColor];
    demandLabel.font = [UIFont systemFontOfSize:15];
    [_scroll addSubview:demandLabel];

    UIImageView *arrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(140, 40, SCREEN_WIDTH - 280 , 10)];
    arrowImage.image = [UIImage imageNamed:@"making"];
    [_scroll addSubview:arrowImage];

    UIButton * goldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goldBtn.frame = CGRectMake(SCREEN_WIDTH - 130, 20, 50, 50);
    [goldBtn setImage:[UIImage imageNamed:@"Deal"] forState:UIControlStateNormal];
    [_scroll addSubview:goldBtn];

    UILabel *goldLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 140, 70, 100, 30)];
    goldLabel.text = @"支付意向金";
    goldLabel.textColor = [UIColor grayColor];
    goldLabel.font = [UIFont systemFontOfSize:15];
    [_scroll addSubview:goldLabel];



    UIButton *customerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customerBtn.frame = CGRectMake(80, 130, 50, 50);
    [customerBtn setImage:[UIImage imageNamed:@"Talents"] forState:UIControlStateNormal];
    [_scroll addSubview:customerBtn];

    UILabel *customerLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 180, 60, 30)];
    customerLabel.text = @"客服确认";
    customerLabel.textColor = [UIColor grayColor];
    customerLabel.font = [UIFont systemFontOfSize:15];
    [_scroll addSubview:customerLabel];


    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(140, 150, SCREEN_WIDTH - 280 , 10)];
    arrow.image = [UIImage imageNamed:@"making"];
    [_scroll addSubview:arrow];

    UIButton *tradingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tradingBtn.frame = CGRectMake(SCREEN_WIDTH - 130, 130, 50, 50);
    [tradingBtn setImage:[UIImage imageNamed:@"The"] forState:UIControlStateNormal];
    [_scroll addSubview:tradingBtn];

    UILabel *lookingLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 160, 180, 150, 60)];
    lookingLabel.text = @"1.找到车，发起交易，意向金转为定金。 2.未找到，意向金即时退回";
    lookingLabel.numberOfLines = 0;
    lookingLabel.textColor = [UIColor grayColor];
    lookingLabel.font = [UIFont systemFontOfSize:14];
    [_scroll addSubview:lookingLabel];

    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(140, 40, SCREEN_WIDTH - 280 , 10)];
    lineImage.backgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];
    [bgView addSubview:lineImage];

    [lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(bgView).offset(@0);
        make.right.equalTo(bgView).offset(@0);
        make.height.equalTo(@1);
    }];


    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 270, SCREEN_WIDTH, 80)]; //初始化大小并自动释放
    self.textView.textColor = [UIColor grayColor];//设置textview里面的字体颜色
    self.textView.font = [UIFont fontWithName:@"Arial" size:14.0];//设置字体名字和字体大小
    self.textView.delegate = self;//设置它的委托方法
    self.textView.backgroundColor = [UIColor colorWithRed:241/255.0 green:251/255.0 blue:255/255.0 alpha:1];//设置它的背景颜色
    self.textView.layer.borderColor=[[UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1]CGColor];
    self.textView.layer.borderWidth= 1.0f;
    self.textView.text = @"请填写真实找车信息，包括：车型，颜色，配置，上牌区域等。收到后车信源客服会立即回电确认，放心交给我们吧。";//设置它显示的内容
    self.textView.returnKeyType = UIReturnKeyDone;//返回键的类型
    self.textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.textView.scrollEnabled = YES;//是否可以拖动
//    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    [_scroll addSubview: self.textView];//加入到整个页面中

    UIButton *determineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    determineBtn.frame = CGRectMake(40, 370, SCREEN_WIDTH -80, 50);
    [determineBtn setTitle:@"确定提交" forState:UIControlStateNormal];
    determineBtn.titleLabel.font = [UIFont systemFontOfSize: 18.0];
    determineBtn.layer.cornerRadius = 5;
    determineBtn.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
    determineBtn.layer.masksToBounds = YES;
    [determineBtn addTarget:self action:@selector(determineButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [_scroll addSubview:determineBtn];

}

- (void)textViewDidEndEditing:(UITextView *)textView {

    _scroll.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);

    _editing = 2;
    if ([textView.text isEqualToString:@""] || textView.text == nil) {
         _editing = 1;
        self.textView.text = @"请填写真实找车信息，包括：车型，颜色，配置，上牌区域等。收到后车信源客服会立即回电确认，放心交给我们吧。";//设置它显示的内容
    }


}
- (void)determineButtonClick:(UIButton *)button{
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    _scroll.frame = CGRectMake(0, -180, SCREEN_WIDTH, SCREEN_HEIGHT-114);
    if (_editing == 1) {
         self.textView.text = @"";
    }

    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    if ([text isEqualToString:@"\n"]) {

        [textView resignFirstResponder];

        return NO;

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
