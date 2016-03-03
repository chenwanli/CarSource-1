//
//  DetailsTableFooterView.m
//  CarSource
//
//  Created by apple on 16/2/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DetailsTableFooterView.h"
#import "SalesListModel.h"

@interface DetailsTableFooterView (){

    NSMutableArray *_imageArray;

}
@end
@implementation DetailsTableFooterView
- (id)initWithFrame:(CGRect)frame array:(NSMutableArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNibArray:array];
    }
    return self;
}
- (void)awakeFromNibArray:(NSMutableArray *)array {
    _imageArray = [[NSMutableArray alloc]init];

    SalesListModel *salesList = [array objectAtIndex:0];
    self.backgroundColor = GRAY;

    UIImageView *bgImage = [[UIImageView alloc]init];
    bgImage.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgImage];
    
    UIImageView *userImage = [[UIImageView alloc]init];
    [userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,salesList.userUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
    [self addSubview:userImage];

    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = BLACK;
    nameLabel.numberOfLines = 0;
    nameLabel.text = [NSString stringWithFormat:@"%@",salesList.userName];
    nameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:nameLabel];

    [self initAuthenticateLabelText:salesList.authenticateTypeNameList];

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"milled"];
    [self addSubview:imageView];

    UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [userButton addTarget:self action:@selector(userButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:userButton];


    [self initDetailsTableFooterViewArray:salesList.imageList];

    [bgImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(60);
    }];


    [userImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@20);
        make.size.equalTo(CGSizeMake(40, 40));

    }];

    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.top.equalTo(@15);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(30);
    }];


    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@31);
        make.right.equalTo(self).offset(-10);
        make.size.equalTo(CGSizeMake(15, 18));
    }];

    [userButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.right.equalTo(self).offset(@0);
        make.size.equalTo(CGSizeMake(200, 60));
    }];

}
- (void)initAuthenticateLabelText:(NSMutableArray *)array{

    @autoreleasepool
    {
        UILabel *label = (UILabel *)[self viewWithTag:400];
        [label removeFromSuperview];


        CGFloat width = 0;
        if (![[NSString stringWithFormat:@"%@",array] isEqualToString:@"<null>"]) {

            for (int i = 0; i < array.count; i++ ) {
                CGSize nameSize = STRING_SIZE_FONT(SCREEN_WIDTH-100, [array objectAtIndex:i], 12);
                UILabel  *certificationLabel = [[UILabel alloc]initWithFrame:CGRectMake(60 + width, 45, nameSize.width, 12)];
                width = nameSize.width + width +10;
                certificationLabel.textColor = [UIColor colorWithRed:252/255.0 green:194/255.0 blue:9/255.0 alpha:1];
                certificationLabel.layer.borderColor = [UIColor colorWithRed:252/255.0 green:194/255.0 blue:9/255.0 alpha:1].CGColor;
                certificationLabel.layer.borderWidth = 1.0;
                certificationLabel.tag = 400;
                certificationLabel.layer.cornerRadius = 2;
                certificationLabel.layer.masksToBounds = YES;
                certificationLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
                certificationLabel.textAlignment = NSTextAlignmentCenter;
                certificationLabel.font = [UIFont systemFontOfSize:9];
                [self addSubview:certificationLabel];

            }
            
        }
    }

}
- (void)initDetailsTableFooterViewArray:(NSMutableArray *)salesArray{
    if (![[NSString stringWithFormat:@"%@",salesArray] isEqualToString:@"<null>"]) {
        @autoreleasepool
        {
            [_imageArray removeAllObjects];
            int totalloc=3;
            CGFloat appvieww=(SCREEN_WIDTH- 20)/3-5;
            CGFloat appviewh=(SCREEN_WIDTH- 20)/3-5;
            CGFloat margin=((SCREEN_WIDTH- 20) -totalloc*appvieww)/(totalloc+1);

            for (int i = 0; i < salesArray.count; i++) {

                int row=i/totalloc;//行号
                //1/3=0,2/3=0,3/3=1;
                int loc=i%totalloc;//列号
                CGFloat appviewx=margin+(margin+appvieww)*loc;
                CGFloat appviewy=margin+(margin+appviewh)*row;
                UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
                imageButton.frame = CGRectMake(appviewx +10, appviewy + 80, (SCREEN_WIDTH - 20)/3 - 5, (SCREEN_WIDTH - 20)/3 - 5);
                // 判断类型来获取Image
                //                [imageButton setBackgroundImage:[UIImage imageNamed:@"h3.jpg"] forState:UIControlStateNormal];

                [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                imageButton.tag = 200 +i;

                [self addSubview:imageButton];
                imageButton = nil;

                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(appviewx +10, appviewy + 80, (SCREEN_WIDTH - 20)/3 - 5, (SCREEN_WIDTH - 20)/3 - 5)];
                [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,[salesArray objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
                [_imageArray addObject:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,[salesArray objectAtIndex:i]]];
                [self addSubview:image];
                image = nil;
                
            }
            
        }
    }
}
- (void)imageButtonClick:(UIButton *)button{
    self.footerImage(_imageArray,button.tag -200);
}
- (void)userButtonClick{

    self.userBtn(nil);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
