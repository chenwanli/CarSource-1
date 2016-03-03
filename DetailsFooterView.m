//
//  DetailsFooterView.m
//  CarSource
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DetailsFooterView.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"


@interface DetailsFooterView ()<UITextViewDelegate>{
    UITextView *_textview;
    UIButton *_submitButton;
    UIView *_addView;
    UIButton *_addButton;
    UIButton *_cancelButton;
    NSInteger _cancel;
    NSMutableArray *_imageArray;
}

@end
@implementation DetailsFooterView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{

    self.backgroundColor = GRAY;
    _cancel = 1;
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.text = @"  上传凭证：合同协议等";
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.textColor = [UIColor grayColor];
    textLabel.backgroundColor = [UIColor colorWithRed:227/255.0 green:241/255.0 blue:255/255.0 alpha:1];
    [self addSubview:textLabel];


    [textLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(self).offset(@0);
        make.height.equalTo(@44);
    }];

    _imageArray = [[NSMutableArray alloc]init];
    _cancelButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(SCREEN_WIDTH - 100, 0, 100, 44);
    [_cancelButton setTitle:@"取消删除" forState:UIControlStateNormal];

    [_cancelButton setTitle:@"删除" forState:UIControlStateSelected];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancelButton setTitleColor:COLOR forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
    _cancelButton.hidden = YES;


    _addView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, (SCREEN_WIDTH - 20)/3 +20)];
    _addView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_addView];


    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(10, 10, (SCREEN_WIDTH - 10)/3 - 10, (SCREEN_WIDTH - 20)/3-10);
    [_addButton setBackgroundImage:[UIImage imageNamed:@"gift"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addView addSubview:_addButton];


    _submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_submitButton setTitle:@"确定提交" forState:UIControlStateNormal];
    _submitButton.frame = CGRectMake(50,(SCREEN_WIDTH - 20)/3 +100, SCREEN_WIDTH - 100, 50);
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _submitButton.layer.cornerRadius = 5;
    _submitButton.layer.masksToBounds = YES;
    //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    _submitButton.backgroundColor = COLOR;
    [_submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_submitButton];



}
- (void)initAddImageArray:(NSMutableArray *)imageArray height:(CGFloat)height cancel:(BOOL)cancel{

    if (cancel == YES) {
        [_addView removeFromSuperview];

        _addView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH,20 +height)];
        _addView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_addView];

        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"gift"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_addView addSubview:_addButton];
        

    }else{
        if (imageArray.count == 0) {
            _cancelButton.hidden = YES;
            _addView.frame = CGRectMake(0, 44, SCREEN_WIDTH, 20 +height);
            _addButton.frame = CGRectMake(10, 10, (SCREEN_WIDTH - 10)/3 - 10, (SCREEN_WIDTH - 20)/3-10);
            _submitButton.frame = CGRectMake(50,height +100, SCREEN_WIDTH - 100, 50);
            
        }else{
            _addView.frame = CGRectMake(0, 44, SCREEN_WIDTH, 20 +height);
            _submitButton.frame = CGRectMake(50,100 +height, SCREEN_WIDTH - 100, 50);
        }


    }


    @autoreleasepool
    {

        [_imageArray removeAllObjects];
        int totalloc=3;
        CGFloat appvieww=(SCREEN_WIDTH- 20)/3-5;
        CGFloat appviewh=(SCREEN_WIDTH- 20)/3-5;
        CGFloat margin=((SCREEN_WIDTH- 20) -totalloc*appvieww)/(totalloc+1);

        for (int i = 0; i < imageArray.count; i++) {

            int row=i/totalloc;//行号
            //1/3=0,2/3=0,3/3=1;
            int loc=i%totalloc;//列号
            CGFloat appviewx=margin+(margin+appvieww)*loc;
            CGFloat appviewy=margin+(margin+appviewh)*row;
            UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            imageButton.frame = CGRectMake(appviewx +10, appviewy +10, (SCREEN_WIDTH - 20)/3 - 10, (SCREEN_WIDTH - 20)/3 - 10);
            // 判断类型来获取Image
            MLSelectPhotoAssets *asset = imageArray[i];

            NSData *imageData = [self imageQuality1500kb:[MLSelectPhotoPickerViewController getImageWithImageObj:asset]];
            [_imageArray addObject:imageData];

            [imageButton setBackgroundImage:[MLSelectPhotoPickerViewController getImageWithImageObj:asset] forState:UIControlStateNormal];

            [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            imageButton.tag = i ;

            [_addView addSubview:imageButton];

            imageButton = nil;

            if (_cancel == 1) {
                UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
                deleteButton.frame = CGRectMake(appviewx +(SCREEN_WIDTH - 20)/3 -22, appviewy +2, 30, 30);
                [deleteButton setBackgroundImage:[UIImage imageNamed:@"esc"] forState:UIControlStateNormal];
                [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                deleteButton.tag = i +1;
                [_addView addSubview:deleteButton];
                deleteButton = nil;

            }

            if (i == imageArray.count -1) {

                _cancelButton.hidden = NO;
                int line=(i +1)/totalloc;//行号
                //1/3=0,2/3=0,3/3=1;
                int column=(i +1)%totalloc;//列号
                CGFloat x=margin+(margin+appvieww)*column;
                CGFloat y=margin+(margin+appviewh)*line;
                if (i<8) {

                    _addButton.hidden = NO;
                    _addButton.frame = CGRectMake(x+10, y +10, (SCREEN_WIDTH - 20)/3 - 10, (SCREEN_WIDTH - 20)/3 - 10);
                }else{
                    _addButton.hidden = YES;
                }
            }
        }
    }
    
}
- (NSData *)imageQuality1500kb:(UIImage *)img{
    if (img) {
        int perMBBytes = 1024*1024;
        CGImageRef cgimage = img.CGImage;
        size_t bpp = CGImageGetBitsPerPixel(cgimage);
        size_t bpc = CGImageGetBitsPerComponent(cgimage);
        size_t bytes_per_pixel = bpp/bpc;

        long lPixelsPerMB = perMBBytes/bytes_per_pixel;
        long totalpixel = CGImageGetWidth(img.CGImage)*CGImageGetHeight(img.CGImage);
        if (totalpixel/lPixelsPerMB > 8) {
            NSData *imgData = UIImageJPEGRepresentation(img, IMAGE);

            return imgData;
        }else{
            return UIImageJPEGRepresentation(img, 1.0);
        }
    }
    return UIImageJPEGRepresentation(img, 1.0);
}

- (void)submitButtonClick:(UIButton *)button{

    self.imageArr(_imageArray);

}

//查看大图
- (void)imageButtonClick:(UIButton *)button
{
    self.toViewImage(button.tag);
}
//删除图片
- (void)deleteButtonClick:(UIButton *)button{

    self.deleteImage(button.tag-1);

}
//取消删除
- (void)cancelButtonClick:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        _cancel = 0;
    }else{
        _cancel = 1;
    }

    self.canceldelete(nil);
}
//添加图片
- (void)addButtonClick:(UIButton *)button{

    self.addImage(nil);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
