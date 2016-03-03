//
//  PersonalViewController.m
//  CarSource
//
//  Created by apple on 16/1/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalViewCell.h"
#import "UserDataModel.h"
#import "SelectAreaViewController.h"

@interface PersonalViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>{
    NSMutableArray *_personalArray;
     NSInteger _editing;
    NSString *_userName;//用户昵称
    NSString *_companyName;//用户公司名称
    NSString *_companyPosition;//用户职称;
    NSString *_introduction;//简介
    NSString *_provincesIdStr;//地区ID
    NSString *_provincesStr;
    NSString *_text;
}
@property (nonatomic,strong)UITableView *personalTable;
@property (nonatomic,strong)PersonalViewCell *cell;
@property (nonatomic,assign)CGFloat personal;
@property (nonatomic,strong)UITextView *textview;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _userName = @"";//用户昵称
    _companyName= @"";//用户公司名称
    _companyPosition= @"";//用户职称;
    _introduction= @"";//简介
    _provincesStr = @"";//地区
    _provincesIdStr = @"";
    NavView *nav = [[NavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.titleLabel.text = @"个人资料";
    [self.view addSubview:nav];
    nav.returnButton = ^(NSString *returnButton){
        [self.navigationController popViewControllerAnimated:YES];
    };

    self.personal = 20;
    
    _personalArray = [[NSMutableArray alloc]initWithObjects:@"头像",@"类型",@"账号",@"昵称",@"公司",@"职位",@"服务区域", nil];
    self.personalTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    // 表的强大在于它的协议方法, 所有的东西都需要通过协议方法来设置
    // 设置代理
    self.personalTable.delegate = self;
    // 设置数据源
    self.personalTable.dataSource = self;
    self.personalTable.bounces = NO;
    // 全局设置单元格的高度,但是所有的行高 都必须是一样得
    self.personalTable.backgroundColor = [UIColor whiteColor];
//    self.personalTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    // 如果同时也使用了协议方法  ,以协议方法为主
    [self.view addSubview:self.personalTable];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    [self initPersonalViewController];

}
- (void)initPersonalViewController{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 250)];

    UIImageView  *image = [[UIImageView alloc]init];
    image.backgroundColor = GRAY;
    [view addSubview:image];
    
    [image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.right.equalTo(view).offset(@0);
        make.height.equalTo(@1);
    }];
    

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 30)];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"简介：";
    label.textColor = BLACK;
    [view addSubview:label];


    self.textview = [[UITextView alloc] initWithFrame:CGRectMake(60, 10, SCREEN_WIDTH -70, 140)];
    self.textview.backgroundColor=[UIColor whiteColor]; //背景色
    self.textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    self.textview.editable = YES;
    self.textview.delegate = self;
    //是否允许编辑内容，默认为“YES”
    self.textview.layer.borderColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:254/255.0 alpha:1].CGColor;
    self.textview.layer.borderWidth = 1.0;
    self.textview.textColor = [UIColor grayColor];
    self.textview.text = @"请输入您公司的简介";
    self.textview.font=[UIFont fontWithName:@"Arial" size:15.0]; //设置字体名字和字体大小;
    self.textview.returnKeyType = UIReturnKeyDone;//return键的类型
    self.textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    //    self.textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    self.textview.textColor = [UIColor grayColor];
    //    textview.text = @"UITextView详解";//设置显示的文本内容
    [view addSubview:self.textview];

     UserDataModel *data = [self.dataArray objectAtIndex:0];
     self.textview.text = data.userText;
    if ([data.userText isEqualToString:@""]) {
        _editing = 1;
    }


    UIButton *submitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"确定" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(50,180, SCREEN_WIDTH - 100, 50);
    submitButton.titleLabel.font = [UIFont systemFontOfSize:20];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    //    [_submitButton setTitleColor:COLOR forState:UIControlStateNormal];
    submitButton.backgroundColor = COLOR;
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:submitButton];

    self.personalTable.tableFooterView = view;
}
#pragma --
#pragma mark 修改资料

- (void)submitButtonClick:(UIButton *)button{

    [self.view endEditing:YES];
//    NSLog(@"_userName = %@ _companyName = %@  _companyPosition %@ self.textview.text%@",_userName,_companyName,_companyPosition,self.textview.text);

    if ([_text isEqualToString:@"" ]|| _text == nil) {
        if ([_companyName isEqualToString:@""] &&[_companyPosition isEqualToString:@""] &&[_introduction isEqualToString:@""] &&[_provincesIdStr isEqualToString:@""] ) {
            SHOW_ALERT(@"请填写你要修改的内容");
            return;
        }

    }

     LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [LCCoolHUD showLoading:@"正在修改" inView:self.view];
    [RequestClass postModifyTheUserDataInterfaceRequestWithUserId:login.userId userName:_userName userText:_introduction companyPosition:_companyPosition companyName:_companyName addressArea:_provincesIdStr Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {

        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"] ) {

            [LCCoolHUD showSuccess:@"修改成功" zoom:YES shadow:YES];
            NSMutableArray *array = [[NSMutableArray alloc]init];
            if (![_introduction isEqualToString:@""]) {
                login.userText = _introduction;
            }
            if (![_userName isEqualToString:@""]) {
                login.userName = _userName;
            }

            [array addObject:login];
            [Serialization initSerializationArray:array];
            [SkinManager sharedSkinManager].countTest = 1000;
        }


    }];

}
///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.personalTable.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - kbHeight);
 }

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
     self.personalTable.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
}
#pragma --

#pragma mark UITableViewCell

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _personalArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    self.cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!self.cell)
    {
        self.cell = [[PersonalViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cell.backgroundColor = [UIColor whiteColor];
        UserDataModel *data = [self.dataArray objectAtIndex:0];
        switch (indexPath.row ) {
            case 0:
            {
                LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];
                [self.cell initPortraitImage];
                [self.cell.portraitImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PICTUREADDRESS,login.userUrl]] placeholderImage:[UIImage imageNamed:@"005.jpg"]];
                [self.cell.userButton addTarget:self action:@selector(userButtonClick) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 1:
            {
                [self.cell initContentLabel];
                self.cell.contentLabel.text = [NSString stringWithFormat:@"%@",data.userType];
            }
                break;
            case 2:
            {
                 [self.cell initContentLabel];
                 self.cell.contentLabel.text =[NSString stringWithFormat:@"%@", data.userTel];
            }
                break;
            case 3:
            {
                [self.cell initcontentTextPlaceholder:@"请填写您的昵称"];
                self.cell.contentText.tag = indexPath.row;
                self.cell.contentText.delegate = self;
                if ([_userName isEqualToString:@""]) {
                    self.cell.contentText.text = [NSString stringWithFormat:@"%@",data.userName];
                    _userName = [NSString stringWithFormat:@"%@",data.userName];

                }else{
                    self.cell.contentText.text = _userName;

                }

            }
                break;
            case 4:
            {
                [self.cell initcontentTextPlaceholder:@"请填写您所在公司名称"];
                self.cell.contentText.tag = indexPath.row;
                self.cell.contentText.delegate = self;
                if ([_companyName isEqualToString:@""]) {
                     self.cell.contentText.text = [NSString stringWithFormat:@"%@",data.companyName];
                }else{
                    self.cell.contentText.text = _companyName;
                }

            }
                break;
            case 5:
            {
                [self.cell initcontentTextPlaceholder:@"请填写您所在公司职位"];
                self.cell.contentText.tag = indexPath.row;
                self.cell.contentText.delegate = self;
                if ([_companyPosition isEqualToString:@""]) {
                    self.cell.contentText.text = [NSString stringWithFormat:@"%@",data.companyPosition];
                }else{
                    self.cell.contentText.text = _companyPosition;
                }


            }
                break;
            case 6:
            {
                [self.cell initTextView];
                if ([_provincesStr isEqualToString:@""]) {
                     self.cell.regionLabel.text = [NSString stringWithFormat:@"%@",data.addressArea];
                }else{
                     self.cell.regionLabel.text = _provincesStr;
                }

            }
                break;
            default:
                break;
        }



    }
    self.cell.personalLabel.text = [_personalArray objectAtIndex:indexPath.row];



    return self.cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        SelectAreaViewController *selectArea = [[SelectAreaViewController alloc]init];
        [self.navigationController pushViewController:selectArea animated: YES];
        selectArea.provinces = ^(NSString *provincesStr,NSString *provincesIdStr,NSString *areaStr){
            if ([areaStr isEqualToString:@""] || areaStr == nil ||[provincesStr isEqualToString:@""]|| provincesStr == nil) {

                if ([areaStr isEqualToString:@""] || areaStr == nil) {
                    _provincesStr = provincesStr;
                     _provincesIdStr = [NSString stringWithFormat:@"/%@",provincesStr];
                }else{
                    _provincesStr = areaStr;
                     _provincesIdStr = [NSString stringWithFormat:@"%@/",areaStr];
                }

            }else{
                _provincesStr = [NSString stringWithFormat:@"%@/%@",areaStr,provincesStr];
                _provincesIdStr = [NSString stringWithFormat:@"%@/%@",areaStr,provincesStr];

            }

            [tableView reloadData];
        };

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }else{
        return 50;
    }

}
#pragma
#pragma mark UITextField

- (void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"textField.text = %@",textField.text);
    switch (textField.tag) {
        case 3:
        {
            _userName = textField.text;
            _text = textField.text;
        }
            break;
        case 4:
        {
             _companyName = textField.text;
        }
            break;
        case 5:
        {
             _companyPosition = textField.text;
        }
            break;

        default:
            break;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}

#pragma
#pragma mark UITextView

//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    if (_editing == 1) {
        _textview.text = @"";
        _textview.textColor = [UIColor blackColor];
    }

    return YES;
}

//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
}

//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    _editing = 2;
    if ([textView.text isEqualToString:@""] || textView.text == nil ) {
        _editing = 1;
        _textview.text = @"请输入您公司的简介";
        _textview.textColor = [UIColor grayColor];
    }else{
        _introduction = textView.text;
    }
}

//- (void)textViewDidChange:(UITextView *)textView
//{
//    CGSize size = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), MAXFLOAT)];
//    CGRect frame = textView.frame;
//    frame.size.height = size.height;
//
//    textView.frame = frame;
//}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return YES; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }

    return YES;
}

- (void)userButtonClick{
    [self photoAvatar];
}
#pragma --

#pragma mark 选中图片之后执行的方法和取消调用相机或相册之后执行的方法
- (void)photoAvatar
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开相机",@"打开相册", nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"index   %d",buttonIndex);

    int type = 0;

    switch (buttonIndex) {
        case 0:
            // 打开相机
            type = UIImagePickerControllerSourceTypeCamera;

            // 判断相机来源 是否支持
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"打开照相机失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];

                return;
            }
            break;
        case 1:
            // 打开相册
            type = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            //取消
            return;
            break;
        default:
            break;
    }

    // 创建picker
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = type;
    pickerController.delegate = self;
    [pickerController setAllowsEditing:YES];
    [self presentViewController:pickerController animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    LoginModel *login = [[Serialization initNSKeyedUnarchiver] objectAtIndex:0];

    [LCCoolHUD showLoading:@"正在上传" inView:self.view];
    [RequestClass postModifyTheUserHeadRequestWithUserId:login.userId image:image Completion:^(NSMutableArray *saleArray, NSString *errorMessage) {

        [LCCoolHUD hideInView:self.view];
        if ([errorMessage isEqualToString:@"0"] ) {

             [LCCoolHUD showSuccess:@"上传成功" zoom:YES shadow:YES];
             NSMutableArray *array = [[NSMutableArray alloc]init];
            for (LoginModel *user in saleArray) {
                login.userUrl = user.userUrl;
                [array addObject:login];
            }
            [Serialization initSerializationArray:array];
            [SkinManager sharedSkinManager].countTest = 1000;
            [_personalTable reloadData];
        }
        [picker dismissViewControllerAnimated:YES completion:nil];

    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
