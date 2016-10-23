//
//  CHMDownloadManger.h
//  CHMWebImage
//
//  Created by  chenhanmao on 2016/10/22.
//  Copyright © 2016年  chenhanmao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CHMDownLoadOperation.h"

@interface CHMDownloadManger : NSObject

//单例
+ (instancetype)sharedDownloadManger;

//下载图片主方法
- (void)downloadImageWithURLString:(NSString *)URLString finishBlock:(void(^)(UIImage *image))finishedBlock;

//取消上一步操作
- (void)cancelOperationWithLastURLString:(NSString *)URLString;

@end
