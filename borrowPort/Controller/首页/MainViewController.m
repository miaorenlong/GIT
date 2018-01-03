//
//  MainViewController.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/8.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "MainViewController.h"
#import "ImageScaleViewController.h"
#import "ImagePhotoViewController.h"
#import "PageViewController.h"
@interface MainViewController ()
@property(nonatomic,strong)PageViewController * pageVC;
@end

@implementation MainViewController

+(instancetype)loadMainVC{
    UIStoryboard * stroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MainViewController * mainVC = [stroyBoard instantiateViewControllerWithIdentifier:@"MainViewController"];
    return mainVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    if (@available (iOS 11 , *)){
    NSLog(@"safeAreaInsets%@",NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
        NSLog(@"safeAreaLayoutGuide%@",self.view.safeAreaLayoutGuide);
    }

    NSLog(@"导航栏的frame:%@",NSStringFromCGRect(self.navigationController.navigationBar.frame));
    NSLog(@"tabbar的frame:%@",NSStringFromCGRect(self.tabBarController.tabBar.frame));
    NSLog(@"状态栏的frame:%@",NSStringFromCGRect([UIApplication sharedApplication].statusBarFrame));
}

/**
 初始化 ui
 */
-(void)initUI{
    self.navigationItem.title = @"援米贷";
    self.loanTypeView.hidden = NO;

    UIWindow * window = [self lastWindow];
    NSLog(@"首页中:window.subviews:%@",window.subviews);
    PageViewController * pageVC = [[PageViewController alloc]init];
    [window addSubview:pageVC.view];
    self.pageVC = pageVC;
    [self addChildViewController:pageVC];
    NSLog(@"首页中:window.subviews:%@",window.subviews);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removePageView) name:@"removePageVC" object:nil];
}
/**
 获取最上层windows
 
 @param UIWindow windows
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
//通知移除 导图
-(void)removePageView
{
    [self.pageVC.view removeFromSuperview];
    [self.pageVC removeFromParentViewController];
    self.pageVC = nil;
}
-(void)viewDidAppear:(BOOL)animated
{
    NSArray * windows = [UIApplication sharedApplication].windows;
    NSLog(@"%@",windows);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取本地相册 PickerVC
//    ImageScaleViewController * imageScaleVC = [ImageScaleViewController loadImageVC];
//    imageScaleVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:imageScaleVC animated:YES];
//    ImagePhotoViewController * imagePhotoVC = []
    ImagePhotoViewController * imagePhotoVC = [ImagePhotoViewController loadImagePhotoVC];
    imagePhotoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:imagePhotoVC animated:YES];
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
