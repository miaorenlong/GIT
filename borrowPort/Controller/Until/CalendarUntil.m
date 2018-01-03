//
//  calendarUntil.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/20.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "CalendarUntil.h"
#import "NSString+Category.h"
@implementation CalendarUntil
//    @"yyyy-MM-dd a HH:mm:ss EEEE"
//    2015-10-09 下午 20:34:05 星期五
static CalendarUntil * calendarUntil = nil;

+(instancetype)defaultCalendarUntil{
    return [[self alloc]init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendarUntil = [super allocWithZone:zone];
    });
    return calendarUntil;
}

-(int)getWeekFrom:(NSString *)year with:(NSString *)mouth
{
    NSArray * mouthDayList = [NSArray array];
    int yearInt = [year intValue];
    if ((yearInt % 4 == 0 && yearInt % 100 != 0) || yearInt % 400 ==0  ) {
        mouthDayList = @[@"0",@"31",@"29",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    }else{
        mouthDayList = @[@"0",@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    }
    return [mouthDayList[[mouth intValue]] intValue];
}

-(int)getFirstWeek:(NSString * )year with:(NSString *)mouth
{
    NSString * string = [NSString stringWithFormat:@"%@-%@-%@",year,mouth,@"1"];
    NSDateFormatter * input = [[NSDateFormatter alloc]init];
    [input setDateFormat:@"yyyy-MM-dd"];
    NSDate * forData = [input dateFromString:string];
    
    NSDateFormatter * output = [[NSDateFormatter alloc]init];
    [output setDateFormat:@"EEEE"];
    NSString * outString = [output stringFromDate:forData];
    int numebr = (int)[self.array indexOfObject:outString];
    return numebr;
}
-(NSArray *)getArrayYearAndMouth
{
    NSDate * date = [NSDate date];
    NSDateFormatter * dataFormat = [[NSDateFormatter alloc]init];
    [dataFormat setDateFormat:@"yyyy-MM"];
    NSString * string = [dataFormat stringFromDate:date];
    NSArray * array = [string componentsSeparatedByString:@"-"];
    return array;
}

-(NSArray *)array
{
    if (_array == nil) {
        _array = @[@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday"];
    }
    return _array;
}
/*
    dictStatus {
        时间字符串(2017-8):{
        所有的字 allDayNumber:数组
        被标记的字 allFlagNumber:数组
        被标记的颜色 allFlagColor:UIColor
        当月的天数 mouthDay :NSString
        从第几开始 numberFirst : NSString
        前面的那几天数字  lastMouthNumber: NSArray
    }
 }
 */
-(NSMutableDictionary *)dictStatus{
    if (_dictStatus == nil) {
//        _dictStatus = [NSMutableDictionary dictionaryWithObjectsAndKeys:@{@"allDayNumber":[NSMutableArray array],@"allFlagNumber":[NSMutableArray array],@"allFlagColor":[UIColor new],@"mouthDay":[NSString string],@"numberFirst":[NSString string]},[NSString new], nil];
        _dictStatus = [NSMutableDictionary dictionary];
    }
    return _dictStatus;
}
-(void)setObjectStatusYear:(NSString *)year withmouth:(NSString *)mouth
{
    NSString * lastMouth = mouth.subtractOne;
    NSString  * lastYear = year;
    NSMutableDictionary * subStatus = [NSMutableDictionary new];
    
    int mouthDay = [self getWeekFrom:year with:mouth];
    NSMutableArray * mutableArray = [NSMutableArray array];
    for (int i = 1 ; i < mouthDay + 1 ; i ++) {
        [mutableArray addObject:[NSNumber numberWithInt:i]];
    }
    if (lastMouth.intValue == 0) {
        lastMouth = @"12";
        lastYear = [lastYear subtractOne];
    }
    
    NSMutableArray * mutableArrayLast = [NSMutableArray array];
    for (int i = 1 ; i < [self getWeekFrom:lastYear with:lastMouth] + 1; i ++) {
        [mutableArrayLast addObject:[NSNumber numberWithInt:i]];
    }
    NSRange range = {mutableArrayLast.count - [self getFirstWeek:year with:mouth],[self getFirstWeek:year with:mouth]};
    
    NSArray * arrayLast = [mutableArrayLast subarrayWithRange:range];
    [subStatus setObject:arrayLast forKey:@"lastMouthNumber"];
    [subStatus setObject:mutableArray forKey:@"allDayNumber"];
    [subStatus setObject:[NSString stringWithFormat:@"%d",[self getFirstWeek:year with:mouth]] forKey:@"numberFirst"];
    [subStatus setObject:[NSString stringWithFormat:@"%d",[self getWeekFrom:year with:mouth]] forKey:@"mouthDay"];
    
    [self.dictStatus setObject:subStatus forKey:[NSString stringWithFormat:@"%@-%@",year,mouth]];
}

-(void)setObjectStatusWithKey:(NSString *)key
{
    NSArray * array = [key componentsSeparatedByString:@"-"];
    [self setObjectStatusYear:array[0] withmouth:array[1]];
}

/*
     Static
 以static声明的局部变量:1.这个局部变量只是初始化一次
                     2.该局部变量在程序中只有一个份内存
                     3.对局部变量用static声明，把它分配在静态存储区，该变量在整个程序执行期间不释放，其所分配的空间始终存在
                     4.并不会改变局部变量的作用域，仅仅是改变了局部变量的生命周期（只到程序结束，这个局部变量才会销毁）
 
 */

/*
 变量的类型有:静态变量
 
 以作用域来分有:全局 局部
 
 */
/*
 
 */
/*
 
 */
/*
 
 */
/*
 
 */
@end
