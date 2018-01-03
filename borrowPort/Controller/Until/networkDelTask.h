//
//  networkDelTask.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/18.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,CustomSessionHeader){
    CustomSessionHeaderTxtXml,
    CustomSessionHeaderAppliJson,
};

@interface networkDelTask : NSObject<NSURLSessionDataDelegate>

@property(nonatomic)CustomSessionHeader customSeesionHeader;


@end
