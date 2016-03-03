//
//  AllModelsViewController.h
//  CarSource
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^allModels) (NSString *carSeriesTypeName,NSString *carSeriesTypeId);
@interface AllModelsViewController : UIViewController
@property (nonatomic,strong)NSString *modelsStr;
@property (nonatomic,assign)NSInteger navCount;
@property (nonatomic,strong)allModels allModels;
@end
