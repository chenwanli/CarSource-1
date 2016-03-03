//
//  TradingViewCell.m
//  CarSource
//
//  Created by apple on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TradingViewCell.h"

@implementation TradingViewCell

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
    self.userImage = [[UIImageView alloc]init];
    [self addSubview:self.userImage];

    _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _userButton.layer.cornerRadius = 25;
//    _userButton.layer.masksToBounds = YES;
//    [_userButton setBackgroundImage:[UIImage  imageNamed:@"ww.jpg"] forState:UIControlStateNormal];
    [self addSubview:_userButton];

    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = BLACK;
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_nameLabel];

    _personalLabel = [[UILabel alloc]init];
    _personalLabel.textColor = BLACK;
    _personalLabel.text = @"定金";
    _personalLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_personalLabel];

    self.moneyLabel = [[UILabel alloc]init];
    self.moneyLabel.textColor = [UIColor redColor];
    self.moneyLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.moneyLabel];

    self.sellerLabel = [[UILabel alloc]init];
    self.sellerLabel.textColor = BLACK;
    self.sellerLabel.text = @"卖家";
    self.sellerLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.sellerLabel];

    self.userLabel = [[UILabel alloc]init];
    self.userLabel.textColor = COLOR;
    self.userLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.userLabel];

    _configuration = [[UILabel alloc]init];
    _configuration.textAlignment = NSTextAlignmentLeft;
    _configuration.textColor = BLACK;
    _configuration.numberOfLines = 0;
    _configuration.font = [UIFont systemFontOfSize:14];
    [self addSubview:_configuration];

    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.numberOfLines = 0;
    _timeLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_timeLabel];

    _credentialsBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    _credentialsBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _credentialsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_credentialsBtn setTitleColor:[UIColor colorWithRed:248/255.0 green:0/255.0 blue:0/255.0 alpha:1]forState:UIControlStateNormal];
    [self addSubview:_credentialsBtn];

//    UIImageView *lineImage = [[UIImageView alloc]init];
//    lineImage.backgroundColor = [UIColor colorWithRed:215/255.0 green:234/255.0 blue:255/255.0 alpha:1];
//    [self addSubview:lineImage];

    [self.userImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@15);
        make.size.equalTo(CGSizeMake(50, 50));
    }];

    [_userButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@15);
        make.size.equalTo(CGSizeMake(50, 50));
    }];

    [_personalLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.top.equalTo(@30);
        make.size.equalTo(CGSizeMake(40, 25));
    }];
    

    [_credentialsBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-5);
        make.top.equalTo(@30);
        make.size.equalTo(CGSizeMake(60, 30));
    }];

    [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-5);
        make.top.equalTo(@55);
        make.size.equalTo(CGSizeMake(70, 20));
    }];

//    [lineImage makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(0);
//        make.bottom.equalTo(self).offset(@0);
//        make.right.equalTo(self).offset(@0);
//        make.height.equalTo(@1);
//    }];

}
- (void)moneyText:(NSString *)moneyText {

    CGSize moneySize = STRING_SIZE_FONT(120, moneyText, 14);

    self.moneyLabel.frame = CGRectMake(105, 30, moneySize.width, 25);
    self.sellerLabel.frame = CGRectMake(moneySize.width +110, 30, 40, 25);
    self.userLabel.frame = CGRectMake(moneySize.width +150, 30, SCREEN_WIDTH - moneySize.width -170, 25);

}
- (void)initName:(NSString *)name certification:(NSMutableArray *)certification detailed:(CGFloat)detailed{

    CGSize nameHeight = STRING_SIZE_FONT(SCREEN_WIDTH/2, name, 16);
    _nameLabel.frame = CGRectMake(70, 5, nameHeight.width, 30);
    _nameLabel.text = name;
    self.configuration.frame = CGRectMake(70, 50, SCREEN_WIDTH - 130, detailed +10);
    @autoreleasepool
    {
        UILabel *label = (UILabel *)[self viewWithTag:400];
        [label removeFromSuperview];


        CGFloat width = 0;
        if (![[NSString stringWithFormat:@"%@",certification] isEqualToString:@"<null>"]) {

            for (int i = 0; i < certification.count; i++ ) {
                CGSize nameSize = STRING_SIZE_FONT(SCREEN_WIDTH-130, [certification objectAtIndex:i], 12);
                UILabel  *certificationLabel = [[UILabel alloc]initWithFrame:CGRectMake(80 + width + nameHeight.width, 15, nameSize.width, 12)];
                width = nameSize.width + width +10;
                certificationLabel.textColor = [UIColor colorWithRed:252/255.0 green:194/255.0 blue:9/255.0 alpha:1];
                certificationLabel.layer.borderColor = [UIColor colorWithRed:252/255.0 green:194/255.0 blue:9/255.0 alpha:1].CGColor;
                certificationLabel.layer.borderWidth = 1.0;
                certificationLabel.tag = 400;
                certificationLabel.layer.cornerRadius = 2;
                certificationLabel.layer.masksToBounds = YES;
                certificationLabel.text = [NSString stringWithFormat:@"%@",[certification objectAtIndex:i]];
                certificationLabel.textAlignment = NSTextAlignmentCenter;
                certificationLabel.font = [UIFont systemFontOfSize:9];
                [self addSubview:certificationLabel];

            }
            
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
