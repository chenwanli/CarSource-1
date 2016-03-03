//
//  OtherGuaranteeViewCell.m
//  CarSource
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "OtherGuaranteeViewCell.h"

@implementation OtherGuaranteeViewCell
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
    [self addSubview:_userButton];

    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = BLACK;
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_nameLabel];

    _personalLabel = [[UILabel alloc]init];
    _personalLabel.textColor = BLACK;
    _personalLabel.text = @"定金:";
    _personalLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_personalLabel];

    self.amountLabel = [[UILabel alloc]init];
    
    self.amountLabel.textColor = [UIColor redColor];
    self.amountLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.amountLabel];


    _configuration = [[UILabel alloc]init];
    _configuration.textAlignment = NSTextAlignmentLeft;
    _configuration.textColor = BLACK;
    _configuration.numberOfLines = 0;
    _configuration.font = [UIFont systemFontOfSize:14];
    [self addSubview:_configuration];


    self.detailedLabel = [[UILabel alloc]init];
    self.detailedLabel.textAlignment = NSTextAlignmentLeft;
    self.detailedLabel.textColor = [UIColor grayColor];
    self.detailedLabel.numberOfLines = 0;
    self.detailedLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview: self.detailedLabel];



//    _timeLabel = [[UILabel alloc]init];
//    _timeLabel.textAlignment = NSTextAlignmentRight;
//    _timeLabel.textColor = [UIColor lightGrayColor];
//    _timeLabel.numberOfLines = 0;
//    _timeLabel.font = [UIFont systemFontOfSize:13];
//    [_timeLabel sizeToFit];
//    [self addSubview:_timeLabel];

    self.payLabel = [[UILabel alloc]init];
    self.payLabel.textAlignment = NSTextAlignmentCenter;
    self.payLabel.textColor = [UIColor redColor];
    self.payLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.payLabel];


    _promptLabel = [[UILabel alloc]init];
    _promptLabel.text = @"(支付担保金)";
    _promptLabel.textAlignment = NSTextAlignmentCenter;
    _promptLabel.textColor = [UIColor redColor];
    _promptLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_promptLabel];


    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_payButton];

    self.credentialsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.credentialsBtn setTitle:@"查看凭证" forState:UIControlStateNormal];
    self.credentialsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.credentialsBtn setTitleColor:COLOR forState:UIControlStateNormal];
    [self addSubview:self.credentialsBtn];


    UIImageView *lineImage = [[UIImageView alloc]init];

    lineImage.backgroundColor = GRAY;
    [self addSubview:lineImage];



    [self.userImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(40, 40));
    }];

    [_userButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(40, 40));
    }];

    [_personalLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.top.equalTo(@30);
        make.size.equalTo(CGSizeMake(40, 20));
    }];

    [self.amountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@100);
        make.top.equalTo(@30);
        make.size.equalTo(CGSizeMake(100, 20));
    }];

    [_configuration makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@50);
        make.right.equalTo(self).offset(-90);
        make.height.equalTo(@35);
    }];


    [self.payLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@20);
        make.size.equalTo(CGSizeMake(80, 25));
    }];

    [_promptLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@40);
        make.size.equalTo(CGSizeMake(80, 20));
    }];

    [_payButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(@25);
        make.size.equalTo(CGSizeMake(80, 50));
    }];
    [self.credentialsBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.size.equalTo(CGSizeMake(80, 30));
    }];

    [lineImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.bottom.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@1);
    }];

}
- (void)initName:(NSString *)name certification:(NSMutableArray *)certification detailed:(CGFloat)detailed{

     CGSize nameHeight = STRING_SIZE_FONT(SCREEN_WIDTH/2, name, 16);
    _nameLabel.frame = CGRectMake(60, 0, nameHeight.width, 30);
    _nameLabel.text = name;

    self.detailedLabel.frame = CGRectMake(10, 85, SCREEN_WIDTH - 20, detailed);

    @autoreleasepool
    {
        UILabel *label = (UILabel *)[self viewWithTag:400];
        [label removeFromSuperview];


        CGFloat width = 0;
        if (![[NSString stringWithFormat:@"%@",certification] isEqualToString:@"<null>"]) {
            
            for (int i = 0; i < certification.count; i++ ) {
                CGSize nameSize = STRING_SIZE_FONT(SCREEN_WIDTH-130, [certification objectAtIndex:i], 12);
                UILabel  *certificationLabel = [[UILabel alloc]initWithFrame:CGRectMake(70 + width + nameHeight.width, 9, nameSize.width, 12)];
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
- (CGFloat)heightString:(NSString *)string widthStr:(NSInteger)widthStr{

    CGSize size = STRING_SIZE_FONT(SCREEN_WIDTH-20, string, 15);

    return size.height;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
