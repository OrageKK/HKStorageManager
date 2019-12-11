//
//  HKStorageManager.m
//  HKStorageManager
//
//  Created by 黄坤 on 2019/12/10.
//

#import "HKStorageManager.h"
#import "YYCache.h"

@interface HKStorageManager ()
@property (nonatomic,strong) YYCache *HKStorageCache;
@end

@implementation HKStorageManager

#pragma mark - Initializer
+ (nullable instancetype)sharedManager {
    static HKStorageManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HKStorageManager alloc] init];
    });
    return instance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.HKStorageCache = [[YYCache alloc] initWithName:@"HKStorage"];
        // 开启错误日志调试
        self.HKStorageCache.diskCache.errorLogsEnabled = YES;
        // 最大对象数量
        self.HKStorageCache.diskCache.countLimit = NSUIntegerMax;
        // 最大磁盘开销 in bytes(50MB)
        self.HKStorageCache.diskCache.costLimit = 1024*1024*50;
        // 过期时间-无限制
        self.HKStorageCache.diskCache.ageLimit = DBL_MAX;
        
        
    }
    return self;
}
#pragma mark - Access Methods
//MARK:存储
+ (void)setObjectWithType:(HKStorageType)type value:(id<NSCoding>)value forKey:(NSString *)key {
    HKStorageManager *manager = [self sharedManager];
    if (type == HKStorage_MemoryCache) {
        [manager.HKStorageCache.memoryCache setObject:value forKey:key];
    }else {
        [manager.HKStorageCache.diskCache setObject:value forKey:key];
    }
    
}
//MARK:获取
+ (id<NSCoding>)objectWithType:(HKStorageType)type key:(NSString *)key {
    HKStorageManager *manager = [self sharedManager];
    if ([manager.HKStorageCache containsObjectForKey:key]) {
        if (type == HKStorage_MemoryCache) {
            return [manager.HKStorageCache.memoryCache objectForKey:key];
        }else {
            return [manager.HKStorageCache.diskCache objectForKey:key];
        }
    }
    return nil;
}
//MARK:查key
+ (BOOL)containsObjectForKey:(NSString *)key {
    HKStorageManager *manager = [self sharedManager];
     return [manager.HKStorageCache containsObjectForKey:key];
}
//MARK:获取并删除
+ (id<NSCoding>)getAndRemoveObjec:(HKStorageType)type key:(NSString *)key {
    HKStorageManager *manager = [self sharedManager];
    if ([self containsObjectForKey:key]) {
        if (type == HKStorage_MemoryCache) {
            id temp = [manager.HKStorageCache.memoryCache objectForKey:key];
            [manager.HKStorageCache.memoryCache removeObjectForKey:key];
            return temp;
        }else {
            id temp = [manager.HKStorageCache.diskCache objectForKey:key];
            [manager.HKStorageCache.diskCache removeObjectForKey:key];
            return temp;
        }
    }
    return nil;
}
//MARK:删除
+ (void)removeObjectWithType:(HKStorageType)type key:(NSString *)key {
    HKStorageManager *manager = [self sharedManager];
    if ([manager.HKStorageCache containsObjectForKey:key]) {
        if (type == HKStorage_MemoryCache) {
            [manager.HKStorageCache.memoryCache removeObjectForKey:key];
        }else {
            [manager.HKStorageCache.diskCache removeObjectForKey:key];
        }
    }
}
//MARK:删除全部
+ (void)removeAll {
    
    HKStorageManager *manager = [self sharedManager];
    [manager.HKStorageCache removeAllObjects];
}
#pragma mark - Public Method

/**
 返回磁盘缓存中对象的数量.
 在文件读取完成之前，此方法是阻塞线程的
 
 @return 缓存数量.
 */
- (NSInteger)totalCount {
    
    return [self.HKStorageCache.diskCache totalCount];
}
/**
 返回磁盘缓存中对象的数量.
 此方法立即返回并通过后台队列在block中返回结果.
 
 @param block  A block which will be invoked in background queue when finished.
 */
- (void)totalCountWithBlock:(void(^)(NSInteger totalCount))block {
    
    [self.HKStorageCache.diskCache totalCountWithBlock:block];
}

/**
 返回磁盘缓存中对象的总开销.(in bytes)
 在文件读取完成之前，此方法是阻塞线程的
 
 @return 缓存对象开销 in bytes.
 */
- (NSInteger)totalCost {
    
    return [self.HKStorageCache.diskCache totalCost];
}

/**
 返回磁盘缓存中对象的总开销.(in bytes)
 此方法立即返回并通过后台队列在block中返回结果.
 
 @param block  A block which will be invoked in background queue when finished.
 */
- (void)totalCostWithBlock:(void(^)(NSInteger totalCost))block {
    
    [self.HKStorageCache.diskCache totalCostWithBlock:block];
}

#pragma mark - Trim

- (void)trimToCount:(NSUInteger)count {
    
    [self.HKStorageCache.diskCache trimToCount:count];
}


- (void)trimToCount:(NSUInteger)count withBlock:(void(^)(void))block {
    
    [self.HKStorageCache.diskCache trimToCount:count withBlock:block];
}


- (void)trimToCost:(NSUInteger)cost {
    
    [self.HKStorageCache.diskCache trimToCost:cost];
}


- (void)trimToCost:(NSUInteger)cost withBlock:(void(^)(void))block {
    
    [self.HKStorageCache.diskCache trimToCost:cost withBlock:block];
}


- (void)trimToAge:(NSTimeInterval)age {
    
    [self.HKStorageCache.diskCache trimToAge:age];
}


- (void)trimToAge:(NSTimeInterval)age withBlock:(void(^)(void))block {
    
    [self.HKStorageCache.diskCache trimToAge:age withBlock:block];
}
@end
