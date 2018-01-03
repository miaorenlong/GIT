//
//  AlertVC.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/11.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "AlertVC.h"

@implementation AlertVC

+(void)loadAlertConrollerTitle:(NSString *)title WithMessage:(NSString *)message with:(UIViewController *)viewVC
{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:action];
    [viewVC presentViewController:alertVC animated:YES completion:nil];
}

@end
