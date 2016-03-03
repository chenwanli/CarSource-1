//
//  ParallelView.m
//  CarSource
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ParallelView.h"
#import "RulesCarViewCell.h"

@interface ParallelView ()<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITableView *_rulesTable;
    NSMutableArray *_rulesArray;
    UITextView *_textview;
    NSInteger _editing;
    UIButton *_btn;
    NSString *_typeStr;
    NSString *_colorStr;
}

@end

@implementation ParallelView
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
    _typeStr = @"美规 奥迪A7 15款豪华版";
    _colorStr = @"黑／白";
    _rulesArray = [[NSMutableArray alloc]initWithObjects:@"选择车型", @"颜色",@"卖哪里",@"1",nil];
    _rulesTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _rulesTable.delegate = self;
    // 设置数据源
    _rulesTable.dataSource = self;
    _rulesTable.bounces = NO;
    _rulesTable.backgroundColor = GRAY;
    _rulesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self addSubview:_rulesTable];

    [self initRulesCarRulesTableFooterView];
}
- (void)initTypeStr:(NSString *)typeStr{
    _typeStr = typeStr;
    [_rulesTable reloadData];
}
- (void)initColorStr:(NSString *)colorStr{
    _colorStr = colorStr;
    [_rulesTable reloadData];
}

- (void)initRulesCarRulesTableFooterView{

    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    footerView.backgroundColor = GRAY;

    NSArray *depositArray = [[NSArray alloc]initWithObjects:@"定金寻车",@"普通提交", nil];

    for (int i = 0; i<depositArray.count; i++) {

        UIButton *depositButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [depositButton setTitle:[depositArray objectAtIndex:i] forState:UIControlStateNormal];
        depositButton.frame = CGRectMake(50,50 + 60 *i, SCREEN_WIDTH - 100, 44);
        depositButton.titleLabel.font = [UIFont systemFontOfSize:16];
        depositButton.layer.borderColor = COLOR.CGColor;
        depositButton.layer.borderWidth = 1.0;
        depositButton.layer.cornerRadius = 5;
        depositButton.layer.masksToBounds = YES;
        [depositButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [depositButton setTitleColor:COLOR forState:UIControlStateNormal];
        [depositButton setBackgroundImage:[UIImage imageNamed:@"obvious"] forState:UIControlStateSelected];

        [depositButton setBackgroundImage:[UIImage imageNamed:@"Reports"] forState:UIControlStateNormal];

        [depositButton addTarget:self action:@selector(depositButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:depositButton];
        if (i == 1) {
            [self depositButtonClick:depositButton];
        }


    }
    _rulesTable.tableFooterView = footerView;


}
- (void)membersButtonClick:(UIButton *)button{
    self.members(nil);
}
- (void)depositButtonClick:(UIButton *)button{

    _btn.selected = NO;
    button.selected = YES;
    _btn = button;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return _rulesArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"Cell";
    RulesCarViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[RulesCarViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        switch (indexPath.row) {
            case 0:
            {
                [cell initRulesCarViewCell];
            }
                break;
            case 1:
            {
                [cell initRulesCarViewCellChooseColor];
            }
                break;

            case 3:
            {
                //初始化并定义大小
                _textview = [[UITextView alloc] initWithFrame:CGRectMake(36, 10, SCREEN_WIDTH -46, 150)];
                _textview.backgroundColor=[UIColor whiteColor]; //背景色
                _textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
                _textview.editable = YES;        //是否允许编辑内容，默认为“YES”
                _textview.delegate = self;       //设置代理方法的实现类
                //                _textview.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
                //                _textview.layer.borderWidth = 1.0;
                _textview.textColor = [UIColor grayColor];

                _textview.text = @"请输入详细的寻车需求，包括配置，价格需求，提车时间，现车期货等...";

                _textview.font=[UIFont fontWithName:@"Arial" size:15.0]; //设置字体名字和字体大小;
                _textview.returnKeyType = UIReturnKeyDone;//return键的类型
                _textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
                _textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
                //    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
                _textview.textColor = [UIColor grayColor];
                //    textview.text = @"UITextView详解";//设置显示的文本内容
                [cell addSubview:_textview];

            }
                break;


            default:
                break;
        }

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = GRAY;
    cell.guidedLabel.text = @"指导价：88.88万";

    [cell.typeButton setTitle:_typeStr forState:UIControlStateNormal];
    [cell.colorBtn setTitle:_colorStr forState:UIControlStateNormal];

    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row +1];
    if (indexPath.row != 3) {
        cell.typeLabel.text = [_rulesArray objectAtIndex:indexPath.row];
    }else{
        cell.typeLabel.hidden = YES;
        cell.milledImage.hidden = YES;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.rulesCar(indexPath.row);


}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return 70;
        }
            break;
        case 1:
        {
            return 60;
        }
            break;

        case 2:
        {
            return 60;
        }
            break;

        case 3:
        {
            return 160;
        }
            break;
        default:
            break;
    }
    return 0;
}
//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    if (_editing == 1) {
        _textview.text = @"";
        _textview.textColor = [UIColor blackColor];
    }

    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    _editing = 2;
    if ([textView.text isEqualToString:@""] || textView.text == nil ) {
        _editing = 1;
        _textview.text = @"请输入详细的寻车需求，包括配置，价格需求，提车时间，现车期货等...";
        _textview.textColor = [UIColor grayColor];
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
