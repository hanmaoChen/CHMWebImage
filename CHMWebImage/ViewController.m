//
//  ViewController.m
//  CHMWebImage
//
//  Created by  chenhanmao on 2016/10/22.
//  Copyright © 2016年  chenhanmao. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "AppModel.h"
#import "UIImageView+CHMWebCache.h"

@interface ViewController ()

/**  相框  */
@property(nonatomic,weak) IBOutlet UIImageView *imageView;

/**  数据源数组  */
@property(nonatomic,strong) NSArray <AppModel *>*appList;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadJsonData];

}

//随机下载图片
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //获取随机数
    int random = arc4random_uniform((uint32_t)(self.appList.count));
    
    //获得随机模型
    AppModel *app = self.appList[random];
    
    if (app.icon) {
        
        //利用CHMWebImage加载代码
        [self.imageView CHM_setImageWithURLString:app.icon];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 搭建界面
//- (void)setupUI{
//    
//    UIImageView *iv = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    iv.backgroundColor = [UIColor yellowColor];
//    self.imageView = iv;
//    [self.view addSubview:iv];
//}

#pragma mark - 加载json数据

- (void)loadJsonData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //从网络加载JSON数据，并且反序列化
    [manager GET:@"https://raw.githubusercontent.com/hanmaoChen/ServerFile/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //数据转模型
        self.appList = [NSArray yy_modelArrayWithClass:[AppModel class] json:responseObject];
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
       NSLog(@"%@",error);
    }];
}

@end
