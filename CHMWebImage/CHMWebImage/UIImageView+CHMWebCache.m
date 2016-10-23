//
//  UIImageView+CHMWebCache.m
//  CHMWebImage
//
//  Created by  chenhanmao on 2016/10/23.
//  Copyright © 2016年  chenhanmao. All rights reserved.
//

#import "UIImageView+CHMWebCache.h"
#import "CHMDownloadManger.h"
#import <objc/runtime.h>

@implementation UIImageView (CHMWebCache)

/*
 参数1 : 要关联的对象
 参数2 : 关联的key
 参数3 : 关联的值
 参数4 : 关联的值的存储策略
 */
- (void)setLastURLString:(NSString *)lastURLString {
    
    objc_setAssociatedObject(self, "key", lastURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/*
 参数1 : 要关联的对象
 参数2 : 关联的key
 */
- (NSString *)lastURLString {
    
    return objc_getAssociatedObject(self, "key");
}


//加载图片主方法
- (void)CHM_setImageWithURLString:(NSString *)URLString {
    
    if (![URLString isEqualToString:self.lastURLString] && (self.lastURLString != nil)) {
        [[CHMDownloadManger sharedDownloadManger] cancelOperationWithLastURLString: self.lastURLString];
    }
    
    self.lastURLString = URLString;
    
    [[CHMDownloadManger sharedDownloadManger] downloadImageWithURLString:URLString finishBlock:^(UIImage *image) {
        
        self.image = image;
    }];
}

@end
