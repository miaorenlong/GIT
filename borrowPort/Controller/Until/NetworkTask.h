//
//  NetworkTask.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/11.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetWorkTaskDelegate<NSObject>

@end

typedef NS_ENUM(NSInteger ,CustomSessHeader){
    CustomSessionHeaderXmlJson,
    CustomSessionHeaderApplicationJson,
};

@interface NetworkTask : NSObject

@property(nonatomic,weak)id<NetWorkTaskDelegate> taskDelegate;

-(void)obtainPOSTDataFrom:(NSURL *)url With:(CustomSessHeader)CustomSessionHeader Withparmart:(NSMutableDictionary * )parmart;

@property(nonatomic)CustomSessHeader CustomHeader;



@end


