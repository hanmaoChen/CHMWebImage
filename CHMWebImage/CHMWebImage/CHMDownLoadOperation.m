//
//  CHMDownLoadOperation.m
//  CHMWebImage
//
//  Created by  chenhanmao on 2016/10/22.
//  Copyright © 2016年  chenhanmao. All rights reserved.
//

#import "CHMDownLoadOperation.h"
#import "NSString+path.h"

@implementation CHMDownLoadOperation



//实例化下载图片主方法
+ (instancetype)downloadImageWithURLString:(NSString *)URLString finishBlock:(void(^)(UIImage *image))finishedBlock {
    
    CHMDownLoadOperation *op = [[CHMDownLoadOperation alloc] init];
    
    op.URLString = URLString;
    
    op.finishBlock = finishedBlock;
    
    return op;
    
}
/*
 任何操作在执行时,首先会调用start方法,start方法会更新操作的状态(过滤操作);
 经start方法过滤止呕,只有正常可执行的操作,就会调用这个main方法
 重写操作的入口方法(main方法),就可以在这个方法里面指定操作执行的任务
 */
- (void)main {
    
    //模拟网络延迟
//    [NSThread sleepForTimeInterval:1];
    
    NSURL *url = [NSURL URLWithString:self.URLString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];
    
    //拦截回调
    if (self.isCancelled == YES) {
        
        NSLog(@"取消下载%@",url);
        return;
    }
    
    NSAssert(self.finishBlock != nil, @"图片回调函数不能为空");
    
    //如果图片非空，返回主线程刷新界面
    if (image) {
        
        //实现沙盒缓存
        [data writeToFile:[_URLString appendCachePath] atomically:YES];
        
        //回调单例管理的block，传递image
        self.finishBlock(image);
    }
}
@end
