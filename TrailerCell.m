//
//  TrailerCell.m
//  CarSource
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "TrailerCell.h"
#import "UserTrailerList.h"
@interface TrailerCell (){
    NSString *_usetTrailerTel;
    NSString *_userTel;
}

@end
@implementation TrailerCell
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
    _carImage = [[UIImageView alloc]init];

    [self addSubview:_carImage];
    _typeImage = [[UIImageView alloc]init];

    [self addSubview:_typeImage];


    _leftView = [[UIView alloc]init];
    _leftView.backgroundColor = [UIColor colorWithRed:202/255.0 green:225/255.0 blue:245/255.0 alpha:1];
    [self addSubview:_leftView];
    _rightView = [[UIView alloc]init];
    _rightView.backgroundColor = [UIColor colorWithRed:202/255.0 green:225/255.0 blue:245/255.0 alpha:1];
    [self addSubview:_rightView];

    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = BLACK;
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:15];
    [_nameLabel sizeToFit];
    [_leftView addSubview:_nameLabel];

    _typeLabel = [[UILabel alloc]init];
    _typeLabel.textColor = BLACK;
    _typeLabel.numberOfLines = 0;
    _typeLabel.font = [UIFont systemFontOfSize:15];
    [_typeLabel sizeToFit];
    [_rightView addSubview:_typeLabel];


    _leftService = [[UILabel alloc]init];
    _leftService.textColor = [UIColor grayColor];
    _leftService.numberOfLines = 0;
    _leftService.font = [UIFont systemFontOfSize:13];
    [_leftService sizeToFit];
    [_leftView addSubview:_leftService];

    _rightService = [[UILabel alloc]init];
    _rightService.textColor = [UIColor grayColor];
    _rightService.numberOfLines = 0;
    _rightService.font = [UIFont systemFontOfSize:13];
    [_rightService sizeToFit];
    [_rightView addSubview:_rightService];

    _leftName = [[UILabel alloc]init];
    _leftName.textColor = [UIColor grayColor];
    _leftName.numberOfLines = 0;
    _leftName.font = [UIFont systemFontOfSize:13];
    [_leftName sizeToFit];
    [_leftView addSubview:_leftName];

    _rightName = [[UILabel alloc]init];
    _rightName.textColor = [UIColor grayColor];
    _rightName.numberOfLines = 0;
    _rightName.font = [UIFont systemFontOfSize:13];
    [_rightName sizeToFit];
    [_rightView addSubview:_rightName];

    _leftPhone = [UIButton buttonWithType:UIButtonTypeSystem];
    _leftPhone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [_leftPhone setTitle:@"18689620485" forState:UIControlStateNormal];
    _leftPhone.titleLabel.font = [UIFont systemFontOfSize: 18.0];
    [_leftPhone setBackgroundImage:[UIImage imageNamed:@"cat"] forState:UIControlStateNormal];
    [_leftPhone addTarget:self action:@selector(leftPhoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_leftView addSubview:_leftPhone];

    _rightPhone = [UIButton buttonWithType:UIButtonTypeSystem];
//    [_rightPhone setTitle:@"18689620485" forState:UIControlStateNormal];
    _rightPhone.titleLabel.font = [UIFont systemFontOfSize:18.0];
     [_rightPhone setBackgroundImage:[UIImage imageNamed:@"cat"] forState:UIControlStateNormal];
    _rightPhone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_rightPhone addTarget:self action:@selector(rightPhoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightView addSubview:_rightPhone];



//    _leftcertification = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"certification"]];
//
//    [_leftView addSubview:_leftcertification];
//
//    _rightcertification = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"certification"]];
//
//    [_rightView addSubview:_rightcertification];

//    _leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phone"]];
//
//    [_leftView addSubview:_leftImage];
//
//   _rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phone"]];
//
//    [_rightView addSubview:_rightImage];

    [_carImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-12, 100));
    }];


    [_typeImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2+5);
        make.top.equalTo(@10);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-13, 100));
    }];

    [_leftPhone makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_leftView).offset(-10);
        make.bottom.equalTo(_leftView).offset(-10);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    [_rightPhone makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_rightView).offset(-10);
        make.bottom.equalTo(_rightView).offset(-10);
        make.size.equalTo(CGSizeMake(30, 30));
    }];


//    [leftcertification makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(SCREEN_WIDTH/2-50);
//        make.top.equalTo(@13);
//        make.size.equalTo(CGSizeMake(30, 12));
//    }];
//    [rightcertification makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(SCREEN_WIDTH/2-50);
//        make.top.equalTo(@13);
//        make.size.equalTo(CGSizeMake(30, 12));
//    }];


}
- (void)initTrailerCellArray:(NSMutableArray *)trailerArray{

    for (int i = 0; i < 2; i++) {

        UserTrailerList *trailer = [trailerArray objectAtIndex:i];
        if (i == 0) {

            _usetTrailerTel = [NSString stringWithFormat:@"%@",trailer.usetTrailerTel];
             [_carImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,trailer.userTrailerUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
//            NSLog(@" trailer.userCompanyName = %@",[NSString stringWithFormat:@"%@", trailer.userCompanyName]);
            if ([[NSString stringWithFormat:@"%@", trailer.userCompanyName] isEqualToString:@"<null>"] || trailer.userCompanyName == nil) {
            }else{
                CGSize nameSize = STRING_SIZE_FONT(SCREEN_WIDTH/2-30, trailer.userCompanyName, 15);
                _nameLabel.text = [NSString stringWithFormat:@"%@",trailer.userCompanyName];


            //    _nameLabel.backgroundColor = [UIColor redColor];
//            _leftcertification.frame = CGRectMake(SCREEN_WIDTH/2-55, 12, 30, 12);
            CGSize leftService = STRING_SIZE_FONT(SCREEN_WIDTH/2-30, trailer.userServiceType, 13);
            _leftService.text = [NSString stringWithFormat:@"%@",trailer.userServiceType];
            //    _nameLabel.backgroundColor = [UIColor redColor];
              _leftName.text = [NSString stringWithFormat:@"%@",trailer.userName];;
            [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@10);
                make.top.equalTo(@5);
                make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-70, nameSize.height +10));
            }];

            [_leftService makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@10);
                make.top.equalTo(nameSize.height +10);
                make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-70, leftService.height +10));
            }];

            [_leftName makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@10);
                make.top.equalTo(nameSize.height +leftService.height +20 );
                make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-70, 20));
            }];
            [_leftView makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@10);
                make.top.equalTo(@110);
                make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-12, nameSize.height +leftService.height +50));
            }];
        }
//            NSLog(@"authenticateList = %@",trailer.authenticateList);

            if (![[NSString stringWithFormat:@"%@",trailer.authenticateList] isEqualToString:@"<null>"]) {
                for (int j = 0; j < trailer.authenticateList.count; j++) {
                     CGSize size = STRING_SIZE_FONT(60, [trailer.authenticateList objectAtIndex:j], 8);
                    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(size.width *j + (SCREEN_WIDTH/2 - 65) +8, 12, size.width, 12)];
                    label.text = [trailer.authenticateList objectAtIndex:j];
                    label.textColor = [UIColor redColor];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.font = [UIFont systemFontOfSize:8];
                    label.backgroundColor = [UIColor yellowColor];
                    [_leftView addSubview:label];
                }
            }
        }else{

            _userTel = [NSString stringWithFormat:@"%@",trailer.usetTrailerTel];
            [_typeImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,trailer.userTrailerUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];

            CGSize typeSize = STRING_SIZE_FONT(SCREEN_WIDTH/2-30, trailer.userCompanyName, 15);
            //    _typeLabel.backgroundColor = [UIColor greenColor];
            _typeLabel.text = [NSString stringWithFormat:@"%@",trailer.userCompanyName];
            _rightcertification.frame = CGRectMake(SCREEN_WIDTH/2-55, 12, 30, 12);
            CGSize rightService = STRING_SIZE_FONT(SCREEN_WIDTH/2-30, trailer.userServiceType, 13);
            //    _typeLabel.backgroundColor = [UIColor greenColor];
            _rightService.text = [NSString stringWithFormat:@"%@",trailer.userServiceType];
            _rightName.text = [NSString stringWithFormat:@"%@",trailer.userName];


            [_typeLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@10);
                make.top.equalTo(@5);
                make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-70, typeSize.height +10));
            }];

            [_rightService makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@10);
                make.top.equalTo(typeSize.height +10);
                make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-70, rightService.height +10));
            }];

            [_rightName makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@10);
                make.top.equalTo(typeSize.height +rightService.height +20);
                make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-70, 20));
            }];

            [_rightView makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(SCREEN_WIDTH/2+5);
                make.top.equalTo(@110);
                make.size.equalTo(CGSizeMake(SCREEN_WIDTH/2-13, typeSize.height +rightService.height +50));
            }];
            if (![[NSString stringWithFormat:@"%@",trailer.authenticateList] isEqualToString:@"<null>"]) {
                for (int j = 0; j < trailer.authenticateList.count; j++) {
                    CGSize size = STRING_SIZE_FONT(60, [trailer.authenticateList objectAtIndex:j], 8);
                    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(size.width *j + (SCREEN_WIDTH/2 - 65) +8, 12, size.width, 12)];
                    label.text = [trailer.authenticateList objectAtIndex:j];
                    label.textColor = [UIColor redColor];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.font = [UIFont systemFontOfSize:8];
                    label.backgroundColor = [UIColor yellowColor];
                    [_rightView addSubview:label];
                }
            }


        }
    }
}
- (void)leftPhoneButtonClick:(UIButton *)button{

    if (![_usetTrailerTel isEqualToString:@""] || _usetTrailerTel != nil) {
//        NSLog(@"_usetTrailerTel %@",_usetTrailerTel);
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_usetTrailerTel]]];

    }

}
- (void)rightPhoneButtonClick:(UIButton *)button{

    if (![_userTel isEqualToString:@""] || _userTel != nil) {
//         NSLog(@"_userTel %@",_userTel);
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_userTel]]];

    }

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
