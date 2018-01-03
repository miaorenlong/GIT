
//
//  CustomBankViewController.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/23.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//
#import "CustomBankViewController.h"
#import "BankTableViewCell.h"
#import "CustomTableView.h"
@interface CustomBankViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong)NSArray * provinceArray;
@property(nonatomic,strong)NSArray * listArray;
@end
static NSString * identifierCustom = @"indentifierCustom";
@implementation CustomBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self upInitUI];
}
/**
 初始化UI
 */
-(void)upInitUI
{
    CustomTableView * tableView = [[CustomTableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"BankTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifierCustom];
    tableView.tableFooterView = [UIView new];
    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizerClick:)];
//    [tableView addGestureRecognizer:tap];
//    tap.delegate = self;
    
}

#pragma mark dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierCustom];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textField.delegate = self;
    cell.textField.tag = 200 + indexPath.row;
    cell.listLabel.text = self.listArray[indexPath.row];
    return cell;
}
#pragma mark -- 点击事件方法和代理方法
//-(void)tapGestureRecognizerClick:(UITapGestureRecognizer *)tap
//{
//    UITextField * textField1 = [self.view viewWithTag:200];
//    UITextField * textField2 = [self.view viewWithTag:201];
//
//    [self textFieldShouldReturn:textField1];
//    [self textFieldShouldReturn:textField2];
//}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if ([[touch.view.superview class] isEqual:[BankTableViewCell class]]) {
//        return NO;
//    }
//    return YES;
//}

#pragma mark --delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankTableViewCell * cell =  [tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark --- textfield的delegate
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//
//    return [textField resignFirstResponder];
//}

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
