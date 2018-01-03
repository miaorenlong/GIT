//
//  BankViewController.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/22.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "BankViewController.h"
#import "BankTableViewCell.h"
#import "CustomBtn.h"
#import "UIView+Category.h"
#import <objc/runtime.h>
#define MAC 55
@interface BankViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong)NSArray * provinceArray;
@property(nonatomic,strong)NSArray * listArray;
@property(nonatomic,strong)UITableView * subTableView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,copy)NSString * TFString;
@property(nonatomic,strong)UITextField * changingTF;

@end
static NSString * identifierCustom = @"indentifierCustom";
static NSString * subIdentifier = @"subIdentifier";

@implementation BankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self upInitUI];
    
//    CustomBtn * btn = [CustomBtn buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(100, 300, 100, 60);
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setTitle:@"点击" forState:UIControlStateNormal];
//    [btn setTitle:@"===" forState:UIControlStateHighlighted];
//    [btn setTitle:@"===" forState:UIControlStateSelected];
//
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(btnTouchInside:) forControlEvents:UIControlEventTouchUpInside];
//
}
-(void)btnTouchInside:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

/**
 初始化UI
 */
-(void)upInitUI
{
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"BankTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifierCustom];
    tableView.tableFooterView = [UIView new];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizerClick:)];
    [tableView addGestureRecognizer:tap];
    self.tableView = tableView;
    tap.delegate = self;
    
}
-(void)setUpsubTableView:(UITextField * )textField with:(BankTableViewCell *)cell
{
    
    NSLog(@"%@%@",NSStringFromCGRect(textField.frame),NSStringFromCGRect(cell.frame));
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(textField.originX,textField.originY + textField.height + cell.height,textField.width,200) style:UITableViewStylePlain];
    self.subTableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:subIdentifier];
}

#pragma mark dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.subTableView) {
        return self.provinceArray.count;
    }
    return self.listArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.subTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:subIdentifier];
        cell.textLabel.text = self.provinceArray[indexPath.row];
        return cell;
    }
    BankTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierCustom];
//  cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.delegate = self;
    cell.textField.tag = 200 + indexPath.row;
    cell.listLabel.text = self.listArray[indexPath.row];
    return cell;
}

#pragma mark -- 点击事件方法和代理方法
-(void)tapGestureRecognizerClick:(UITapGestureRecognizer *)tap
{
    UITextField * textField1 = [self.view viewWithTag:200];
    UITextField * textField2 = [self.view viewWithTag:201];

    [self textFieldShouldReturn:textField1];
    [self textFieldShouldReturn:textField2];
}

#pragma mark ---点击的代理事件,来判断是否处理自定义的点击事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([[touch.view.superview class]  isEqual:[UITableViewCell class]]) {
        return NO;
    }else{
        if (self.subTableView) {
            [self.subTableView removeFromSuperview];
            self.subTableView = nil;
        }
    }
    NSLog(@"%@",touch.view.superview);
    
    //先判断子视图  然后再判断父视图
    if ([[touch.view class] isEqual:[UITextField class]]) {
        BankTableViewCell * cell = (BankTableViewCell *)touch.view.superview.superview;
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        if ([cell.listLabel.text isEqualToString:@"省份"]) {
            self.changingTF = cell.textField;
            [self setUpsubTableView:cell.textField with:cell];
            [self.tableView addSubview:self.subTableView];
            cell.textField.inputView = view;
        }
        return YES;
    }
    if ([[touch.view.superview class] isEqual:[BankTableViewCell class]]) {
        return NO;
    }
    
    return YES;
}

#pragma mark --delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.subTableView) {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        self.changingTF.text = cell.textLabel.text;
    }
    if (tableView == self.tableView) {
        BankTableViewCell * cell =  [tableView cellForRowAtIndexPath:indexPath];
        [cell.textField resignFirstResponder];
    }
}

#pragma mark --- textfield的delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
/**
 获取最上层windows
 @return windows
 */
- (UIWindow *)lastWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}
#pragma mark -- 懒加载
-(NSArray *)provinceArray
{
    if (_provinceArray == nil) {
        _provinceArray = @[@"河南",@"北京",@"河北",@"上海"];
    }
    return _provinceArray;
}
-(NSArray *)listArray
{
    if (_listArray == nil) {
        _listArray = @[@"姓名",@"省份"];
    }
    return _listArray;
}

/*
 
 第一种方法实现是:设置-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
            方法.
        当点击在视图上面的时候,响应链 第一个响应的是最下方的父视图,他检查自己是否能够响应点击,然后从他的子视图检查
 
 */

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
