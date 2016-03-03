//
//  GuaranteeDetailsViewCell.m
//  CarSource
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GuaranteeDetailsViewCell.h"

@interface GuaranteeDetailsViewCell ()<UITextFieldDelegate,UITextViewDelegate>{
    NSInteger _editing;
}

@end
@implementation GuaranteeDetailsViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
         _editing = 1;
        [self awakeFromNib];

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    _typeLabel = [[UILabel alloc]init];
    _typeLabel.textColor = BLACK;
    _typeLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_typeLabel];

    _image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44, SCREEN_WIDTH-20, 1)];
    _image.backgroundColor = LIGHTBLUE;
    [self addSubview:_image];


    [_typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@10);
        make.size.equalTo(CGSizeMake(70, 44));
    }];

    [_image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.bottom.equalTo(@0);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@1);
    }];

}
- (void)initGuaranteeDetailsViewCell{

    [_chooseLabel removeFromSuperview];

    UIImageView *image = (UIImageView *)[self viewWithTag:10];
    [image removeFromSuperview];

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.tag = 10;
    imageView.image = [UIImage imageNamed:@"milled"];
    [self addSubview:imageView];

    _chooseLabel = [[UILabel alloc]init];
    _chooseLabel.textColor = COLOR;
    _chooseLabel.textAlignment = NSTextAlignmentRight;
    _chooseLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_chooseLabel];

    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@13);
        make.right.equalTo(self).offset(-10);
        make.size.equalTo(CGSizeMake(15, 18));
    }];
    [_chooseLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(90);
        make.bottom.equalTo(@0);
        make.right.equalTo(self).offset(-25);
        make.height.equalTo(@44);
    }];

}
- (void)initGuaranteeDetailsViewCellUnitText:(NSString *)unitText placeholder:(NSString *)placeholder{

    UILabel *label = (UILabel *)[self viewWithTag:11];
    [label removeFromSuperview];

    UILabel *unitLabel = [[UILabel alloc]init];
    unitLabel.textColor = [UIColor grayColor];
    unitLabel.text = unitText;
    unitLabel.tag = 11;
    unitLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:unitLabel];

    [self.numberField removeFromSuperview];
    self.numberField = [[UITextField alloc]init];
    self.numberField.font = [UIFont systemFontOfSize:15];
    self.numberField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.numberField.textAlignment = UIControlContentHorizontalAlignmentRight;
    //    _textField.borderStyle = UITextBorderStyleRoundedRect;
    self.numberField.textColor = [UIColor grayColor];
    self.numberField.placeholder = placeholder;
    //    _numberField.backgroundColor = [UIColor yellowColor];
    self.numberField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.numberField setReturnKeyType : UIReturnKeyDone ];
    //    _numberField.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:self.numberField];
    
    [self.numberField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.top.equalTo(@2);
        make.right.equalTo(self).offset(-35);
        make.height.equalTo(@40);
    }];

    [unitLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(-10);
        make.size.equalTo(CGSizeMake(20, 44));
    }];



}
- (void)initTextView{
    UIImageView *image = (UIImageView *)[self viewWithTag:13];
    [image removeFromSuperview];

    UIImageView *bgImage = [[UIImageView alloc]init];
    bgImage.tag = 13;
    bgImage.backgroundColor = GRAY;
    [self addSubview:bgImage];

    UIImageView *img = (UIImageView *)[self viewWithTag:14];
    [img removeFromSuperview];
    UIImageView *whiteImage = [[UIImageView alloc]init];
    whiteImage.tag = 14;
    whiteImage.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteImage];

    self.textview = [[UITextView alloc] init];
    self.textview.tag = 15;
    self.textview.backgroundColor=[UIColor whiteColor]; //背景色
    self.textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    self.textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    self.textview.delegate = self;       //设置代理方法的实现类
    self.textview.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    self.textview.layer.borderWidth = 1.0;
    self.textview.textColor = [UIColor grayColor];
    self.textview.text = @"请输入其他约定的内容";
    self.textview.font=[UIFont fontWithName:@"Arial" size:15.0]; //设置字体名字和字体大小;
    self.textview.returnKeyType = UIReturnKeyDone;//return键的类型
    self.textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    //    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    self.textview.textColor = [UIColor grayColor];
    //    textview.text = @"UITextView详解";//设置显示的文本内容
    [self addSubview:self.textview];

    [bgImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@170);
    }];

    [whiteImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@150);
    }];

    [self.textview makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@20);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@130);
    }];

}
//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    if (_editing == 1) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }

    return YES;
}

//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
}

//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{

    self.guarantee (textView.text);
    
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    _editing = 2;
    if ([textView.text isEqualToString:@""] || textView.text == nil ) {
        _editing = 1;
        textView.text = @"请输入其他约定的内容";
        textView.textColor = [UIColor grayColor];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
