//
//  HKViewController.m
//  HKStorageManager
//
//  Created by oragekk on 12/11/2019.
//  Copyright (c) 2019 oragekk. All rights reserved.
//

#import "HKViewController.h"
#import <HKStorageManager/HKStorageManager.h>
@interface HKViewController ()

@end

@implementation HKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [HKStorageManager setObjectWithType:iComeStorage_DiskCache value:@"你好" forKey:@"123"];
    NSLog(@"已经存储了");
    
    NSString *temp = (NSString *)[HKStorageManager objectWithType:HKStorage_DiskCache key:@"123"];
    NSLog(@"查询存储的值:%@", temp);
    
    NSString *temp2 = (NSString *)[HKStorageManager getAndRemoveObjec:HKStorage_DiskCache key:@"123"];
    NSLog(@"查询存储的值并删除:%@", temp2);
    
    BOOL isExist = [HKStorageManager containsObjectForKey:@"123"];
    NSLog(@"查询删除的值:%d", isExist);
    
    NSLog(@"使用被删除的值:%@", temp2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
