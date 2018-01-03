//
//  ImageObject.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/14.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "ImageObject.h"

@implementation ImageObject

static ImageObject * imageObject ;
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageObject = [super allocWithZone:zone];
    });
    return imageObject;
}
+(instancetype)defultImageObject
{
    return [[self alloc]init];
}

@end
