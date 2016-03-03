//
//  ShowroomViewCell.m
//  CarSource
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShowroomViewCell.h"

@implementation ShowroomViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self awakeFromNib];

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code

    self.showroomLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 50)];
    self.showroomLabel.textColor = BLACK;
    self.showroomLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.showroomLabel];

    self.textview = [[UITextView alloc] init];
    self.textview.backgroundColor=[UIColor whiteColor]; //背景色
    self.textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    self.textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    self.textview.textColor = [UIColor grayColor];
    self.textview.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    self.textview.layer.borderWidth = 1.0;
    self.textview.font=[UIFont fontWithName:@"Arial" size:15.0]; //设置字体名字和字体大小;
    self.textview.returnKeyType = UIReturnKeyDone;//return键的类型
    self.textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    [self addSubview:self.textview];


}
- (void)initShowroomViewCellIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            self.textview.frame =CGRectMake(90, 10, SCREEN_WIDTH - 100, 30);
        }
            break;
        case 1:
        {
            self.textview.frame =CGRectMake(90, 10, SCREEN_WIDTH - 100, 50);
        }
            break;
        case 2:
        {
            self.textview.frame =CGRectMake(90, 10, SCREEN_WIDTH - 100, 140);
        }
            break;
       
        default:
            break;
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
