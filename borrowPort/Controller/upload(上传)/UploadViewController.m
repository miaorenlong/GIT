

//
//  UploadViewController.m
//  borrowPort
//
//  Created by 夏财祥 on 2018/1/2.
//  Copyright © 2018年 众鑫贷. All rights reserved.
//

#import "UploadViewController.h"

@interface UploadViewController ()

@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self uploadTests];
}

-(void)uploadTests
{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/miaorenlong/GITCode.git"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:1];
    
    UIImage * image = [UIImage imageNamed:@"01.jpg"];
    NSLog(@"%@",image);
    NSData * dataImage = UIImageJPEGRepresentation(image, 0);
    NSURLSessionUploadTask * task = [session uploadTaskWithRequest:request fromData:dataImage completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",response);
    }];
    [task resume];
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
