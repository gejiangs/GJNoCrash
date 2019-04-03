//
//  GJCrashLog.h
//  GJNoCrash
//
//  Created by gejiangs on 2017/12/15.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CrashLogBlock)(NSString *crashLog);

@protocol GJCrashLogDelegate <NSObject>

@optional

-(void)callbackGJCrashLog:(NSString *)crashLog;

@end

@interface GJCrashLog : NSObject

@property (nonatomic, copy) NSString * _Nullable crashMsg;
@property (nonatomic, weak) id<GJCrashLogDelegate> delegate;

+(instancetype)manager;


/**
 有crash log后，会回调该方法

 @param crashLog crash log
 */
-(void)callbackCrashLog:(CrashLogBlock)crashLog;

/**
 打印crash消息
 
 @param exception Crash 内容
 */
-(void)printException:(NSException *)exception;

/**
 打印crash消息

 @param object Crash 对象
 @param exception Crash 内容
 */
-(void)printObject:(id)object exception:(NSException *)exception;

@end
