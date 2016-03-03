//
//  MoreViewController.m
//  CarSource
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreCollectionViewCell.h"

@interface MoreViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    UICollectionView *_collectionView;
    NSMutableArray *_displayArray;
}


@end

@implementation MoreViewController
static NSString *cellIdentifier = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = self.moreStr;
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    [self initcollectionView];
}
- (void)initcollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH)/3-10, (SCREEN_WIDTH)/3-20);
    layout.sectionInset = UIEdgeInsetsMake(5,5, 5, 5);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing=5;

    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64) collectionViewLayout:layout];
    //    _collectionView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    //    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:@"MoreCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];


}
- (void)initCommodityDisplayArray:(NSMutableArray *)array{
    _displayArray = array;
    [_collectionView reloadData];
}
-  (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];

//    CommodityDisplay *display = [_displayArray objectAtIndex:indexPath.row];
//    [cell.displayImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",HTTP,display.secondClassifyUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
//    cell.displayLabel.text = display.secondClassify;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{


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
