//
//  TestTouchViewController.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/25.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "TestTouchViewController.h"

@interface TestTouchViewController ()

@end

@implementation TestTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchClick:)];
    [self.firstLevel addGestureRecognizer:tap];
}
-(void)touchClick:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击的是:%ld",tap.view.tag);
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
