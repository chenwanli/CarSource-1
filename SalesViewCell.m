//
//  SalesViewCell.m
//  CarSource
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SalesViewCell.h"
@interface SalesViewCell (){
    NSMutableArray *_imageArr;
    UIView *_bgView;
    UIView *_certificationView;
}
@end
@implementation SalesViewCell
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

    _imageArr = [[NSMutableArray alloc]init];

    self.userImage = [[UIImageView alloc]init];
    [self addSubview:self.userImage];

    _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _userButton.layer.cornerRadius = 15;
//    _userButton.layer.masksToBounds = YES;
//    [_userButton setBackgroundImage:[UIImage  imageNamed:@"h1.jpg"] forState:UIControlStateNormal];
    [self addSubview:_userButton];

    _telButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_telButton setBackgroundImage:[UIImage  imageNamed:@"cat"] forState:UIControlStateNormal];
    [self addSubview:_telButton];

    _informationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_informationBtn setBackgroundImage:[UIImage  imageNamed:@"body"] forState:UIControlStateNormal];
    [self addSubview:_informationBtn];


    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1];
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_nameLabel];

    _addressLabel = [[UILabel alloc]init];
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    _addressLabel.textColor = [UIColor lightGrayColor];
    _addressLabel.numberOfLines = 0;
    _addressLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_addressLabel];

//    _salesView = [[UIView alloc]init];
//    [self addSubview:_salesView];

    _configuration = [[UILabel alloc]init];
    _configuration.textAlignment = NSTextAlignmentLeft;
    _configuration.textColor = [UIColor grayColor];
//    _configuration.backgroundColor = [UIColor greenColor];
    _configuration.numberOfLines = 0;
    _configuration.font = [UIFont systemFontOfSize:15];
    [self addSubview:_configuration];

    _displayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _displayBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_displayBtn setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateNormal];
    [self addSubview:_displayBtn];


    _lineImage = [[UIImageView alloc]init];
    _lineImage.backgroundColor = GRAY;
    [self addSubview:_lineImage];

//    for (int i = 0; i < 3; i++) {
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((40 *i) +50 , 35, 30 +5*i, 13)];
//        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"c%d",i +1]];
//        [self addSubview:imageView];
//    }
//
   

    [_lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@1);
    }];

    [self.userImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@15);
        make.size.equalTo(CGSizeMake(30, 30));

    }];

    [_userButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@15);
        make.size.equalTo(CGSizeMake(30, 30));

    }];

    [_informationBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(30, 30));

    }];

    [_telButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-60);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(30, 30));

    }];



}
- (void)initAuthenticateLabelText:(NSMutableArray *)array{

    @autoreleasepool
    {
//        UILabel *label = (UILabel *)[self viewWithTag:400];
//        [label removeFromSuperview];
        [_certificationView removeFromSuperview];
        _certificationView = [[UIView alloc]initWithFrame:CGRectMake(50, 30, SCREEN_WIDTH - 130, 20)];
        [self addSubview:_certificationView];

        CGFloat width = 0;
        if (![[NSString stringWithFormat:@"%@",array] isEqualToString:@"<null>"]) {

            for (int i = 0; i < array.count; i++ ) {
                CGSize nameSize = STRING_SIZE_FONT(SCREEN_WIDTH-130, [array objectAtIndex:i], 12);
                UILabel  *certificationLabel = [[UILabel alloc]initWithFrame:CGRectMake( width, 4, nameSize.width, 12)];
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
                [_certificationView addSubview:certificationLabel];

            }
            
        }
    }


}
- (void)salesViewCellNameText:(NSString *)text salesHeightView:(CGFloat)salesHeight configurationHeight:(CGFloat)height isOpen:(BOOL)isOpen salesArray:(NSMutableArray *)salesArray{

    CGSize nameSize = STRING_SIZE_FONT(SCREEN_WIDTH-130, text, 16);
    _nameLabel.frame = CGRectMake(50, 5, nameSize.width +10, 30);
    _addressLabel.frame = CGRectMake(nameSize.width +50, 5, 120, 30);

    [_bgView removeFromSuperview];
    _bgView = [[UIView alloc]init];
    //    _bgView.backgroundColor = [UIColor redColor];
    [self addSubview:_bgView];

    if (![[NSString stringWithFormat:@"%@",salesArray] isEqualToString:@"<null>"]) {
        @autoreleasepool
        {
            [_imageArr removeAllObjects];

//                UIImageView *imageView = (UIImageView *)[self viewWithTag:300];
//                [imageView removeFromSuperview];
            int totalloc=3;
            CGFloat appvieww=(SCREEN_WIDTH- 60)/3-5;
            CGFloat appviewh=(SCREEN_WIDTH- 60)/3-5;
            CGFloat margin=((SCREEN_WIDTH- 60) -totalloc*appvieww)/(totalloc+1);

            for (int i = 0; i < salesArray.count; i++) {

                
                int row=i/totalloc;//行号
                //1/3=0,2/3=0,3/3=1;
                int loc=i%totalloc;//列号
                CGFloat appviewx=margin+(margin+appvieww)*loc;
                CGFloat appviewy=margin+(margin+appviewh)*row;

                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(appviewx +50, appviewy, (SCREEN_WIDTH - 60)/3 - 5, (SCREEN_WIDTH - 60)/3 - 5)];
                image.tag = 300;
                [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,[salesArray objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
                [_imageArr addObject:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,[salesArray objectAtIndex:i]]];

                [_bgView addSubview:image];
                image = nil;

                UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
                imageButton.frame = CGRectMake(appviewx +50, appviewy, (SCREEN_WIDTH - 60)/3 - 5, (SCREEN_WIDTH - 60)/3 - 5);
                imageButton.tag = 500 +i;
                [_bgView addSubview:imageButton];
                [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                imageButton = nil;


                if (i == salesArray.count -1) {
//                    int j=(i +1)/totalloc;//行号
//                    NSLog(@"j=== %d",j);
                    int j= 0;
                    if (i  < 3) {
                        j = 1;
                    }else if (i< 6){
                        j = 2;
                    }else{
                        j = 3;
                    }

                    _bgView.frame = CGRectMake(0, height + 70, SCREEN_WIDTH, appviewh *j + 10);
                }
                
            }
            
        }

    }
    if (isOpen)
    {
        [_displayBtn setTitle:@"[点击收起]" forState:UIControlStateNormal];
         _displayBtn.frame = CGRectMake(40, height +48, 100, 30);
    }
    else
    {
        [_displayBtn setTitle:@"[查看更多]" forState:UIControlStateNormal];
         _displayBtn.frame = CGRectMake(40, height +45, 100, 30);
    }


    _configuration.frame = CGRectMake(50, 55, SCREEN_WIDTH - 60, height);

//     _salesView.frame = CGRectMake(50, height + 100, SCREEN_WIDTH-100, salesHeight);



}
- (void)imageButtonClick:(UIButton *)button{
    self.imageUrl(_imageArr,button.tag - 500);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
