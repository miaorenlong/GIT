//
//  CalendarViewController.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/20.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "CalendarViewController.h"
#import "calendarView.h"
#import "UIView+Category.h"
#import "CalendarUntil.h"
#import "NSString+Category.h"

@interface CalendarViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)CalendarUntil * until;
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserver:self forKeyPath:@"mouth" options:NSKeyValueObservingOptionNew context:nil];
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, self.view.frame.size.height - 100)];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, 0);
    [self.view addSubview:scrollView];
    
    CalendarUntil * until = [CalendarUntil defaultCalendarUntil];
    self.until = until;
    self.year = [until getArrayYearAndMouth][0];
    self.mouth= [until getArrayYearAndMouth][1];
    
   self.mouth = [self.mouth subtractOne];
    
    for (int i = 0 ;i < 3 ; i ++) {
        NSString * strKey = [NSString stringWithFormat:@"%@-%@",self.year,self.mouth];
        [until setObjectStatusWithKey:strKey];
        calendarView * view = [[calendarView alloc]initWithFrame:CGRectMake(scrollView.width * i, 0, scrollView.width, scrollView.height) with:until.dictStatus with:strKey];
        
        self.mouth = [self.mouth addOne];
        [scrollView addSubview:view];
        scrollView.pagingEnabled = YES;
        view.tag = 100 + i;
    }
    scrollView.contentOffset = CGPointMake(scrollView.width, 0);
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.delegate  = self;
 
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([self.mouth intValue] > 12) {
        self.mouth = @"1";
        self.year = [self.year addOne];
    }
    if (self.mouth.intValue == 0) {
        self.mouth = @"12";
        self.year = [self.year subtractOne];
    }
}
#pragma mark -- scrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CalendarUntil * until = [CalendarUntil defaultCalendarUntil];
    calendarView * calend = [self.view viewWithTag:100];
    NSString * mouthmid = calend.mouth;
    self.mouth = mouthmid.subtractOne;
    if (scrollView.contentOffset.x > scrollView.width) {
        calendarView * view1 =(calendarView *)[self.view viewWithTag:100];
        self.year = view1.keyArrayFirst;
        self.mouth = [view1.keyArraySecond addOne];
        [view1 updataLabelView:[NSString stringWithFormat:@"%@-%@",self.year,self.mouth] with:until.dictStatus];
        
        calendarView * view2 = (calendarView *)[self.view viewWithTag:101];
        self.year = view2.keyArrayFirst;
        self.mouth = [view2.keyArraySecond addOne];
        [view2 updataLabelView:[NSString stringWithFormat:@"%@-%@",self.year,self.mouth] with:until.dictStatus];
        
        calendarView * view3 = (calendarView *)[self.view viewWithTag:102];
        self.year = view3.keyArrayFirst;
        self.mouth = [view3.keyArraySecond addOne];
        [until setObjectStatusWithKey:[NSString stringWithFormat:@"%@-%@",self.year,self.mouth]];
        [view3 updataLabelView:[NSString stringWithFormat:@"%@-%@",self.year,self.mouth] with:until.dictStatus];
    }if (scrollView.contentOffset.x == scrollView.width) {
        NSLog(@"没动");
    }if (scrollView.contentOffset.x < scrollView.width) {
        //向左移动意味着再添加一个key-value 创建一个新的月的信息
        calendarView * view1 =(calendarView *)[self.view viewWithTag:100];
        self.year = view1.keyArrayFirst;
        self.mouth = [view1.keyArraySecond subtractOne];
        [until setObjectStatusWithKey:[NSString stringWithFormat:@"%@-%@",self.year,self.mouth]];
        [view1 updataLabelView:[NSString stringWithFormat:@"%@-%@",self.year,self.mouth] with:until.dictStatus];
        
        calendarView * view2 = (calendarView *)[self.view viewWithTag:101];
        self.year = view2.keyArrayFirst;
        self.mouth = [view2.keyArraySecond subtractOne];
        [view2 updataLabelView:[NSString stringWithFormat:@"%@-%@",self.year,self.mouth] with:until.dictStatus];
        
        calendarView * view3 = (calendarView *)[self.view viewWithTag:102];
        self.year = view3.keyArrayFirst;
        self.mouth = [view3.keyArraySecond subtractOne];
        [view3 updataLabelView:[NSString stringWithFormat:@"%@-%@",self.year,self.mouth] with:until.dictStatus];
        
    }
    
    scrollView.contentOffset = CGPointMake(scrollView.width, 0);
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
