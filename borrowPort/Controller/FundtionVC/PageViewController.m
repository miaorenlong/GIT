//
//  PageViewController.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/15.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "PageViewController.h"
#import "ContentViewController.h"
@interface PageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property(nonatomic,strong)NSMutableArray* pageContentArray;
@end

@implementation PageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPageVC];
}
-(void)loadPageVC
{
    //设置  配置项
    NSDictionary * options = @{UIPageViewControllerOptionInterPageSpacingKey:@(UIPageViewControllerSpineLocationMin)};
    
    UIPageViewController * pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    pageVC.view.frame = self.view.bounds;
    pageVC.delegate = self;
    pageVC.dataSource = self;
    
    ContentViewController * initVC = [self viewControllerAtIndex:0];
    NSArray * viewControllers= @[initVC];
    [pageVC setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    
    [self addChildViewController:pageVC];
    [self.view addSubview:pageVC.view];
    
}
#pragma mark -- datasouce
-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index ++;
    if (index == self.pageContentArray.count) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
//    NSLog(@"%s",__func__);
    index --;
    return [self viewControllerAtIndex:index];
}
#pragma mark -- delegate
//可以知道从那个页面过来 这个方法是动画结束调用
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    ContentViewController * contentVC = (ContentViewController *)previousViewControllers.firstObject;
    
#warning 这个方法为啥不响应呢
    if ([pageViewController.dataSource respondsToSelector:@selector(presentationCountForPageViewController:)]) {
        NSInteger currentIndex = [self presentationCountForPageViewController:pageViewController];
    }
    //成功
    if (completed) {
        if (self.direction == RightDirection) {
            self.currentIndex = contentVC.number + 1 ;
            if (self.currentIndex == 3) {
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"removePageVC" object:nil userInfo:nil];
            }
        }else{
            self.currentIndex = contentVC.number - 1 ;
        }
    }else{
        self.currentIndex = contentVC.number;
    }
}
//将要偏移
- (void)pageViewController:(UIPageViewController*)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    ContentViewController * contentVC = (ContentViewController *)pendingViewControllers.firstObject;
    if (self.currentIndex < contentVC.number) {
        //表示向右跳转
        self.direction = RightDirection;
    }else{
        self.direction = LeftDirection;
    }
}

//初始化控制器
-(ContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if ([self.pageContentArray count] == 0 ||index >= self.pageContentArray.count) {
        return nil;
    }
    
    ContentViewController * vc = [ContentViewController new];
    vc.number = [[self.pageContentArray objectAtIndex:index] intValue];
    if (index == self.pageContentArray.count - 1) {
        UIView * view = [[UIView alloc]initWithFrame:self.view.bounds];
        vc.view = view;
        view.backgroundColor = [UIColor clearColor];
    }
    return vc;
}
-(NSUInteger)indexOfViewController:(ContentViewController *)viewController
{
    return viewController.number;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray*)pageContentArray
{
    if (_pageContentArray == nil) {
        _pageContentArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            NSString * string = [NSString stringWithFormat:@"%d",i];
            [_pageContentArray addObject:string];
        }
    }
    return _pageContentArray;
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
