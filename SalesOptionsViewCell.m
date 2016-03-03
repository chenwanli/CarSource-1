//
//  SalesOptionsViewCell.m
//  CarSource
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SalesOptionsViewCell.h"

@interface SalesOptionsViewCell () 
{
    UIView *_salesView;
    NSMutableArray *_imageArray;
}

@end
@implementation SalesOptionsViewCell
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
    _imageArray = [[NSMutableArray alloc]init];
    _configuration = [[UILabel alloc]init];
    _configuration.textAlignment = NSTextAlignmentLeft;
    _configuration.textColor = [UIColor grayColor];
    //    _configuration.backgroundColor = [UIColor greenColor];
    _configuration.numberOfLines = 0;
    _configuration.font = [UIFont systemFontOfSize:15];
    [_configuration sizeToFit];
    [self addSubview:_configuration];

    _displayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _displayBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_displayBtn setTitleColor:[UIColor colorWithRed:18/255.0 green:152/255.0 blue:234/255.0 alpha:1]forState:UIControlStateNormal];
    [self addSubview:_displayBtn];
//    _salesView = [[UIView alloc]init];
//    [self addSubview:_salesView];

    UIImageView *lineImage = [[UIImageView alloc]init];
    lineImage.backgroundColor = GRAY;
    [self addSubview:lineImage];

    [lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.bottom.equalTo(self).offset(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@1);
    }];


}
- (void)configurationHeight:(CGFloat)height isOpen:(BOOL)isOpen salesArray:(NSMutableArray *)salesArray{
    [_salesView removeFromSuperview];
    if (![[NSString stringWithFormat:@"%@",salesArray] isEqualToString:@"<null>"]) {
        @autoreleasepool
        {
            [_imageArray removeAllObjects];
            _salesView = [[UIView alloc]init];
            
            [self addSubview:_salesView];
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

                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(appviewx +10, appviewy +10, (SCREEN_WIDTH - 20)/3 - 5, (SCREEN_WIDTH - 20)/3 - 5)];
                image.tag = 300;
                [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,[salesArray objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
                [_imageArray addObject:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,[salesArray objectAtIndex:i]]];
                [_salesView addSubview:image];
                image = nil;

                UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
                imageButton.frame = CGRectMake(appviewx +10, appviewy + 10, (SCREEN_WIDTH - 20)/3 - 5, (SCREEN_WIDTH - 20)/3 - 5);
                // 判断类型来获取Image
                //                [imageButton setBackgroundImage:[UIImage imageNamed:@"h3.jpg"] forState:UIControlStateNormal];

                [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                imageButton.tag = 200 +i;

                [_salesView addSubview:imageButton];
                imageButton = nil;
                if (i == salesArray.count -1) {
//                    int line=(i +1)/totalloc;//行号
                    int j= 0;
                    if (i  < 3) {
                        j = 1;
                    }else if (i< 6){
                        j = 2;
                    }else{
                        j = 3;
                    }


                    _salesView.frame = CGRectMake(0, height + 10, SCREEN_WIDTH, appviewh *j );
                }
            }

        }

    }
//    if (isOpen)
//    {
//        [_displayBtn setTitle:@"[点击收起]" forState:UIControlStateNormal];
//        _displayBtn.frame = CGRectMake(10, height, 100, 30);
//    }
//    else
//    {
//        [_displayBtn setTitle:@"[查看更多]" forState:UIControlStateNormal];
//        _displayBtn.frame = CGRectMake(10, height, 100, 30);
//    }


    _configuration.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, height);
    
    //     _salesView.frame = CGRectMake(50, height + 100, SCREEN_WIDTH-100, salesHeight);
}
- (void)imageButtonClick:(UIButton *)button{
    self.salesImage(_imageArray,button.tag - 200);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
