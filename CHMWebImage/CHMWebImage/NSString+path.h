//
//  NSString+path.h
//  CHMWebImage
//
//  Created by  chenhanmao on 2016/10/23.
//  Copyright © 2016年  chenhanmao. All rights reserved.

//  返回沙盒缓存目录

#import <Foundation/Foundation.h>

@interface NSString (path)

- (NSString *)appendCachePath;
@end
