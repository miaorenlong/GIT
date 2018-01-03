//
//  LoginViewController.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/11.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "LoginViewController.h"
#import "Header.h"
#import "UILabel+Category.h"
@interface LoginViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UITableView * subTableView;
@end

@implementation LoginViewController

/**
 初始化

 @return LoginVC
 */
+(instancetype)loadLoginVC{
    UIStoryboard  *storyBoard = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    LoginViewController * vc = [storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [UserDefaults setObject:[NSMutableArray arrayWithObjects:@"12332112345",@"14884198765", nil] forKey:@"PhoneArray"];
    self.phoneNumbeTF.delegate = self;
    self.passwordTF.delegate = self;
    self.verifiTF.delegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldIntputing:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHeight:) name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark UITextfield delegate

//键盘收回方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.phoneNumbeTF.text.length != 11 && textField == self.phoneNumbeTF) {
        [AlertVC loadAlertConrollerTitle:@"警告" WithMessage:@"输入正确的手机号" with:self];
    }
    if ([self illegalcharacters:self.passwordTF.text]) {
        [AlertVC loadAlertConrollerTitle:@"警告" WithMessage:@"输入字符中不要有特殊字符,长度为6到18" with:self];
    }
    if (self.verifiTF == textField) {
        CGRect bounds = CGRectMake(0, 0, self.view.width,self.view.height);
        self.view.bounds = bounds;
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!self.subTableView && textField == self.phoneNumbeTF) {
        [self setUpPhoneTableView:textField];
    }
    
    if (self.verifiTF == textField) {
        CGRect bounds = CGRectMake(0, 100, self.view.width,self.view.height);
        [UIView animateWithDuration:3 animations:^{
            self.view.bounds = bounds;
        }];
    }
    
}
#pragma mark  增加账户提示功能,两个通知事件
-(void)textFieldIntputing:(NSNotification *)noti
{
    UITextField * tf = noti.object;
    
    NSLog(@"%@",noti);
    if ([self.phoneNumbeTF.text isEqualToString:@"0"]) {
        self.phoneNumbeTF.text = nil;
    }
   if (!self.subTableView &&  tf == self.phoneNumbeTF ) {
        [self setUpPhoneTableView:self.phoneNumbeTF];
    }
}
-(void)keyboardHeight:(NSNotification *)noti
{
    NSValue *value = noti.userInfo[@"UIKeyboardBoundsUserInfoKey"];
    CGRect rect =  [value CGRectValue];
    self.keyboardHeight = rect.size.height;
    
}
/**
 创建tableView  缓存的手机号

 @param textField phoneTF
 */
-(void)setUpPhoneTableView:(UITextField * )textField
{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(textField.originX, textField.originY + textField.height, textField.width, self.view.height - textField.originY - textField.height - self.keyboardHeight - 10) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.subTableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"phoneIndeti"];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchTableViewTap:)];
    [tableView addGestureRecognizer:tap];
    tap.delegate = self;
}

#pragma mark  tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"phoneIndeti"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    self.phoneNumbeTF.text = cell.textLabel.text;
    [self.subTableView removeFromSuperview];
    self.subTableView =  nil;
}

/**
 登录按钮方法

 @param sender btn
 */
- (IBAction)loginTouchClick:(UIButton *)sender {
    //此处应该有网络请求 然后带着账号还有密码上传给后台,后台判断然后返回success
    NetworkTask * task = [[NetworkTask alloc]init];
//    task obtainPOSTDataFrom:<#(NSURL *)#> With:<#(CustomSessHeader)#> Withparmart:<#(NSMutableDictionary *)#>
    //在登录成功方法中做进一步的处理
    //代理还是不错
    //可以用block 和 delegate 做回调 那个好????????
    
}

/**
 判断是否有非法字符

 @return 返回yes表示有特殊字符
 */
-(BOOL)illegalcharacters:(NSString *)string{
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_"];
    s = [s invertedSet];
    NSRange r = [string rangeOfCharacterFromSet:s];
    if (r.location !=NSNotFound || string.length <= 6 || string.length >= 18)
    {
        return YES;
    }

    return NO;
}

#pragma mark - 各种各样的点击事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self textFieldShouldReturn:self.phoneNumbeTF];
    [self textFieldShouldReturn:self.passwordTF];
    if (self.subTableView) {
        [self.subTableView removeFromSuperview];
        self.subTableView = nil;
    }
}
-(void)touchTableViewTap:(UITapGestureRecognizer *)tap
{
    if (self.subTableView) {
        [self.subTableView removeFromSuperview];
        self.subTableView = nil;
    }
}

#pragma mark - 点击事件的代理事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return YES; //返回yes允许走他自己的点击事件,No 该点击事件无用
    }
    return NO;
}


-(NSMutableArray *)dataArray
{
    _dataArray = [UserDefaults objectForKey:@"PhoneArray"];
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

}


@end
