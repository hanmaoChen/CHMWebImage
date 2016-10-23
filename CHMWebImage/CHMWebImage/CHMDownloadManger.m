//
//  CHMDownloadManger.m
//  CHMWebImage
//
//  Created by  chenhanmao on 2016/10/22.
//  Copyright © 2016年  chenhanmao. All rights reserved.
//

#import "CHMDownloadManger.h"
#import "NSString+path.h"

@interface CHMDownloadManger ()

/**  全局队列  */
@property(nonatomic,strong) NSOperationQueue *queue;

/**  操作缓存池  */
@property(nonatomic,strong) NSMutableDictionary *OPCache;

/**  图片缓存  */
@property(nonatomic,strong) NSMutableDictionary *imageCache;

@end

@implementation CHMDownloadManger

//实例化全局队列和操作缓存池
- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.queue = [[NSOperationQueue alloc] init];
        self.OPCache = [NSMutableDictionary dictionary];
        self.imageCache = [NSMutableDictionary dictionary];
        
        //注册接受内存警告通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearMemery) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    
    return self;
}

//内存警告处理方法
- (void)clearMemery {
    
    [self.imageCache removeAllObjects];
    [self.OPCache removeAllObjects];
    [self.queue cancelAllOperations];
    
}




#pragma mark - 单例
+ (instancetype)sharedDownloadManger {
    
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
    });
    return instance;
}


#pragma mark - 检查缓存和沙盒中是否已经存在该照片
- (BOOL)checkCacheWithURLString:(NSString *)URLString {
    
    //判断内存中的
    if ([self.imageCache objectForKey:URLString]) {
        NSLog(@"从内存中加载。。。");
        
        return YES;
    }
    
    //判断沙盒中的
    UIImage *cacheImage = [UIImage imageWithContentsOfFile:[URLString appendCachePath]];
    if (cacheImage != nil) {
        
        //从沙盒加载到缓存
        [self.imageCache setObject:cacheImage forKey:URLString];
        NSLog(@"从沙盒中加载。。。");
        return YES;
    }
    return NO;
}

#pragma mark - 取消操作的方法实现
- (void)cancelOperationWithLastURLString:(NSString *)lastURLString {
    
    CHMDownLoadOperation *lastOP = [_OPCache objectForKey:lastURLString];
    if (lastOP) {
        
        [lastOP cancel];
        [_OPCache removeObjectForKey:lastURLString];
    }
}

#pragma mark - 下载图片主方法
- (void)downloadImageWithURLString:(NSString *)URLString finishBlock:(void(^)(UIImage *image))finishedBlock {
    
    //判断图片是否在缓存中存在了
    if ([self checkCacheWithURLString:URLString]) {
        
        if (finishedBlock) {
            finishedBlock([_imageCache objectForKey:URLString]);
        }
        return;
    }
    
     // 避免重复建立下载操作
    if ([self.OPCache objectForKey:URLString]) {
        return;
    }
    
    //创建下载操作
    CHMDownLoadOperation *op = [CHMDownLoadOperation downloadImageWithURLString:URLString finishBlock:^(UIImage *image) {

        //定义block将传入的block回调
        if (finishedBlock) {

            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
         //回调传入的代码块，传递image到UIImageView
                finishedBlock(image);
            }];
        }
        
        //下载完成实现图片缓存
        [_imageCache setObject:image forKey:URLString];
        
        //下载完成从操作缓存池移除操作
        [self.OPCache removeObjectForKey:URLString];
    }];
    //添加操作到缓存池
    
    [self.OPCache setObject:op forKey:URLString];
    
    //将操作添加到队列
    [self.queue addOperation:op];
}

//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
