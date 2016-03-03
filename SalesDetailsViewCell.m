//
//  SalesDetailsViewCell.m
//  CarSource
//
//  Created by apple on 16/2/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SalesDetailsViewCell.h"

@implementation SalesDetailsViewCell
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

    self.salesLabel = [[UILabel alloc]init];
    self.salesLabel.textAlignment = NSTextAlignmentLeft;
    self.salesLabel.textColor = [UIColor grayColor];
    self.salesLabel.numberOfLines = 0;
    self.salesLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.salesLabel];

    self.details = [[UILabel alloc]initWithFrame:CGRectMake(70, 7, SCREEN_WIDTH - 80, 30)];
    self.details.textAlignment = NSTextAlignmentLeft;
    self.details.textColor = BLACK;
    self.details.numberOfLines = 0;
    self.details.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.details];

    [self.salesLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@7);
        make.size.equalTo(CGSizeMake(60, 30));
        
    }];


}
- (void)initSalesLabelHeight:(NSInteger)height{
    self.details.frame =  CGRectMake(70, 7, SCREEN_WIDTH - 80, height+10);

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
