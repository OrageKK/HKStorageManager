//
//  HKViewController.m
//  YYCacheManager
//
//  Created by oragekk on 10/15/2019.
//  Copyright (c) 2019 oragekk. All rights reserved.
//

#import "HKViewController.h"
#import <HKCacheManager.h>

@interface HKViewController ()

@end

static NSString *const key = @"pwd";

@implementation HKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *value = @"It's Password";
    
    HKCacheManager *manager = [HKCacheManager manager];
    // 存数据
    [manager setShareData:ShareDataMemoryCache value:value forKey:key];
    // 取数据
    NSString *getValue = [manager getShareData:ShareDataMemoryCache key:key];
    NSLog(@"%@", getValue);
    // 获取并删除
    NSString *getValue2 = [manager getAndRemoveData:ShareDataMemoryCache key:key];
    NSLog(@"%@", getValue2);
    // 删除
    [manager removeShareData:ShareDataMemoryCache key:key];
    // 删除全部
    [manager clearAll];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
