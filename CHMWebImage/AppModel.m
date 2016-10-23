//
//  AppModel.m
//  CHMWebImage
//
//  Created by  chenhanmao on 2016/10/22.
//  Copyright © 2016年  chenhanmao. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@-%@-%@",self.name,self.download,self.icon];
}
@end
