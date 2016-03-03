//
//  MessageViewController.m
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageViewCell.h"
#import "TheSessionView.h"
#import "MyFriendsView.h"

//容联
#import "SessionViewController.h"
#import "ContactListViewController.h"
//列表
#import "FriendsListViewController.h"

@interface MessageViewController ()<UIScrollViewDelegate,SlideSwitchSubviewDelegate>{
    UIButton *_btn;
    UIScrollView *_scrollView;
}

@end

@implementation MessageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor whiteColor];



    [self initMessageViewController];
}


- (void)initMessageViewController{


    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    titleView.backgroundColor = COLOR;
    [self.view addSubview:titleView];
//
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 80, 40)];
//    titleLabel.text = @"车消息";
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.font = [UIFont systemFontOfSize:16];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [titleView addSubview:titleLabel];
//
//    UIButton *addButton  = [UIButton buttonWithType:UIButtonTypeCustom];
//    addButton.frame = CGRectMake(SCREEN_WIDTH-80, 20, 80, 40);
//    [addButton setTitle:@"添加好友" forState:UIControlStateNormal];
//    addButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:addButton];


    NSArray *array = [[NSArray alloc]initWithObjects:@"会话", @"好友", nil];

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113)];
    // 是否支持滑动最顶端
    //    scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    // 设置内容大小
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2,SCREEN_HEIGHT - 113);
    // 是否反弹
    _scrollView.bounces = NO;
    // 是否分页
    _scrollView.pagingEnabled = YES;
    // 是否滚动
    //    scrollView.scrollEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    // 是否同时运动,lock
    _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:_scrollView];

//    TheSessionView *session = [[TheSessionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 104-49)];
//    session.backgroundColor = [UIColor redColor];
//    [_scrollView addSubview:session];

    SessionViewController *sessionViewController = [[SessionViewController alloc]init];
    sessionViewController.mainView = self;
    sessionViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 104);
    [_scrollView addSubview:sessionViewController.view];
    [self addChildViewController:sessionViewController];
    
//    MyFriendsView *friends = [[MyFriendsView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 104-49)];
//    friends.backgroundColor = [UIColor greenColor];
//    [_scrollView addSubview:friends];
    
//    ContactListViewController *contactListViewController = [[ContactListViewController alloc]init];
//    contactListViewController.mainView = self;
//    contactListViewController.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 104);
//    [_scrollView addSubview:contactListViewController.view];
//    [self addChildViewController:contactListViewController];

    FriendsListViewController *contactListViewController = [[FriendsListViewController alloc]init];
    contactListViewController.sessionTableView = sessionViewController.tableView;
    contactListViewController.mainView = self;
    contactListViewController.isFriendsList = YES;
    contactListViewController.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 104);
    [_scrollView addSubview:contactListViewController.view];
    [self addChildViewController:contactListViewController];


    for (int i = 0; i < array.count; i++) {

        UIButton *typeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        typeButton.frame = CGRectMake(SCREEN_WIDTH/2 *i, 20, SCREEN_WIDTH/2, 40);
        [typeButton setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        typeButton.titleLabel.font = [UIFont systemFontOfSize:18];
        typeButton.tag = i +1;
        [typeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [typeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [typeButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:typeButton];

        UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2*i, 60, SCREEN_WIDTH/2, 4)];
        bgImage.tag = 20 +i;

        bgImage.alpha = 0.3;
        [self.view addSubview:bgImage];


        if (i == 0) {
            [self typeButtonClick:typeButton];
        }else{
            UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 22, 1, 36)];
            lineImage.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:lineImage];

        }
    }
}
- (void)addButtonClick:(UIButton *)button{
    
}
- (void)typeButtonClick:(UIButton *)button{
    _btn.selected = NO;
    button.selected = YES;
    _btn = button;

    if (button.tag == 1) {

        UIImageView *image = (UIImageView *)[self.view viewWithTag:20];
        image.backgroundColor = GRAY;
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:21];
        imageView.backgroundColor = [UIColor clearColor];



        CGPoint position = CGPointMake(0, 0);

        [_scrollView setContentOffset:position animated:YES];
    }else{
        UIImageView *image = (UIImageView *)[self.view viewWithTag:20];
        image.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:21];
        imageView.backgroundColor = GRAY;

        CGPoint position = CGPointMake(SCREEN_WIDTH, 0);


        [_scrollView setContentOffset:position animated:YES];
    }
}
// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"scrollViewDidScroll  %f",scrollView.contentOffset.x );

    if (scrollView.contentOffset.x == SCREEN_WIDTH) {
        UIButton *button = (UIButton *) [self.view viewWithTag:2];
        _btn.selected = NO;
        button.selected = YES;
        _btn = button;
        UIImageView *image = (UIImageView *)[self.view viewWithTag:20];
        image.backgroundColor = [UIColor clearColor];;
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:21];
        imageView.backgroundColor = GRAY;

        

    }else{
        UIButton *button = (UIButton *) [self.view viewWithTag:1];
        _btn.selected = NO;
        button.selected = YES;
        _btn = button;
        UIImageView *image = (UIImageView *)[self.view viewWithTag:20];
        image.backgroundColor = GRAY;
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:21];
        imageView.backgroundColor = [UIColor clearColor];


    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SlideSwitchSubviewDelegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    [viewController.navigationItem setHidesBackButton:YES];
//    [self.navigationController pushViewController:viewController animated:animated];
    self.nextArray(nil,viewController);
}
-(void)showToast:(NSString *)message{

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
