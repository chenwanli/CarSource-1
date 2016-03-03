//
//  FriendsListViewController.m
//  CarSource
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FriendsListViewController.h"
#import "FriendsListViewCell.h"
#import "FriendModel.h"

#import "ContactDetailViewController.h"
@interface FriendsListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_friendsTable;
    NSMutableArray *_allArray;
    NSMutableArray *_bigArray;
    NSMutableArray *_friendsArray;
}

@end

@implementation FriendsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavView *nav;
    if (!_isFriendsList) {
        nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        nav.titleLabel.text = @"好友列表";
        [self.view addSubview:nav];
        nav.returnButton = ^(NSString *returnButton){
            [self.navigationController popViewControllerAnimated:YES];
        };
    }
    
    _friendsTable = [[UITableView alloc]initWithFrame:CGRectMake(0, nav.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-nav.frame.size.height) style:UITableViewStylePlain];
    _friendsTable.dataSource = self;
    _friendsTable.delegate = self;
    _friendsTable.bounces = NO;
    _friendsTable.rowHeight = 60;

    _friendsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    _destinationTable.sectionIndexBackgroundColor = [UIColor colorWithRed:218/255.0 green:236/255.0 blue:255/255.0 alpha:1];//设置右边字体索引背景颜色
    _friendsTable.sectionIndexColor = [UIColor grayColor];//设置右边字体颜色
    [self.view addSubview: _friendsTable];

    
    _friendsTable.tableHeaderView = [self setTableHeaderView];
    _friendsArray = [[NSMutableArray alloc]init];
    _allArray = [[NSMutableArray alloc]init];
    _bigArray = [[NSMutableArray alloc]init];

    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
    [LCCoolHUD showLoading:@"正在加载，请稍等" inView:self.view];
    [ChatInterfaceRequest postMyGoodFriendListRequestWithUserId:login.userId Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {
        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"]) {
            NSString *str = @"";
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            for (FriendModel *friend in saleArray) {

                //表格右边的索引，有不管ABCD有多少个，但是只取出ABCD就行，有可能很多个A ，但是只取一个，可以当做显示在表格右边的标题里
                if (![[NSString stringWithFormat:@"%@",friend.userInitials] isEqualToString:str]) {
                    [_friendsArray addObject:friend.userInitials];

                }
                str = friend.userInitials;
                [_allArray addObject:friend];
                
                [userDefaults setObject:friend.userFriendsUserName forKey:[NSString stringWithFormat:@"%@@",friend.userFriendsUserTel]];
            }
            [_bigArray removeAllObjects];
            [userDefaults synchronize];
            
            for (NSString *string in _friendsArray) {
                //_provincesCoding表格右边所有的标题
                //每一个区的数据，这是根据ABCD来分组的，也就是说A组有多少个数据全部存进A组里面
                NSMutableArray *indexArray = [[NSMutableArray alloc] initWithCapacity:0];

                for (FriendModel *model  in _allArray) {

                    if ([[NSString stringWithFormat:@"%@",model.userInitials] isEqualToString:string]) {
                        //根据所含有相同标题的全部取出来放进同一个数组
                        [indexArray addObject:model];
                    }
                }
                //每一个标题下都有一组数据，就是一个数组

                [_bigArray addObject:indexArray];
            }
            
            [_sessionTableView reloadData];
            [_friendsTable reloadData];
        }

    }];
    


}

- (UIView *)setTableHeaderView{
    if(!_isFriendsList){
        return nil;
    }else{
        UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        
        for (int i = 0; i < 2; i++) {
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 60 * i, SCREEN_WIDTH, 60)];
            [tableHeaderView addSubview:bgView];
            
            UIImageView *headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
            headImgView.layer.cornerRadius = 20;
            headImgView.layer.masksToBounds = YES;
            headImgView.backgroundColor = [UIColor yellowColor];
            [bgView addSubview:headImgView];
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 15, SCREEN_WIDTH - 120, 30)];
            nameLabel.text = @[@"手机联系人",@"新的好友"][i];
            [bgView addSubview:nameLabel];
            
            if (i == 0) {
                UIImageView *segmentationView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 59.5, SCREEN_WIDTH, 1)];
                segmentationView.backgroundColor = GRAY;
                [bgView addSubview:segmentationView];
            }
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
            [bgView addGestureRecognizer:tap];
        }
        return tableHeaderView;
    }
}

- (void)tapGesture:(UITapGestureRecognizer *)tap{
    NSLog(@"点击");
}

#pragma --
#pragma mark UITableView
// UITableViewDataSource协议中的方法，该方法的返回值决定表格包含多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    // _bigArray集合包含多少个元素，就包含多少个分区
    return _bigArray.count;
}
// UITableViewDataSource协议中的方法，该方法的返回值决定指定分区包含多少个元素
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[_bigArray objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"Cell";
    FriendsListViewCell* cell = [tableView
                             dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[FriendsListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FriendModel *friend = [[_bigArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",friend.userFriendsUserName];
    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,friend.userFriendsUserUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];


    return cell;
}


// UITableViewDataSource协议中的方法，该方法的返回值用于在表格右边建立一列浮动的索引。
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{

    return _friendsArray;
}
// UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的页眉
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_friendsArray  objectAtIndex:section];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isList == YES) {
         FriendModel *friend = [[_bigArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        self.friendsList([NSString stringWithFormat:@"%@",friend.userFriendsUserTel],[NSString stringWithFormat:@"%@",friend.userFriendsUserName]);
        [self.navigationController popViewControllerAnimated:YES];
    }else if (_isFriendsList){
        FriendModel *friend = [[_bigArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        FriendsListViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        ContactDetailViewController *contactDetail = [[ContactDetailViewController alloc] init];
        contactDetail.dict = @{nameKey:friend.userFriendsUserName,phoneKey:[NSString stringWithFormat:@"%@",friend.userFriendsUserTel],imageKey:cell.userImage.image};

        
        [self.mainView pushViewController:contactDetail animated:YES];
    }
}
// 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:225/255.0 alpha:1];
    UILabel *label = [[UILabel alloc]init];
    label.text = [_friendsArray objectAtIndex:section];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:12];
    [view addSubview:label];

    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.size.equalTo(CGSizeMake(200, 15));
    }];

    return view;
}
// 设置区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
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
