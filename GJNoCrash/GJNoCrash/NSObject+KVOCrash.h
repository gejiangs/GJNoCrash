//
//  NSObject+KVOCrash.h
//  GJNoCrash
//
//  Created by gejiangs on 2017/12/14.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GJCPKVOInfo;

typedef void (^GJCPKVONotificationBlock)(id _Nullable observer, id _Nullable object, NSDictionary<NSKeyValueChangeKey, id> * _Nullable change);
/**
 KVO的管理者
 KVO Crash fix
 */
@interface KVOProxy :NSObject

- (BOOL)gj_addObserver:(id _Nullable )object KVOinfo:(GJCPKVOInfo *_Nullable)KVOInfo;

- (void)gj_removeObserver:(id _Nullable )object keyPath:(NSString *_Nullable)keyPath block:(void(^_Nullable)(void)) block;

- (void)gj_removeAllObserver;

@end


/**
 KVO配置层
 */
@interface GJCPKVOInfo : NSObject

- (instancetype _Nullable )initWithKeyPath:(NSString *_Nullable)keyPath options:(NSKeyValueObservingOptions)options context:(void *_Nullable)context;

@end

@interface NSObject (KVOCrash)

@property (nonatomic, strong) KVOProxy * _Nullable KVOProxy;

@end
