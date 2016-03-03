//
//  PersonalViewCell.m
//  CarSource
//
//  Created by apple on 16/1/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PersonalViewCell.h"
@interface PersonalViewCell ()<UITextFieldDelegate,UITextViewDelegate>{
   
}

@end
@implementation PersonalViewCell
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

    self.personalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 30)];
    self.personalLabel.font = [UIFont systemFontOfSize:16];
    self.personalLabel.textColor = BLACK;
    [self addSubview:self.personalLabel];

//    UIImageView  *image = [[UIImageView alloc]init];
//    image.backgroundColor = [UIColor colorWithRed:157/255.0 green:212/255.0 blue:232/255.0 alpha:1];
//    [self addSubview:image];
//
//    [image makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@10);
//        make.bottom.equalTo(@0);
//        make.right.equalTo(self).offset(-10);
//        make.height.equalTo(@1);
//    }];
//

}
- (void)initPortraitImage{
    [self.portraitImage removeFromSuperview];
    self.portraitImage = [[UIImageView alloc]init];
    self.portraitImage.layer.cornerRadius = 30;
    self.portraitImage.layer.masksToBounds = YES;
    [self addSubview:self.portraitImage];
    self.personalLabel.frame = CGRectMake(10, 10, 50, 60);
    [self.userButton removeFromSuperview];
    self.userButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.userButton.layer.cornerRadius = 30;
//    self.userButton.layer.masksToBounds = YES;

    [self addSubview:self.userButton];

    [self.portraitImage makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(60, 60));
    }];


    [self.userButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
    
}
- (void)initContentLabel{

    [self.contentLabel removeFromSuperview];
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [UIColor grayColor];
    [self addSubview:self.contentLabel];

    [self.contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(160, 30));
    }];

}
- (void)initcontentTextPlaceholder:(NSString *)placeholder{

    [self.contentText removeFromSuperview];
    self.contentText = [[UITextField alloc]init];
    self.contentText.font = [UIFont systemFontOfSize:14];
    
    self.contentText.textColor = [UIColor grayColor];
    self.contentText.placeholder = placeholder;
    //    self.contentText.borderStyle = UITextBorderStyleRoundedRect;
    //    self.contentText.textColor = [UIColor grayColor];
    //    self.contentText.backgroundColor = [UIColor colorWithRed:224/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    [self.contentText setReturnKeyType : UIReturnKeyDone ];
    //    _nameText.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:self.contentText];

    [self.contentText makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@50);
    }];

}
- (void)initTextView{

    [self.regionLabel removeFromSuperview];
    self.regionLabel = [[UILabel alloc]init];
    self.regionLabel.textColor = COLOR;
    self.regionLabel.textAlignment = NSTextAlignmentRight;
    self.regionLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.regionLabel];

    UIImageView *image = (UIImageView *)[self viewWithTag:100];
    [image removeFromSuperview];

    UIImageView *milledImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 25, 25, 15, 18)];
    milledImage.tag = 100;
    milledImage.image = [UIImage imageNamed:@"milled"];
    [self addSubview:milledImage];

    [self.regionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(-40);
        make.height.equalTo(@50);
    }];

    [milledImage makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@16);
        make.size.equalTo(CGSizeMake(15, 18));
    }];



}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
