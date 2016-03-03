//
//  MethodOfPaymentCell.m
//  CarSource
//
//  Created by apple on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MethodOfPaymentCell.h"

@implementation MethodOfPaymentCell
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

    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 60)];
    bgImage.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgImage];
    _payImage = [[UIImageView alloc]init];
    [self addSubview:_payImage];

    _bankImage = [[UIImageView alloc]init];
    _bankImage.image = [UIImage imageNamed:@"sheep"];
    [self addSubview:_bankImage];

    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_payButton setImage:[UIImage imageNamed:@"sheep"] forState:UIControlStateNormal];
    [self addSubview:_payButton];

    _payLabel = [[UILabel alloc]init];
    _payLabel.textColor = [UIColor grayColor];
    _payLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_payLabel];

    _instructionsLabel = [[UILabel alloc]init];
    _instructionsLabel.textColor = [UIColor lightGrayColor];
    _instructionsLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_instructionsLabel];

    _chooseImage = [[UIImageView alloc]init];
    [self addSubview:_chooseImage];

    [_payImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@20);
        make.size.equalTo(CGSizeMake(60, 40));
    }];

    [_instructionsLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@40);
        make.size.equalTo(CGSizeMake(200, 25));
    }];

    [_chooseImage makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@30);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
}
- (void)initMethodOfPaymentCellText:(NSString *)text{

    CGSize promptSize = STRING_SIZE_FONT(SCREEN_WIDTH-130, text, 16);
    _payLabel.frame = CGRectMake(80, 10, promptSize.width +10, 35);
    _bankImage.frame = CGRectMake(promptSize.width +80, 20, 16, 12);
    _payButton.frame = CGRectMake(promptSize.width +50, 0, 60, 50);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
