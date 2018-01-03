//
//  TextViewController.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/19.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "TextViewController.h"
#import "TestView.h"
#import "calendarView.h"
#import "CalendarUntil.h"
@interface TextViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)TestView * testView;
@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:view];
    view.tag = 100;
    view.backgroundColor = [UIColor grayColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnTouchClick) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 300, 100, 50);
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
-(void)btnTouchClick
{
    UIView * view = (UIView *)[self.view viewWithTag:100];
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, 20, 200);
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //NSLog(@"%@",touches);
    NSLog(@"%@",event);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    calendarView * calendar = [[calendarView alloc]initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:calendar];
}
-(void)loadTestView
{
    TestView * testview = [TestView defaultTestView];
    testview.frame = CGRectMake(0, 100, self.view.bounds.size.width, 200);
    [self.view addSubview:testview];
    NSLog(@"%@",NSStringFromCGRect(testview.anotherBtn.frame));
    
    self.testView = testview;
    BOOL result = 0;
    if (result) {
        testview.cornerBtn.hidden = YES;
    }else{
        testview.cornerBtn.hidden = NO;
    }
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 500, self.view.bounds.size.width, 20)];
    [self.view addSubview:label];
    label.backgroundColor = [UIColor grayColor];
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
