//
//  ShareDataManager.h
//  panda.appleHybrid
//
//  Created by 黄坤 on 2018/1/29.
//  Copyright © 2018年 jinchenshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ShareDataType) {
    ShareDataMemoryCache,
    ShareDataDiskCache
};
@interface HKCacheManager : NSObject

/**
 单例对象

 @return instancetype
 */
+ (instancetype)manager;

/**
 存入数据

 @param type 存储类型
 @param key key
 @param value value
 */
- (void)setShareData:(ShareDataType)type value:(id)value forKey:(NSString *)key ;

/**
 获取数据

 @param type 存储类型
 @param key key
 @return value
 */
- (id)getShareData:(ShareDataType)type key:(NSString *)key;


/**
 获取并删除数据

 @param type 存储类型
 @param key key
 @return value
 */
- (id)getAndRemoveData:(ShareDataType)type key:(NSString *)key;

/**
 删除数据

 @param type 存储类型
 @param key key
 */
- (void)removeShareData:(ShareDataType)type key:(NSString *)key;
/**
 清空本地存储
 */
- (void)clearAll;
@end
