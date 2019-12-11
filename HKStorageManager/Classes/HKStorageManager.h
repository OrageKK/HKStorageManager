//
//  HKStorageManager.h
//  HKStorageManager
//
//  Created by 黄坤 on 2019/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HKStorageType) {
    HKStorage_MemoryCache,
    HKStorage_DiskCache
};
@interface HKStorageManager : NSObject

#pragma mark - Initializer
/**
 单例对象
 @return instancetype
 */
+ (nullable instancetype)sharedManager;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

#pragma mark - Access Methods
/**
 存入数据
 @param type 存储类型
 @param key key
 @param value value
 */
+ (void)setObjectWithType:(HKStorageType)type value:(nullable id<NSCoding>)value forKey:(NSString *)key ;

/**
 获取数据
 @param type 存储类型
 @param key key
 @return value
 */
+ (nullable id<NSCoding>)objectWithType:(HKStorageType)type key:(NSString *)key;


/// 查询key值
/// @param key key
+ (BOOL)containsObjectForKey:(NSString *)key;

/**
 获取并删除数据
 @param type 存储类型
 @param key key
 @return value
 */
+ (nullable id<NSCoding>)getAndRemoveObjec:(HKStorageType)type key:(NSString *)key;

/**
 删除数据
 @param type 存储类型
 @param key key
 */
+ (void)removeObjectWithType:(HKStorageType)type key:(NSString *)key;

/**
 清空本地存储
 */
+ (void)removeAll;

#pragma mark - Public Method

/**
 返回磁盘缓存中对象的数量.
 在文件读取完成之前，此方法是阻塞线程的
 
 @return 缓存数量.
 */
- (NSInteger)totalCount;
/**
 返回磁盘缓存中对象的数量.
 此方法立即返回并通过后台队列在block中返回结果.
 
 @param block  A block which will be invoked in background queue when finished.
 */
- (void)totalCountWithBlock:(void(^)(NSInteger totalCount))block;

/**
 返回磁盘缓存中对象的总开销.(in bytes)
 在文件读取完成之前，此方法是阻塞线程的
 
 @return 缓存对象开销 in bytes.
 */
- (NSInteger)totalCost;

/**
 返回磁盘缓存中对象的总开销.(in bytes)
 此方法立即返回并通过后台队列在block中返回结果.
 
 @param block  A block which will be invoked in background queue when finished.
 */
- (void)totalCostWithBlock:(void(^)(NSInteger totalCost))block;

#pragma mark - Trim
///=============================================================================
/// @name Trim
///=============================================================================

/**
 使用LRU从缓存中删除对象，直到“totalCount”低于指定的值。
 在文件读取完成之前，此方法是阻塞线程的
 
 @param count 缓存被删除后允许保留的总数
 */
- (void)trimToCount:(NSUInteger)count;

/**
 使用LRU从缓存中删除对象，直到“totalCount”低于指定的值。
 此方法立即返回并通过后台队列在block中返回结果.
 
 @param count  缓存被删除后允许保留的总数
 @param block  A block which will be invoked in background queue when finished.
 */
- (void)trimToCount:(NSUInteger)count withBlock:(void(^)(void))block;

/**
 使用LRU从缓存中删除对象，直到“totalCost”低于指定的值。
 在文件读取完成之前，此方法是阻塞线程的
 
 @param cost 缓存被删除后允许保留的总开销
 */
- (void)trimToCost:(NSUInteger)cost;

/**
 使用LRU从缓存中删除对象，直到“totalCost”低于指定的值。
 此方法立即返回并通过后台队列在block中返回结果.
 
 @param cost 缓存被删除后允许保留的总开销
 @param block  A block which will be invoked in background queue when finished.
 */
- (void)trimToCost:(NSUInteger)cost withBlock:(void(^)(void))block;

/**
 使用LRU从缓存中删除对象，直到根据指定的值删除所有过期对象。
 在文件读取完成之前，此方法是阻塞线程的
 
 @param age  允许的最大保留时间
 */
- (void)trimToAge:(NSTimeInterval)age;

/**
 使用LRU从缓存中删除对象，直到根据指定的值删除所有过期对象。
 此方法立即返回并通过后台队列在block中返回结果.
 
 @param age  允许的最大保留时间
 @param block  A block which will be invoked in background queue when finished.
 */
- (void)trimToAge:(NSTimeInterval)age withBlock:(void(^)(void))block;
@end

NS_ASSUME_NONNULL_END
