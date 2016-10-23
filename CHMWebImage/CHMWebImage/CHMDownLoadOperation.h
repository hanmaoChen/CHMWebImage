//
//  CHMDownLoadOperation.h
//  CHMWebImage
//
//  Created by  chenhanmao on 2016/10/22.
//  Copyright © 2016年  chenhanmao. All rights reserved.


//自定义Operation的目的
//下载网络图片

//需要图片地址
//需要把下载完成的图片传递到展示的地方

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CHMDownLoadOperation : NSOperation

/**  图片地址   */
@property(nonatomic,copy) NSString *URLString;

/**  传递图片到需要展示的地方   */
@property(nonatomic,copy) void(^finishBlock)(UIImage *image);



/**
 下载图片的主方法

 @param URLString     传入图片地址字符串
 @param finishedBlock 图片下载完成的回调

 @return 下载图片的操作
 */
+ (instancetype)downloadImageWithURLString:(NSString *)URLString finishBlock:(void(^)(UIImage *image))finishedBlock;
@end
