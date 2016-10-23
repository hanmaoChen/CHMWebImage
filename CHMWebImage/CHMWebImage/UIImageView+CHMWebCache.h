//
//  UIImageView+CHMWebCache.h
//  CHMWebImage
//
//  Created by  chenhanmao on 2016/10/23.
//  Copyright © 2016年  chenhanmao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CHMWebCache)

/**  上一个图片地址字符串   */
@property(nonatomic,copy) NSString *lastURLString;

- (void)CHM_setImageWithURLString:(NSString *)URLString;
@end
