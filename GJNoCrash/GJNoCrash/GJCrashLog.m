//
//  GJCrashLog.m
//  GJNoCrash
//
//  Created by gejiangs on 2017/12/15.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "GJCrashLog.h"
#import <UIKit/UIKit.h>
#import "sys/utsname.h"

@interface GJCrashLog ()

@property (nonatomic, copy) CrashLogBlock logBlock;

@end

@implementation GJCrashLog

+(instancetype)manager
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
    });
    return obj;
}

-(void)callbackCrashLog:(CrashLogBlock)crashLog
{
    self.logBlock = crashLog;
}


/**
 打印crash消息
 
 @param exception Crash 内容
 */
-(void)printException:(NSException *)exception
{
    [self printObject:nil exception:exception];
}

/**
 打印crash消息
 
 @param object Crash 对象
 @param exception Crash 内容
 */
-(void)printObject:(id)object exception:(NSException *)exception
{
    // 堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [self _getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[2]];
    
    if (mainCallStackSymbolMsg == nil) {
        mainCallStackSymbolMsg = @"崩溃方法定位失败,请您查看函数调用栈来排查错误原因";
    }
    
    NSMutableString *msg = [NSMutableString string];
    [msg appendString:[self deviceInfo]];
    if (object) {        
        if ([object isKindOfClass:NSClassFromString(@"__NSCFConstantString")]) {
            [msg appendFormat:@"[NSString]:%@\n", object];
        }else if ([object isKindOfClass:NSClassFromString(@"NSConcreteAttributedString")]){
            [msg appendFormat:@"[NSAttributedString]:%@\n", object];
        }else if ([object isKindOfClass:[NSArray class]]){
            [msg appendFormat:@"[NSArray]:%@\n", ((NSArray *)object).description];
        }else if ([object isKindOfClass:[NSDictionary class]]){
            [msg appendFormat:@"[NSDictionary]:%@\n", ((NSDictionary *)object).description];
        }else if ([object isKindOfClass:[NSObject class]]){
            [msg appendFormat:@"[NSObject]:%@\n", ((NSObject *)object).description];
        }
    }
    [msg appendFormat:@"[Crash Type]: %@\n",exception.name];
    [msg appendFormat:@"[Crash Reason]: %@\n",exception.reason];
    [msg appendFormat:@"[Error Place]: %@\n",mainCallStackSymbolMsg];
    [msg appendFormat:@"[Crash Type]: %@",exception.callStackSymbols];
    
    if (self.logBlock) {
        self.logBlock(msg);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(callbackGJCrashLog:)]) {
        [self.delegate callbackGJCrashLog:msg];
    }
    
    if (DEBUG) {
        NSLog(@"%@", msg);
    }
}

/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbolStr 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */
- (NSString *)_getMainCallStackSymbolMessageWithCallStackSymbolStr:(NSString *)callStackSymbolStr {
    
    //正则表达式
    //http://www.jianshu.com/p/b25b05ef170d
    
    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    [regularExp enumerateMatchesInString:callStackSymbolStr options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbolStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (result) {
            mainCallStackSymbolMsg = [callStackSymbolStr substringWithRange:result.range];
            *stop = YES;
        }
    }];
    
    return mainCallStackSymbolMsg;
}



-(NSString *)deviceInfo
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform      = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *appVersion    =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *bundleID      = [[NSBundle mainBundle] bundleIdentifier];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *time = [format stringFromDate:[NSDate date]];
    
    NSMutableString *info = [NSMutableString string];
    [info appendFormat:@"\n[Time]:%@\n",time];
    [info appendFormat:@"[Bundle Id]:%@\n", bundleID];
    [info appendFormat:@"[Device]:%@\n", platform];
    [info appendFormat:@"[System Version]:%@\n", systemVersion];
    [info appendFormat:@"[AppVersion]:%@\n", appVersion];
    
    return info;
}

@end
