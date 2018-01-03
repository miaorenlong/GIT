//
//  Tool.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/8.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <Foundation/Foundation.h>
/** iphone屏幕*/
typedef NS_ENUM(NSInteger, IPhoneScreenSize) {
    IPhoneScreenSize3_5,  ///< 3.5英寸屏幕
    IPhoneScreenSize4,    ///< 4英寸屏幕
    IPhoneScreenSize4_7,  ///< 4.7英寸屏幕
    IPhoneScreenSize5_5,  ///< 5.5英寸屏幕
    IPhoneScreenSizeX,    ///< IphoneX屏幕
    IPhoneScreenSizeOther ///< 其他屏幕
};
@interface Tool : NSObject

@property(nonatomic)IPhoneScreenSize iPhoneScreenSize;
+(Tool *)tool;

-(float)obtainVersion;

@end
