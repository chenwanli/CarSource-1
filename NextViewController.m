//
//  NextViewController.m
//  CarSource
//
//  Created by apple on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NextViewController.h"
#import "NextViewCell.h"
#import "NextTableHeaderView.h"
#import "DriverView.h"
#import "LicensePlateNumberView.h"
#import "LicensePlateViewCell.h"
#import "BankAccountView.h"
#import "BankAccountViewCell.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"

@interface NextViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_nextTable;
    NSMutableArray *_driverArray;
    NSMutableArray *_licenseArray;
    NSMutableArray *_bankArray;
    UIView *_footerView;
    UIButton *_addButton;
    UIButton *_submitButton;
    NSInteger _delete;
    UIButton *_cancelButton;


}
@property (nonatomic ,strong) NSMutableArray *assetsArray;
@end

@implementation NextViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.assetsArray = [[NSMutableArray alloc]init];
    _driverArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    _licenseArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    _bankArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"个人中心";
    [self.view addSubview:nav];

    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    _nextTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    _nextTable.delegate = self;
    // 设置数据源
    _nextTable.dataSource = self;
    _nextTable.bounces = NO;
     // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    _nextTable.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];
    _nextTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:_nextTable];

    NextTableHeaderView *next = [[NextTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 176)];

    _nextTable.tableHeaderView = next;

    [self nextTableFooterView];

    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [_nextTable addGestureRecognizer:longPressGr];
}
- (void)nextTableFooterView{

    [self initTableFooterView];

    _footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 46)/3 +124);
    [_submitButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.bottom.equalTo(_footerView).offset(-20);
        make.right.equalTo(_footerView).offset(-50);
        make.height.equalTo(@40);
    }];

    _nextTable.tableFooterView = _footerView;

}

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
//        CGPoint point = [gesture locationInView:self.tableView];
//        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
//        if(indexPath == nil) return ;
//        //add your code here

        if (_assetsArray.count != 0) {
            _delete = 1;

            [self initImageButton];
            _cancelButton.hidden = NO;

        }
    }
}
- (void)initTableFooterView{
    _footerView = [[UIView alloc]init];

    _footerView.backgroundColor = [UIColor whiteColor];

    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 14, 16, 16)];
    numberLabel.layer.cornerRadius = 8;
    numberLabel.layer.masksToBounds = YES;
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.font = [UIFont systemFontOfSize:13];
    numberLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1];
    numberLabel.text = @"8";
    [_footerView addSubview:numberLabel];

    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(36, 7, 60, 30)];
    addLabel.textColor = [UIColor grayColor];
    addLabel.font = [UIFont systemFontOfSize:15];
    addLabel.text = @"公司图片";
    [_footerView addSubview:addLabel];

    _cancelButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setTitle:@"取消删除" forState:UIControlStateNormal];
    _cancelButton.frame = CGRectMake(SCREEN_WIDTH - 100,7, 80, 30);
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancelButton setTitleColor:COLOR forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:_cancelButton];

    _cancelButton.hidden = YES;



    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(36, 44, (SCREEN_WIDTH - 46)/3 - 10, (SCREEN_WIDTH - 46)/3 - 10);
    [_addButton setBackgroundImage:[UIImage imageNamed:@"gift"] forState:UIControlStateNormal];

    [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:_addButton];


    _submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
//    _submitButton.frame = CGRectMake(50,(SCREEN_WIDTH - 46)/3 + 64, SCREEN_WIDTH - 100, 50);
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:16];

    _submitButton.layer.cornerRadius = 5;
    _submitButton.layer.masksToBounds = YES;
//    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    _submitButton.backgroundColor = COLOR;
    [_submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:_submitButton];

    


}
- (void)cancelButtonClick:(UIButton *)button{

    _delete = 0;

    if (self.assetsArray.count == 0) {
        [self nextTableFooterView];
    }else{
        [self initImageButton];
    }


}
- (void)submitButtonClick:(UIButton *)button{

}
- (void)addButtonClick:(UIButton *)button{
    [self selectPhotos];
}
#pragma mark - 选择相册
- (void)selectPhotos {
    // 创建控制器
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.status = PickerViewShowStatusCameraRoll;
    if (_assetsArray.count == 0) {
         pickerVc.maxCount = 9;
    }else{
         pickerVc.maxCount = 9 - _assetsArray.count;
    }

    [pickerVc showPickerVc:self];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets){
        [weakSelf.assetsArray addObjectsFromArray:assets];
        [self initImageButton];                     

    };
}
- (void)initImageButton{
    [_footerView removeFromSuperview];

    [self initTableFooterView];
    int totalloc=3;
    CGFloat appvieww=(SCREEN_WIDTH- 46)/3-5;
    CGFloat appviewh=(SCREEN_WIDTH- 46)/3-5;
    CGFloat margin=((SCREEN_WIDTH- 46) -totalloc*appvieww)/(totalloc+1);

    for (int i = 0; i < self.assetsArray.count; i++) {

        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        CGFloat appviewx=margin+(margin+appvieww)*loc;
        CGFloat appviewy=margin+(margin+appviewh)*row;
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageButton.frame = CGRectMake(appviewx +36, appviewy +44, (SCREEN_WIDTH - 46)/3 - 10, (SCREEN_WIDTH - 46)/3 - 10);
        // 判断类型来获取Image
        MLSelectPhotoAssets *asset = self.assetsArray[i];

        [imageButton setBackgroundImage:[MLSelectPhotoPickerViewController getImageWithImageObj:asset] forState:UIControlStateNormal];

        [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.tag = i ;

        [_footerView addSubview:imageButton];
        if (_delete == 1) {
            _cancelButton.hidden = NO;
            UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            deleteButton.frame = CGRectMake(appviewx +26, appviewy +34, 30, 30);
            [deleteButton setBackgroundImage:[UIImage imageNamed:@"esc"] forState:UIControlStateNormal];
            [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            deleteButton.tag = i +1;

            [_footerView addSubview:deleteButton];
        }
        if (i == self.assetsArray.count -1) {
            int line=(i +1)/totalloc;//行号
            //1/3=0,2/3=0,3/3=1;
            int column=(i +1)%totalloc;//列号
            CGFloat x=margin+(margin+appvieww)*column;
            CGFloat y=margin+(margin+appviewh)*line;
            if (i<8) {
                _addButton.frame = CGRectMake(x+36 , y +44, (SCREEN_WIDTH - 46)/3 - 10, (SCREEN_WIDTH - 46)/3 - 10);
                _footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 46)/3 *(line +1) + 134);
            }else{
                _addButton.hidden = YES;
                _footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 46)/3 *(line) + 134);
            }

            [_submitButton makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@50);
                make.bottom.equalTo(_footerView).offset(-20);
                make.right.equalTo(_footerView).offset(-50);
                make.height.equalTo(@40);
            }];

            _nextTable.tableFooterView = _footerView;
            [_nextTable reloadData];
        }
    }

}
- (void)deleteButtonClick:(UIButton *)button{

//    _delete = 0;
    [self.assetsArray removeObjectAtIndex:button.tag - 1];

    if (self.assetsArray.count == 0) {
        [self nextTableFooterView];
    }else{
        [self initImageButton];
    }
    


}

- (void)imageButtonClick:(UIButton *)button{
    MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
    browserVc.currentPage = button.tag;
    browserVc.photos = self.assetsArray;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:browserVc animated:YES];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0 ) {
         return _driverArray.count;
    }else if (section == 1){
         return _licenseArray.count;
    }else{
        return _bankArray.count;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"NextCell";
        NextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if (!cell)
        {
            cell = [[NextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];
        
        return cell;

    }else if (indexPath.section == 1){
        static NSString *cellIdentifier = @"LicenseCell";
        LicensePlateViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if (!cell)
        {
            cell = [[LicensePlateViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;

    }else{
        static NSString *cellIdentifier = @"BankCell";
        BankAccountViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if (!cell)
        {
            cell = [[BankAccountViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:241/255.0 alpha:1];

        return cell;

    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 98;
    }else if(indexPath.section == 1){
        return 44;
    }else{
        return 142;
    }

}
// 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            DriverView *driverView = [[DriverView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 132)];

            return driverView;
        }
            break;
        case 1:
        {
            LicensePlateNumberView *license = [[LicensePlateNumberView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];

            return license;
        }
            break;
        case 2:
        {
            BankAccountView *license = [[BankAccountView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];

            return license;
        }
            break;

        default:
            break;
    }


    
    return nil;
}
// 设置区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
             return 132;
        }
            break;
        case 1:
        {
             return 88;
        }
            break;
        case 2:
        {
            return 240;
        }
            break;

        default:
            break;
    }
     return 0;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        switch (indexPath.section) {
            case 0:
            {
                [_driverArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                

            }
                break;
            case 1:
            {
                [_licenseArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];


            }
                break;
            case 2:
            {
                [_bankArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

            }
                break;

                
            default:
                break;
        }
      }

//    [_nextTable reloadData];
}
//修改删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return UITableViewCellEditingStyleDelete;
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
