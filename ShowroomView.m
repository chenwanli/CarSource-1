//
//  ShowroomView.m
//  CarSource
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShowroomView.h"
#import "ExhibitionModel.h"
#import "ShowroomViewCell.h"

@interface ShowroomView ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UITextView *_textview;
    UITableView *_showroomTable;
    NSArray *_textArray;
    NSMutableArray *_array;
    UIView *_submitView;
    NSString *_addressStr;
    NSString *_empiricalStr;
    NSString *_introduction;
    NSString *_showroomId;
}
@property (nonatomic,strong)UILabel *label;
@end
@implementation ShowroomView
- (id)initWithFrame:(CGRect)frame array:(NSMutableArray *)array showroomId:(NSString *)showroomId
{
    self = [super initWithFrame:frame];
    if (self) {

        _addressStr= @"";
        _introduction = @"";
        _empiricalStr = @"";
        _showroomId = showroomId;
        [self awakeFromNibArray:array];
    }
    return self;
}
- (void)awakeFromNibArray:(NSMutableArray *)array{

    _array = array;

    _textArray = [[NSArray alloc]initWithObjects:@"工作经验:", @"公司地址:",@"展车介绍:",nil];

    _showroomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _showroomTable.delegate = self;
    // 设置数据源
    _showroomTable.dataSource = self;
    //    _exhibitionTable.bounces = NO;
    _showroomTable.backgroundColor = GRAY;
    _showroomTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self addSubview:_showroomTable];

    _submitView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    _submitView.backgroundColor = GRAY;


    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"确定修改" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(50,30, SCREEN_WIDTH - 100, 50);
    submitButton.titleLabel.font = [UIFont systemFontOfSize:20];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_submitView addSubview:submitButton];

    _showroomTable.tableFooterView = _submitView;

}
- (void)submitButtonClick{

//    NSLog(@"  %@  %@  %@", _addressStr,_empiricalStr,_introduction);

    if ([_addressStr isEqualToString:@""] && [_empiricalStr isEqualToString:@""] && [_introduction isEqualToString:@""]  ) {
        SHOW_ALERT(@"请填写你要修改的内容")
        return;
    }

    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
     [LCCoolHUD showLoading:@"正在修改，请稍等" inView:self];
    [NetworkRequest postModifyTheShowroomRequestWithUserId:login.userId showroomId:_showroomId introduction:_introduction address:_addressStr empirical:_empiricalStr Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
        [LCCoolHUD hideInView:self];
        if ([errorMessage isEqualToString:@"0"] ) {

            [LCCoolHUD showSuccess:@"修改成功" zoom:YES shadow:YES];
            self.showroom(nil);
        }
        
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    ShowroomViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ShowroomViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];

     ExhibitionModel *model = [_array objectAtIndex:0];
    cell.showroomLabel.text = [_textArray objectAtIndex:indexPath.row];
    cell.textview.delegate = self;
    cell.textview.tag = indexPath.row +1;
    switch (indexPath.row) {
        case 0:
        {
            cell.textview.text = [NSString stringWithFormat:@"%@",model.showroomEmpirical];
            cell.textview.scrollEnabled = NO;
        }
            break;
        case 1:
        {
            cell.textview.text = [NSString stringWithFormat:@"%@",model.showrooAddress];
        }
            break;

        case 2:
        {
            cell.textview.text = [NSString stringWithFormat:@"%@",model.showroomBriefIntroduction];
        }
            break;

        default:
            break;
    }
    [cell initShowroomViewCellIndex:indexPath.row];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
        case 0:
        {
            return 50;
        }
            break;
            case 1:
        {
            return 70;
        }
            break;

        case 2:
        {
            return 160;
        }
            break;

        default:
            break;
    }

    return 0;
    
}
//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    if (![textView.text isEqualToString:@""] || textView.text != nil ) {
        switch (textView.tag) {
            case 1:
            {
                _empiricalStr = textView.text;;
            }
                break;
            case 2:
            {
                 _addressStr = textView.text;
            }
                break;
            case 3:
            {
                _introduction = textView.text;
            }
                break;
            default:
                break;
        }
    }
}
- (void)textViewDidChange:(UITextView *)textView{
//    NSLog(@"te    xtView.text = %@",textView.text);
    if (textView.tag == 3) {
//        NSString *temp = [textView.text
//                          stringByReplacingCharactersInRange:range
//                          withString:text];
        NSInteger remainTextNum = 100;
        //计算剩下多少文字可以输入
        if(textView.text.length>=100)

        {
            remainTextNum = 0;
            NSString *newString = [textView.text substringWithRange:NSMakeRange(0, 100)];
            textView.text = newString;
//            SHOW_ALERT(@"请输入小于100个字！")
//            textView.editable = NO;
//                    textView.userInteractionEnabled = NO;
        }

        else

        {

            NSString * nsTextContent = textView.text;

            NSInteger existTextNum = [nsTextContent length];

            remainTextNum =100-existTextNum;
            [self.label removeFromSuperview];
            self.label = [[UILabel alloc] initWithFrame:CGRectMake(textView.frame.size.width-80, textView.frame.size.height-30, 80, 30)];
            self.label.font = [UIFont systemFontOfSize:14];
            self.label.textColor = [UIColor lightGrayColor];
            self.label.textAlignment = NSTextAlignmentCenter;

            [textView addSubview:self.label];

            self.label.backgroundColor = [UIColor whiteColor];

            self.label.text = [NSString stringWithFormat:@"%ld/100",(long)remainTextNum];
            self.label = nil;
        }
        
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
