//
//  ShareDataManager.m
//  panda.appleHybrid
//
//  Created by 黄坤 on 2018/1/29.
//  Copyright © 2018年 jinchenshenghui. All rights reserved.
//

#import "HKCacheManager.h"
#import "YYCache.h"
@interface SWCacheManager()
@property (nonatomic,strong) YYCache *shareDataCache;
@end

@implementation HKCacheManager
+ (instancetype)manager {
    static SWCacheManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SWCacheManager alloc] init];
    });
    return instance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.shareDataCache = [[YYCache alloc] initWithName:@"shareData"];
    }
    return self;
}
- (void)setShareData:(ShareDataType)type value:(id)value forKey:(NSString *)key {
    if (type == ShareDataMemoryCache) {
        [self.shareDataCache.memoryCache setObject:value forKey:key];
    }else {
        [self.shareDataCache.diskCache setObject:value forKey:key];
    }
}
- (id)getShareData:(ShareDataType)type key:(NSString *)key {
    if ([self.shareDataCache containsObjectForKey:key]) {
        if (type == ShareDataMemoryCache) {
            return [self.shareDataCache.memoryCache objectForKey:key];
        }else {
            return [self.shareDataCache.diskCache objectForKey:key];
        }
    }
    return nil;
}
- (id)getAndRemoveData:(ShareDataType)type key:(NSString *)key {
    if ([self.shareDataCache containsObjectForKey:key]) {
        if (type == ShareDataMemoryCache) {
            id temp = [self.shareDataCache.memoryCache objectForKey:key];
            [self.shareDataCache.memoryCache removeObjectForKey:key];
            return temp;
        }else {
            id temp = [self.shareDataCache.diskCache objectForKey:key];
            [self.shareDataCache.diskCache removeObjectForKey:key];
            return temp;
        }
    }
    return nil;
}
- (void)removeShareData:(ShareDataType)type key:(NSString *)key {
    if ([self.shareDataCache containsObjectForKey:key]) {
        if (type == ShareDataMemoryCache) {
            [self.shareDataCache.memoryCache removeObjectForKey:key];
        }else {
            [self.shareDataCache.diskCache removeObjectForKey:key];
        }
    }
}
- (void)clearAll {
    [self.shareDataCache removeAllObjects];
}
@end
