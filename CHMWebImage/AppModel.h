//
//  AppModel.h
//  CHMWebImage
//
//  Created by  chenhanmao on 2016/10/22.
//  Copyright © 2016年  chenhanmao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject


/**  name  */
@property(nonatomic,copy) NSString *name;
/**  dowload   */
@property(nonatomic,copy) NSString *download;
/**  icon   */
@property(nonatomic,copy) NSString *icon;

@end

/*
 {
 "name" : "植物大战僵尸",
 "download" : "10311万",
 "icon" : "http:\/\/p16.qhimg.com\/dr\/48_48_\/t0125e8d438ae9d2fbb.png"
 },
 */
