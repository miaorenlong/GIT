//
//  PageViewController.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/15.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef NS_ENUM(NSInteger, NSTextAlignment
typedef NS_ENUM(NSInteger ,Direction) {
    RightDirection,
    LeftDirection,
};

@interface PageViewController : UIViewController

@property(nonatomic,assign)int currentIndex;
@property(nonatomic)Direction direction;
@end
