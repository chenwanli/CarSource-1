//
//  OtherGuaranteeView.h
//  CarSource
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^payRefund) (NSInteger pay);
typedef void (^credentials) (NSMutableArray *credentialsArray);
@interface OtherGuaranteeView : UIView
@property (nonatomic,strong)payRefund payRefund;
@property (nonatomic,strong)credentials credentials;
@end
