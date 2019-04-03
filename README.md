# GJNoCrash
大概原理很简单，使用Swizzle Method，对NSString、NSMutableString、NSArray、NSMutableArray、NSDictionary、NSMutableDictionary、KVO
这些常用的类方法做了方法替换，数组索引越界、字典数据对象为nil的异常处理，并打印错误消息(目前0.0.1版本只简单的做了打印错误消息，后期会增加crash.log)

# 以下是常见的异常
```objc
NSString *s = @"aa";
NSString *ss = [s substringFromIndex:10];
NSLog(@"ss:%@", ss);
        
NSMutableString *s = [NSMutableString stringWithFormat:@"aaaa"];
NSString *ss = [s stringByReplacingCharactersInRange:NSMakeRange(10, 10) withString:@"bb"];
NSLog(@"ss:%@", ss);
        
NSArray *a = [NSArray array];
id v = [a objectAtIndex:10];
NSLog(@"array index 10 :%@", v);
        
NSMutableArray *array = [NSMutableArray array];
[array addObject:nil];
NSLog(@"NSMutableArray:%@", array);
        
NSMutableDictionary *dict = [NSMutableDictionary dictionary];
[dict setObject:nil forKey:@"key1"];
[dict setObject:@"value1" forKey:nil];
[dict setObject:@"value2" forKey:@"key2"];
NSLog(@"NSMutableDictionary:%@", dict);
```

##Crash log 处理有两种方式
```objc

#import "GJCrashLog.h"
//方法1 block方法
[[GJCrashLog manager] callbackCrashLog:^(NSString *crashLog) {
          //处理crashlog
}];

//方法2 delegate方式
[GJCrashLog manager].delegate = self;
//GJCrashLog Delegate
-(void)callbackGJCrashLog:(NSString *)crashLog
{
    //处理crashlog
}
```

# 使用方法很简单，打开Podfile文件，添加如下代码
```
pod 'GJNoCrash'
```
就行了，不需要做额外引用
