//
//  ImageViewController.m
//  CarSource
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ImageViewController.h"
#import "LLPhotoScv.h"

@interface ImageViewController ()
@property (strong, nonatomic)  LLPhotoScv * scrView;
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
//    NSLog(@"%@",self.imageArray );
    self.scrView =[[LLPhotoScv alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andImage:self.imageArray point:self.index];

    [self.view addSubview:self.scrView];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 15, 18)];
    image.image = [UIImage imageNamed:@"return"];
    [self.view addSubview:image];
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 0, 60, 64);
    [returnBtn addTarget:self action:@selector(returnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];

}
- (void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
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
