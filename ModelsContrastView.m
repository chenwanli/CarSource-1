//
//  ModelsContrastView.m
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ModelsContrastView.h"
#import "ModelsContrastViewCell.h"
//车型对比
@implementation ModelsContrastView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{
    _modelsArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", @"8",@"9",@"10",@"11",@"12",@"13",@"14",nil];
    _addArray = [[NSMutableArray alloc]init];
    _models = YES;
    _modelsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height-50) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _modelsTable.delegate = self;
    // 设置数据源
    _modelsTable.dataSource = self;
    _modelsTable.bounces = NO;
    _modelsTable.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:240/255.0 alpha:1];
    _modelsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    // 如果同时也使用了协议方法  ,以协议方法为主
    [self addSubview:_modelsTable];

    [self deleteButton];
}
- (void)deleteButton{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    view.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:240/255.0 alpha:1];

    UIView *addView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    addView.backgroundColor = [UIColor whiteColor];
    [view addSubview:addView];

    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCREEN_WIDTH/2-80, 10, 50, 50);
    [addBtn setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];

    [addBtn addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [addView addSubview:addBtn];

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-20, 10, 100, 50)];
    label.text = @"添加车款";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:23];
    [addView addSubview:label];

    _modelsTable.tableHeaderView = view;
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"编辑" forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    deleteBtn.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
    [deleteBtn addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];

    UIButton *contrastBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [contrastBtn setTitle:@"对比（1）" forState:UIControlStateNormal];
    contrastBtn.backgroundColor = [UIColor whiteColor];
    contrastBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [contrastBtn addTarget:self action:@selector(contrastButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:contrastBtn];


    [deleteBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(self).offset(@0);
        make.width.equalTo(SCREEN_WIDTH/2);
        make.height.equalTo(@50);
    }];

    [contrastBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.bottom.equalTo(self).offset(@0);
        make.width.equalTo(SCREEN_WIDTH/2);
        make.height.equalTo(@50);
    }];

}
- (void)addButtonClick:(UIButton *)button{

}

- (void)deleteButtonClick:(UIButton *)button{

    button.selected = !button.selected;

    if (button.selected) {
        _models = NO;
        [button setTitle:@"删除"  forState:UIControlStateNormal];


    }else{
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        _models = YES;
        if (_addArray.count != 0) {
            for (int i = 0;i< _addArray.count ; i++) {
                [_modelsArray removeObject:[_addArray objectAtIndex:i]];
            }


            [_addArray removeAllObjects];
        }

    }
    [_modelsTable reloadData];

}
- (void)contrastButtonClick:(UIButton *)button{
    self.contrast(nil);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _modelsArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    ModelsContrastViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[ModelsContrastViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];

    if (_models == YES) {
        cell.deleteImage.hidden = YES;
        _isModels[indexPath.section][indexPath.row] = NO;

    }else{
         cell.deleteImage.hidden = NO;
        if (_isModels[indexPath.section][indexPath.row]) {
             cell.deleteImage.image = [UIImage imageNamed:@"for"];
        }else{
             cell.deleteImage.image = [UIImage imageNamed:@"highlighted"];
        }
        [cell modelsContrastViewCell];
    }

    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_models == NO) {
        _isModels[indexPath.section][indexPath.row] =  ! _isModels[indexPath.section][indexPath.row];

        if (_isModels[indexPath.section][indexPath.row]) {
            [_addArray addObject:[_modelsArray objectAtIndex:indexPath.row]];

        }else{
            if (_addArray.count != 0) {
                [_addArray removeObject:[_modelsArray objectAtIndex:indexPath.row]];
            }
        }
        [_modelsTable reloadData];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
