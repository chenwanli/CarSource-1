//
//  TrailerServiceView.m
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "TrailerServiceView.h"
#import "TrailerServiceViewCell.h"
//拖车服务
@implementation TrailerServiceView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    _serviceTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, self.frame.size.height-60) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _serviceTable.delegate = self;
    // 设置数据源
    _serviceTable.dataSource = self;
    _serviceTable.bounces = NO;
    _serviceTable.rowHeight = 90;
//    _serviceTable.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];
//    _serviceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self addSubview:_serviceTable];

    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH - 20, 30)];
    textField.font = [UIFont systemFontOfSize:14];
    //    textField.placeholder = @"输入你要找的车型、车号、价格";
    UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"did"]];
    textField.leftView = imgv;
    textField.delegate = self;

    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textColor = [UIColor whiteColor];
    textField.placeholder = @"请选择你所在的城市名";
    textField.backgroundColor = [UIColor whiteColor];
    [textField setReturnKeyType : UIReturnKeySearch ];
//    textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"输入你要找的车型、车号、价格" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} ];
    textField.clearButtonMode = UITextFieldViewModeAlways;

    [self addSubview:textField];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 20, SCREEN_WIDTH - 20, 30);

    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];



}
- (void)buttonClick:(UIButton *)button{
    self.searchProvinces(nil);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}

//这个函数的最后一个参数text代表你每次输入的的那个字，所以：
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }

    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 9;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    TrailerServiceViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[TrailerServiceViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.phoneBtn.tag = indexPath.row;
    [cell.phoneBtn addTarget:self action:@selector(phoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
    
}
- (void)phoneButtonClick:(UIButton *)button{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",@"18689620485"]]];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
