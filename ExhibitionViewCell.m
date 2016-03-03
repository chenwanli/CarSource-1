//
//  ExhibitionViewCell.m
//  CarSource
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ExhibitionViewCell.h"
#import "CustomerServiceUserList.h"

@implementation ExhibitionViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self awakeFromNib];

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 30)];
    _typeLabel.font = [UIFont systemFontOfSize:16];
    _typeLabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    [self addSubview:_typeLabel];

    UIImageView *bottomImage = [[UIImageView alloc]init];
    bottomImage.backgroundColor = [UIColor colorWithRed:219/255.0 green:230/255.0 blue:239/255.0 alpha:1];
    [self addSubview:bottomImage];

    [bottomImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(self).offset(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@1);
    }];


}
// 展车介绍  我的地址
- (void)theExhibitionHallisIntroducedHeight:(NSInteger)height{
    [_introduceLabel removeFromSuperview];
    _introduceLabel = [[UILabel alloc]init];
    _introduceLabel.font = [UIFont systemFontOfSize:14];
    _introduceLabel.textColor = [UIColor grayColor];
    _introduceLabel.numberOfLines = 0;
    [self addSubview:_introduceLabel];

    [_introduceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(height);
    }];

}
//评分控件
- (void)initLHRatingView{

    [self.rView removeFromSuperview];
    self.rView = [[LHRatingView alloc]initWithFrame:CGRectMake(85, 8, 130, 30)];
//    self.rView.center = self.center;
    //    rView.ratingType = INTEGER_TYPE;//整颗星  FLOAT_TYPE
    self.rView.ratingType = FLOAT_TYPE;
//    rView.score = 0.5;
    self.rView.delegate = self;
    [self addSubview:self.rView];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(85, 13, 130, 30)];
    [self addSubview:view];

}
- (void)ratingView:(LHRatingView *)view score:(CGFloat)score
{
//    NSLog(@"分数  %.2f",score);


}
//联系电话
- (void)initContactPhoneNumber{
    [_phoneBtn removeFromSuperview];
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //    [_phoneBtn setTitle:@"18689620485" forState:UIControlStateNormal];
    _phoneBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    //    [_phoneBtn addTarget:self action:@selector(phoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_phoneBtn];

    UIImageView *img = (UIImageView *) [self viewWithTag:124];
    [img removeFromSuperview];
    UIImageView *phoneIamge = [[UIImageView alloc]init];
    phoneIamge.image = [UIImage imageNamed:@"tel"];
    phoneIamge.tag = 124;
    [self addSubview:phoneIamge];

    [phoneIamge makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-120);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(17, 23));
    }];


    [_phoneBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(@0);
        make.size.equalTo(CGSizeMake(120, 50));
    }];

}


//经营品牌
- (void)initBrandManagementImageArray:(NSMutableArray *)array{

    @autoreleasepool
    {
        NSMutableArray *arr = [NSMutableArray array];

        for (NSString *str in array) {
            [arr addObject:str];
        }

        UIView *bgView = (UIView *) [self viewWithTag:120];
        [bgView removeFromSuperview];

        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        view.tag = 120;
        [self addSubview:view];

        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, -1, SCREEN_WIDTH, 11)];
        image.layer.borderColor = [UIColor colorWithRed:219/255.0 green:230/255.0 blue:239/255.0 alpha:1].CGColor;
        image.layer.borderWidth = 1.0;
        image.backgroundColor = GRAY;
        [view addSubview:image];

        _typeLabel.frame = CGRectMake(10, 15, 70, 30);

        UIView *brandView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 60)];
        brandView.layer.borderColor = [UIColor colorWithRed:219/255.0 green:230/255.0 blue:239/255.0 alpha:1].CGColor;
        brandView.layer.borderWidth = 1.0;
        brandView.backgroundColor = [UIColor whiteColor];
        [view addSubview:brandView];

        for (int i = 0; i < arr.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50*i +10, 60, 40, 40)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,[arr objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
            [view addSubview:imageView];
        }

    }

}
// 公司销售
- (void)initCompanySalesArray:(NSMutableArray *)array{

    @autoreleasepool {

        UIImageView *bgImage = (UIImageView *) [self viewWithTag:121];
        [bgImage removeFromSuperview];

        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, -1, SCREEN_WIDTH, 11)];
        image.layer.borderColor = [UIColor colorWithRed:219/255.0 green:230/255.0 blue:239/255.0 alpha:1].CGColor;
        image.tag = 121;
        image.layer.borderWidth = 1.0;
        image.backgroundColor = GRAY;
        [self addSubview:image];


        _typeLabel.frame = CGRectMake(10, 15, 70, 30);

        UIScrollView *scroll = (UIScrollView *)[self viewWithTag:122];
        [scroll removeFromSuperview];


        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 100)];
        //    scrollView.delegate = self;
        // 设置内容大小
        scrollView.contentSize = CGSizeMake(135*array.count,100);
        // 是否反弹
        scrollView.bounces = NO;
        scrollView.tag  = 122;
        // 是否滚动
        //    scrollView.scrollEnabled = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        // 是否同时运动,lock
        scrollView.directionalLockEnabled = YES;
        scrollView.layer.borderColor = [UIColor colorWithRed:219/255.0 green:230/255.0 blue:239/255.0 alpha:1].CGColor;
        scrollView.layer.borderWidth = 1.0;
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];

        for (int i = 0; i < array.count; i++) {

            CustomerServiceUserList *list = [array objectAtIndex:i];

            UIView *salesView = [[UIView alloc]initWithFrame:CGRectMake(130 *i +10, 0, 120, 100)];
            [scrollView addSubview:salesView];

            UIImageView *nameImage = [[UIImageView alloc]initWithFrame:CGRectMake((salesView.frame.size.width)/2 - 15 , 10, 40, 40)];
            nameImage.layer.cornerRadius = 20;
            nameImage.layer.masksToBounds = YES;
            [nameImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,list.customerServiceUserUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
            [salesView addSubview:nameImage];

            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, salesView.frame.size.width -30, 20)];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.numberOfLines = 0;
            nameLabel.text = [NSString stringWithFormat:@"%@",list.customerServiceUserName];
            nameLabel.textColor = [UIColor grayColor];
            nameLabel.font = [UIFont systemFontOfSize:14];
            [salesView addSubview:nameLabel];

            UIImageView *phoneIamge = [[UIImageView alloc]initWithFrame:CGRectMake(5, 68, 15, 20)];
            phoneIamge.image = [UIImage imageNamed:@"tel"];
            [salesView addSubview:phoneIamge];

            UIButton *telButton = [UIButton buttonWithType:UIButtonTypeSystem];
            telButton.frame = CGRectMake(20, 70, salesView.frame.size.width -20, 20);
            telButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [telButton setTitle:[NSString stringWithFormat:@"%@",list.customerServiceUserTel] forState:UIControlStateNormal];
            telButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
            telButton.backgroundColor = [UIColor whiteColor];
            [telButton addTarget:self action:@selector(telButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [salesView addSubview:telButton];
            
        }

    }

}
- (void)telButtonClick:(UIButton *)button{


}
//全部展车
- (void)initAllofTheBelow{

     _typeLabel.frame = CGRectMake(10, 15, 70, 30);

    UIImageView *img = (UIImageView *)[self viewWithTag:125];

    [img removeFromSuperview];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, -1, SCREEN_WIDTH, 11)];
    image.layer.borderColor = [UIColor colorWithRed:219/255.0 green:230/255.0 blue:239/255.0 alpha:1].CGColor;
    image.layer.borderWidth = 1.0;
    image.tag = 125;
    image.backgroundColor = GRAY;
    [self addSubview:image];

    UIImageView *milledImge = (UIImageView *)[self viewWithTag:126];
    [milledImge removeFromSuperview];

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.tag = 126;
    imageView.image = [UIImage imageNamed:@"milled"];
    [self addSubview:imageView];

    UILabel *label = [self viewWithTag:127];
    [label removeFromSuperview];

    UILabel *allLabel = [[UILabel alloc]init];
    allLabel.textAlignment = NSTextAlignmentRight;
    allLabel.numberOfLines = 0;
    allLabel.tag = 127;
    allLabel.text = @"全部";
    allLabel.textColor = COLOR;
    allLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:allLabel];


    UIImageView *whiteImage = (UIImageView *)[self viewWithTag:128];
    [whiteImage removeFromSuperview];
    UIImageView *bgIamge = [[UIImageView alloc]init];
    bgIamge.tag = 128;
    bgIamge.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgIamge];

    [self.belowIamge removeFromSuperview];
    self.belowIamge = [[UIImageView alloc]init];
//    self.belowIamge.image = [UIImage imageNamed:@"Aventador"];
    [self addSubview:self.belowIamge];

    [self.carLabel removeFromSuperview];
    self.carLabel = [[UILabel alloc]init];
//    self.carLabel.textAlignment = NSTextAlignmentRight;
    self.carLabel.numberOfLines = 0;
//    self.carLabel.text = @"15款奔驰CLE200";
    self.carLabel.textColor = COLOR;
    self.carLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.carLabel];

    [self.priceLabel removeFromSuperview];
    self.priceLabel = [[UILabel alloc]init];
//    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel.numberOfLines = 0;
//    self.priceLabel.text = @"美规 现车 黑／白66.88万";
    self.priceLabel.textColor = [UIColor grayColor];
    self.priceLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.priceLabel];

    [self.detailedLabel removeFromSuperview];
    self.detailedLabel = [[UILabel alloc]init];
//    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.detailedLabel.numberOfLines = 0;
//    self.detailedLabel.text = @"5系4356 德系黑马 手续全 销往内蒙5系4356 内蒙5系4356 德系黑马 手续全 销往内蒙5系4356 内蒙5系4356 ";
    self.detailedLabel.textColor = [UIColor grayColor];
    self.detailedLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.detailedLabel];



    [allLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-25);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(50, 50));
    }];

    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@25);
        make.size.equalTo(CGSizeMake(15, 18));
    }];

    [bgIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@60);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@130);
    }];


    [self.belowIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@70);
        make.right.equalTo(self).offset(-(SCREEN_WIDTH/2+10));
        make.height.equalTo(@110);
    }];

    [self.carLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(@65);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@35);
    }];

    [self.priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(@95);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@40);
    }];

    [self.detailedLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(@130);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@55);
    }];

}
//交车纪念
- (void)initItForMemorial{
     _typeLabel.frame = CGRectMake(10, 15, 70, 30);


    UIImageView *img = (UIImageView *)[self viewWithTag:129];

    [img removeFromSuperview];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, -1, SCREEN_WIDTH, 11)];
    image.layer.borderColor = [UIColor colorWithRed:219/255.0 green:230/255.0 blue:239/255.0 alpha:1].CGColor;
    image.tag = 129;
    image.layer.borderWidth = 1.0;
    image.backgroundColor = GRAY;
    [self addSubview:image];

    UIImageView *milledImge = (UIImageView *)[self viewWithTag:130];
    [milledImge removeFromSuperview];

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"milled"];
    imageView.tag = 130;
    [self addSubview:imageView];

    UILabel *label = [self viewWithTag:131];
    [label removeFromSuperview];

    UILabel *allLabel = [[UILabel alloc]init];
    allLabel.textAlignment = NSTextAlignmentRight;
    allLabel.numberOfLines = 0;
    allLabel.tag = 131;
    allLabel.text = @"全部";
    allLabel.textColor = COLOR;
    allLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:allLabel];

    UIImageView *whiteImage = (UIImageView *)[self viewWithTag:132];
    [whiteImage removeFromSuperview];

    UIImageView *bgIamge = [[UIImageView alloc]init];
    bgIamge.backgroundColor = [UIColor whiteColor];
    bgIamge.tag = 132;
    [self addSubview:bgIamge];


    [self.memorialImage removeFromSuperview];
    self.memorialImage = [[UIImageView alloc]init];
//    self.memorialImage.image = [UIImage imageNamed:@"Aventador"];
    [self addSubview:self.memorialImage];

    UILabel *type = (UILabel *)[self viewWithTag:133];
    [type removeFromSuperview];
    UILabel *typeLabel = [[UILabel alloc]init];
    typeLabel.numberOfLines = 0;
    typeLabel.text = @"车型：";
    typeLabel.tag = 133;
    typeLabel.textColor = [UIColor grayColor];
    typeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:typeLabel];

    UILabel *time = (UILabel *)[self viewWithTag:134];
    [time removeFromSuperview];
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.numberOfLines = 0;
    timeLabel.tag = 134;
    timeLabel.text = @"日期：";
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:timeLabel];

    [self.carLabel removeFromSuperview];
    self.carLabel = [[UILabel alloc]init];
    //    self.carLabel.textAlignment = NSTextAlignmentRight;
    self.carLabel.numberOfLines = 0;
    [self.carLabel sizeToFit];
//    self.carLabel.text = @"15款奔驰CLE200";
    self.carLabel.textColor = COLOR;
    self.carLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.carLabel];

    [self.priceLabel removeFromSuperview];
    self.priceLabel = [[UILabel alloc]init];
    //    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel.numberOfLines = 0;
//    self.priceLabel.text = @"2015-12-12";
    self.priceLabel.textColor = COLOR;
    self.priceLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.priceLabel];

    [self.detailedLabel removeFromSuperview];
    self.detailedLabel = [[UILabel alloc]init];
    //    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.detailedLabel.numberOfLines = 0;
//    self.detailedLabel.text = @"5系4356 德系黑马 手续全 销往内蒙5系4356 内蒙5系4356 德系黑马 手续全 销往内蒙5系4356 内蒙5系4356 ";
    self.detailedLabel.textColor = [UIColor grayColor];
    self.detailedLabel.font = [UIFont systemFontOfSize:13];

    [self addSubview:self.detailedLabel];

    
    [allLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-25);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(50, 50));
    }];

    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@25);
        make.size.equalTo(CGSizeMake(15, 18));
    }];

    [bgIamge makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@60);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@130);
    }];


    [self.memorialImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@70);
        make.right.equalTo(self).offset(-(SCREEN_WIDTH/2+10));
        make.height.equalTo(@110);
    }];

    [typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(@65);
        make.size.equalTo(CGSizeMake(45, 30));
    }];
    [timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(@98);
        make.size.equalTo(CGSizeMake(45, 30));
    }];

    [self.carLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2+45);
        make.top.equalTo(@65);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@35);
    }];

    [self.priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2+45);
        make.top.equalTo(@98);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];

    [self.detailedLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(@125);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@60);
    }];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
