//
//  calendarView.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/20.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "calendarView.h"
#import "CalendarUntil.h"
#import "UILabel+Category.h"
#import "NSString+Category.h"
#define Height self.calendarTure.frame.size.height/8
#define Width self.calendarTure.frame.size.width/7

#define YearViewHeight Height
#define YearViewWidth Width *7

#define WeekViewHeight Height
#define WeekViewWidth Width * 7

#define DayLabelViewHeight Height * 6
#define DayLabelViewWidth Width * 7

#define LabelHeight Height * 2/3
#define LabelWidth Width * 2/3

#define Top Height/6
#define Leading Width/6

@interface calendarView()
@property(nonatomic,strong)NSArray * weekArray;
@end


@implementation calendarView
//如果传入的frame不是正方形 应该截取view
//每次都创建不合适  每次都复制会好点
//创建视图框   再赋值

-(instancetype)initWithFrame:(CGRect)frame with:(NSMutableDictionary *)dict with:(NSString *)key
{
    
    self.key = key;
    if (self = [super initWithFrame:frame]) {
        if (frame.size.width > frame.size.height)
        {
            self.calendarTure = [[UIView alloc]initWithFrame:CGRectMake((frame.size.width - frame.size.height)/2, 0, frame.size.height, frame.size.height)];
            [self addSubview:self.calendarTure];
            [self loadWeekAndLableView];
            
        }else
        {
            self.calendarTure = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
            [self addSubview:self.calendarTure];
            [self loadWeekAndLableView];
        }
    }
    [self updataLabelView:key with:dict];
    return self;
}


/**
 加载视图
 */
-(void)loadWeekAndLableView
{
    self.yearView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YearViewWidth, YearViewHeight)];
    [self.calendarTure addSubview:self.yearView];
    
    self.weekView = [[UIView alloc]initWithFrame:CGRectMake(0, YearViewHeight, WeekViewWidth, WeekViewHeight)];
    [self.calendarTure addSubview:self.weekView];
    
    self.dayLabelView = [[UIView alloc]initWithFrame:CGRectMake(0, YearViewHeight + WeekViewHeight, DayLabelViewWidth, DayLabelViewHeight)];
    [self.calendarTure addSubview:self.dayLabelView];
    
    [self CustomInitYearLabel];
    [self CustomInitWeekLabel];
    [self CustomInitDayLabel];
}

/**
 最上面的那个年月视图
 */
-(void)CustomInitYearLabel
{
    //获取时间
//    if (self.year == nil) {
//        NSDate * date = [NSDate date];
//        NSDateFormatter * dataFormat = [[NSDateFormatter alloc]init];
//        [dataFormat setDateFormat:@"yyyy-MM"];
//        NSString * string = [dataFormat stringFromDate:date];
//        NSArray * array = [string componentsSeparatedByString:@"-"];
//        self.year = array[0];
//        self.mouth = array[1];
//    }
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, YearViewWidth, YearViewHeight)];
    [self.yearView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = 500;
    NSArray * array = [self.key componentsSeparatedByString:@"-"];
    label.text = [NSString stringWithFormat:@"%@年%@月",array[0],array[1]];
}

/**
 周的view 添加label
 */
-(void)CustomInitWeekLabel
{
    for (int i = 0 ; i < 7; i ++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(Leading + Width * i, Top, Width, Height)];
        [self.weekView addSubview:label];
        label.text = self.weekArray[i];
    }
}
-(void)CustomInitDayLabel
{
//    //当月多少天
//    int mouthDay = [self.dictData[self.key][@"mouthDay"] intValue];
//    NSMutableArray * mutableArray = self.dictData[self.key][@"allDayNumber"];
//    //从第几个开始
//    int numberFirst = [self.dictData[self.key][@"numberFirst"] intValue];
//    int numberLabel = 0;
//    int m = 0;
//    int k = 0;
//    for (int i = 0 ; i < 6; i ++) {
//        for (int j = 0; j < 7; j ++) {
//            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(Leading + Width * j, Top + Height * i, LabelWidth, LabelHeight)];
//            label.textAlignment = NSTextAlignmentCenter;
//            [self.dayLabelView addSubview:label];
//            if (numberLabel < numberFirst) {
//                label.text = [NSString stringWithFormat:@"%@",self.dictData[self.key][@"lastMouthNumber"][numberLabel]];
//                label.textColor = [UIColor grayColor];
//            }
//            if (numberLabel >= numberFirst && numberLabel < (mouthDay + numberFirst)) {
//                label.text = [NSString stringWithFormat:@"%@",mutableArray[numberLabel - numberFirst]];
//                label.textColor = [UIColor blackColor];
//            }
//            numberLabel ++;
//            if (numberLabel > (mouthDay + numberFirst)) {
//                label.text = [NSString stringWithFormat:@"%@",mutableArray[k]];
//                label.textColor = [UIColor grayColor];
//                k ++;
//            }
//            label.tag = 200 + m;
//            [self.dayArray addObject:[NSString stringWithFormat:@"%ld",(long)label.tag]];
//            m++;
//        }
//    }
    
    int m = 0;
    for (int i = 0 ; i < 6; i ++) {
        for (int j = 0; j < 7; j ++) {
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(Leading + Width * j, Top + Height * i, LabelWidth, LabelHeight)];
            label.textAlignment = NSTextAlignmentCenter;
            [self.dayLabelView addSubview:label];
            label.tag = 200 + m;
            [self.dayArray addObject:[NSString stringWithFormat:@"%ld",(long)label.tag]];
            m++;
        }
    }
    
    
}

/**
 根据数据更新视图

 @param key 年-月
 @param dict 总字典
 */
-(void)updataLabelView:(NSString * )key with:(NSMutableDictionary *)dict
{
    self.key =  key;
    int numberFirst = [dict[key][@"numberFirst"] intValue];
    int mouthDay = [dict[key][@"mouthDay"] intValue];
    NSMutableArray * mutableArray = dict[key][@"allDayNumber"];
    int numberLabel = 0;
    int k = 0;
    for (int i = 0; i < self.dayArray.count; i ++) {
        UILabel * label = (UILabel *)[self viewWithTag: (i + 200)];
        label.text = nil;
        if (numberLabel < numberFirst) {
            label.text = [NSString stringWithFormat:@"%@",dict[key][@"lastMouthNumber"][numberLabel]];
            label.textColor = [UIColor grayColor];
        }
        if ( i >= numberFirst && i < (mouthDay + numberFirst)) {
            label.text = [NSString stringWithFormat:@"%@",mutableArray[numberLabel - numberFirst]];
            label.textColor = [UIColor blackColor];
        }
        numberLabel ++;
        if (numberLabel > (mouthDay + numberFirst)) {
            label.text = [NSString stringWithFormat:@"%@",mutableArray[k]];
            k ++;
            label.textColor = [UIColor grayColor];
        }
    }
    UILabel * label = (UILabel *)[self viewWithTag:500];
    NSArray * array = [key componentsSeparatedByString:@"-"];
    label.text = [NSString stringWithFormat:@"%@年%@月",array[0],array[1]];

}
-(NSString *)keyArrayFirst
{
    return [self.key componentsSeparatedByString:@"-"][0];
}
-(NSString *)keyArraySecond
{
    return [self.key componentsSeparatedByString:@"-"][1];
}
/**
 懒加载

 @return array
 */
-(NSArray *)weekArray
{
    if (_weekArray == nil) {
        _weekArray =@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    }
    return _weekArray;
}
-(NSMutableArray *)dayArray{
    if (_dayArray == nil) {
        _dayArray = [NSMutableArray array];
    }
    return _dayArray;
}
-(NSMutableDictionary *)dictData
{
    if (_dictData == nil) {
        _dictData = [NSMutableDictionary dictionary];
    }
    return _dictData;
}
/*
 dictStatus {
 时间字符串(2017-8):{
 所有的字:数组
 被标记的字:数组
 被标记的颜色:UIColor
 }
 }
 */
//-(NSMutableDictionary *)dictStatus{
//    if (_dictStatus == nil) {
//        _dictStatus = [NSMutableDictionary dictionaryWithObjectsAndKeys:@{@"allDayNumber":[NSMutableArray array],@"allFlagNumber":[NSMutableArray array],@"allFlagColor":[UIColor new]},@"time", nil];
//    }
//    return _dictStatus;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
