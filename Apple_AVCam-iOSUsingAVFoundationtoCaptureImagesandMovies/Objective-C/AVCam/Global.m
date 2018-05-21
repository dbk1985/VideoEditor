//
//  Global.m
//  AVCam
//
//  Created by wzkj on 2018/5/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "Global.h"

@implementation Global
+(instancetype)share
{
    static Global *global = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        global = [[Global alloc] init];
    });
    return global;
}
@end
