//
//  MainTabbarViewController.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/8.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "LoginViewController.h"
#import "MyViewController.h"
#import "Header.h"
@interface MainTabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation MainTabbarViewController

-(void)awakeFromNib{
    [super awakeFromNib];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //设置主题风格
    [self customizeAppearance];
    self.delegate = self;
    RequestBody * requestBody = [RequestBody defualtRequestBody];
    NSLog(@"自定义方法实现单例:%@",requestBody);
    NSLog(@"%@",requestBody.loginRequestBody);
    
    NSLog(@"tabbar:window.subviews:%@",[[[UIApplication sharedApplication]delegate]window].subviews);

}

/**
 学习cf和f 的方法  主要是关键字和对象的所有权
 */
-(void)testCoreFoundationAndFoundation
{
    id __weak obj = [[NSMutableArray alloc]init];
    [obj addObject:@"obj"];
    NSLog(@"%@",obj);
}

-(void)getDataFromRSA
{
    NetworkTask * task = [NetworkTask new];
    [task obtainPOSTDataFrom:@"http://192.168.1.245:8081/banner/info" With:CustomSessionHeaderApplicationJson Withparmart:nil];
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UINavigationController * naVC = (UINavigationController *)self.selectedViewController;
    //点击的item 对应的页面的导航控制器
    UINavigationController *navSelected = (UINavigationController *)viewController;
    if ([[navSelected.topViewController class] isEqual:[MyViewController class]] && ![UserDefaults objectForKey:@"isLogin"]) {
        LoginViewController * loginVC = [LoginViewController loadLoginVC];
        loginVC.hidesBottomBarWhenPushed = YES;
        [naVC pushViewController:loginVC animated:YES];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 主题  导航栏和tabbar主题
 */
-(void)customizeAppearance
{
    // 设置状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    // UINavigationBar设置
    UINavigationBar *navigationBar = [UINavigationBar appearance];
//    navigationBar.barTintColor = [UIColor redColor];// 背景色
    navigationBar.translucent = NO;//取消透明效果
    // 字体设置
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName, nil];// [UIFont boldSystemFontOfSize:20], NSFontAttributeName,
    navigationBar.titleTextAttributes = dict;
    
    // 去掉UINavigationBar底部的黑边
//    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [navigationBar setShadowImage:[[UIImage alloc] init]];
    // UITabBar设置
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setTintColor:[UIColor redColor]];// 点击后的颜色
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
