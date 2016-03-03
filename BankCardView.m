//
//  BankCardView.m
//  CarSource
//
//  Created by apple on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BankCardView.h"
#import "BankCardViewCell.h"
@interface BankCardView ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_cardTable;
    NSMutableArray *_cardArray;
    NSInteger _index;
}

@end
@implementation BankCardView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

 
    _cardArray = [[NSMutableArray alloc]init];
    _cardTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.frame.size.width, self.frame.size.height-60) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _cardTable.delegate = self;
    // 设置数据源
    _cardTable.dataSource = self;
    _cardTable.bounces = NO;
    _cardTable.backgroundColor = [UIColor whiteColor];
    _cardTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _cardTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self addSubview:_cardTable];

    [self initBankCardView];

}
- (void)initBankCardView{
    UIView *bankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
    bankView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bankView];

    UILabel *chooseLabel = [[UILabel alloc]init];
    chooseLabel.textColor = [UIColor grayColor];
    chooseLabel.font = [UIFont systemFontOfSize:20];
    chooseLabel.text = @"选择银行卡";
    [bankView addSubview:chooseLabel];

    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"esc"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bankView addSubview:deleteButton];


    [chooseLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(15);
        make.right.equalTo(bankView).offset(-50);
        make.height.equalTo(@40);
    }];

    [deleteButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.right.equalTo(bankView).offset(-10);
        make.size.equalTo(CGSizeMake(30, 30));
    }];

}
- (void)deleteButtonClick:(UIButton *)button{
    self.deleteBtn(nil);
}
- (void)initBankCardViewArray:(NSMutableArray *)array{

    [_cardArray removeAllObjects];
     _index = 0;
    for (NSString *str in array) {
        [_cardArray addObject:str];
    }
    [_cardTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _cardArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"Cell";
    BankCardViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[BankCardViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];

    cell.bankLabel.text = [_cardArray objectAtIndex:indexPath.row];

    if (_index == indexPath.row) {
        cell.bankImage.image = [UIImage imageNamed:@"for"];
    }else{
        cell.bankImage.image = [UIImage imageNamed:@"highlighted"];
    }


    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    _index = indexPath.row;
    [_cardTable reloadData];
    self.indexRow(indexPath.row);

}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
