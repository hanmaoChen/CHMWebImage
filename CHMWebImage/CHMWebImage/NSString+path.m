//
//  NSString+path.m
//  CHMWebImage
//
//  Created by  chenhanmao on 2016/10/23.
//  Copyright © 2016年  chenhanmao. All rights reserved.
//  

#import "NSString+path.h"

@implementation NSString (path)


- (NSString *)appendCachePath {
    
    //获取沙盒目录
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    //获得文件名字
    NSString *name = [self lastPathComponent];
    
    //拼接成全路径
    NSString *filePath = [path stringByAppendingPathComponent:name];
    
    return filePath;
}
@end
