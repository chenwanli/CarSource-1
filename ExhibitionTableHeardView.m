//
//  ExhibitionTableHeardView.m
//  CarSource
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ExhibitionTableHeardView.h"
#import "ExhibitionModel.h"

@interface ExhibitionTableHeardView (){
    UIImageView *_bgImage;
    UILabel *_browseLabel;
    UIImageView *_userImage;
    UILabel *_nameLabel;
    UILabel *_experienceLabel;
}

@end
@implementation ExhibitionTableHeardView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    self.backgroundColor = [UIColor colorWithRed:245/255.0 green:251/255.0 blue:255/255.0 alpha:1];

    _bgImage = [[UIImageView alloc]init];
//    _bgImage.image = [UIImage imageNamed:@"h1.jpg"];
    [self addSubview:_bgImage];

    _browseLabel = [[UILabel alloc]init];
//    _browseLabel.text = @"浏览 888   展车 8";
    _browseLabel.textAlignment = NSTextAlignmentRight;
    _browseLabel.font = [UIFont systemFontOfSize:16];
    _browseLabel.textColor = [UIColor whiteColor];
    [self addSubview:_browseLabel];

    _userImage = [[UIImageView alloc]init];
    _userImage.layer.cornerRadius = 30;
    _userImage.layer.masksToBounds = YES;
//    _userImage.image = [UIImage imageNamed:@"Aventador"];
    [self addSubview:_userImage];


    _nameLabel = [[UILabel alloc]init];
//    _nameLabel.text = @"深圳车老大";
    _nameLabel.font = [UIFont systemFontOfSize:18];
    _nameLabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    [self addSubview:_nameLabel];

    _experienceLabel = [[UILabel alloc]init];
//    _experienceLabel.text = @"经验 8年   交车 16辆";
    _experienceLabel.font = [UIFont systemFontOfSize:14];
    _experienceLabel.textColor = [UIColor grayColor];
    [self addSubview:_experienceLabel];

    UIImageView *bottomImage = [[UIImageView alloc]init];
    bottomImage.backgroundColor = [UIColor colorWithRed:219/255.0 green:230/255.0 blue:239/255.0 alpha:1];
    [self addSubview:bottomImage];


    for (int i = 0; i < 2; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((40 *i) +200 , 232, 30 +5*i, 15)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"c%d",i +1]];
        [self addSubview:imageView];
    }



    [_browseLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@100);
        make.top.equalTo(@180);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@40);
    }];

    [_bgImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@220);
    }];

    [_userImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@210);
        make.size.equalTo(CGSizeMake(60, 60));
    }];

    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@220);
        make.size.equalTo(CGSizeMake(140, 40));
    }];

    [_experienceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@250);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];

    [bottomImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@1);
    }];
    
}
- (void)initExhibitionTableHeardViewArray:(NSMutableArray *)array{

     ExhibitionModel *model = [array objectAtIndex:0];

    [_bgImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,model.showrooUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];

     _browseLabel.text = [NSString stringWithFormat:@"浏览 %@    展车 %@",model.showroomViews,model.showroomShowCarQuantity];

    [_userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,model.showrooUserUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
    _nameLabel.text = [NSString stringWithFormat:@"%@",model.showrooUserName];

//    NSLog(@"model.showroomEmpirical = %@",model.showroomEmpirical);
    _experienceLabel.text = [NSString stringWithFormat:@"经验 %@    交车 %@辆",model.showroomEmpirical,model.transactionVehiclesQuantity];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
