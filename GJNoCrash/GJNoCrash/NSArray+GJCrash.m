//
//  NSArray+GJCrash.m
//  GJNoCrash
//
//  Created by gejiang on 2019/04/01.
//  Copyright © 2019 gejiangs. All rights reserved.
//

/**
 
 iOS 8:下都是__NSArrayI
 iOS11: 之后分 __NSArrayI、  __NSArray0、__NSSingleObjectArrayI
 
 iOS11之前：arr@[]  调用的是[__NSArrayI objectAtIndexed]
 iOS11之后：arr@[]  调用的是[__NSArrayI objectAtIndexedSubscript]
 
 arr为空数组
 *** -[__NSArray0 objectAtIndex:]: index 12 beyond bounds for empty NSArray
 
 arr只有一个元素
 *** -[__NSSingleObjectArrayI objectAtIndex:]: index 12 beyond bounds [0 .. 0]
 
 */

#import "NSArray+GJCrash.h"
#import "NSObject+GJSwizzle.h"

@implementation NSArray (GJCrash)

+ (void)load
{
    NSLog(@"array load");
    Class __NSArray = objc_getClass("NSArray");
    Class __NSArrayI = objc_getClass("__NSArrayI");
    Class __NSSingleObjectArrayI = objc_getClass("__NSSingleObjectArrayI");
    Class __NSArray0 = objc_getClass("__NSArray0");
    
    [self gj_classSwizzleMethodWithClass:__NSArray orginalMethod:@selector(arrayWithObjects:count:) replaceMethod:@selector(gj_arrayWithObjects:count:)];
    
    // objectAtIndex:
    /* 数组count >= 2 */
    [self gj_instanceSwizzleMethodWithClass:__NSArrayI orginalMethod:@selector(objectAtIndex:) replaceMethod:@selector(gj_objectAtIndex:)];//[arr objectAtIndex:];
    
    [self gj_instanceSwizzleMethodWithClass:__NSArrayI orginalMethod:@selector(objectAtIndexedSubscript:) replaceMethod:@selector(gj_objectAtIndexedSubscript:)];//arr[];
    
    /* 数组为空 */
    [self gj_instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(objectAtIndex:) replaceMethod:@selector(gj_objectAtIndexedNullarray:)];
    
    /* 数组count == 1 */
    [self gj_instanceSwizzleMethodWithClass:__NSSingleObjectArrayI orginalMethod:@selector(objectAtIndex:) replaceMethod:@selector(gj_objectAtIndexedArrayCountOnlyOne:)];
    
    // objectsAtIndexes:
    [self gj_instanceSwizzleMethodWithClass:__NSArray orginalMethod:@selector(objectsAtIndexes:) replaceMethod:@selector(gj_objectsAtIndexes:)];
    
    // 以下方法调用频繁，替换可能会影响性能
    // getObjects:range:
    [self gj_instanceSwizzleMethodWithClass:__NSArray orginalMethod:@selector(getObjects:range:) replaceMethod:@selector(gj_getObjectsNSArray:range:)];
    [self gj_instanceSwizzleMethodWithClass:__NSSingleObjectArrayI orginalMethod:@selector(getObjects:range:) replaceMethod:@selector(gj_getObjectsNSSingleObjectArrayI:range:)];
    [self gj_instanceSwizzleMethodWithClass:__NSArrayI orginalMethod:@selector(getObjects:range:) replaceMethod:@selector(gj_getObjectsNSArrayI:range:)];
}

#pragma mark - instance array
+ (instancetype)gj_arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self gj_arrayWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"This framework default is to remove nil object and instance a array.";
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:defaultToDo];

        //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self gj_arrayWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}


- (id)gj_objectAtIndex:(NSUInteger)index {
//    if (index >= self.count) {
//        [GJCrashLog printCrashMsg:[NSString stringWithFormat:@"-%s: index %ld beyond bounds [0 .. %lu]",__func__,index,(unsigned long)self.count]];
//        return nil;
//    }
//    return [self gj_objectAtIndex:index];
    
    id object = nil;
    @try {
        object = [self gj_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:@""];
    }
    @finally {
        return object;
    }
}

- (id)gj_objectAtIndexedSubscript:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self gj_objectAtIndexedSubscript:index];
    }
    @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:@""];
    }
    @finally {
        return object;
    }
}

- (id)gj_objectAtIndexedNullarray:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self gj_objectAtIndexedNullarray:index];
    }
    @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:@""];
    }
    @finally {
        return object;
    }
}

- (id)gj_objectAtIndexedArrayCountOnlyOne:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self gj_objectAtIndexedArrayCountOnlyOne:index];
    }
    @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:@""];
    }
    @finally {
        return object;
    }
}

- (NSArray *)gj_objectsAtIndexes:(NSIndexSet *)indexes {
    NSArray *returnArray = nil;
    @try {
        returnArray = [self gj_objectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:GJCrashDefaultReturnNil];
        
    } @finally {
        return returnArray;
    }
}

#pragma mark getObjects:range:
- (void)gj_getObjectsNSArray:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self gj_getObjectsNSArray:objects range:range];
    } @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:GJCrashDefaultReturnIgnore];
    } @finally {
    }
}

- (void)gj_getObjectsNSSingleObjectArrayI:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self gj_getObjectsNSSingleObjectArrayI:objects range:range];
    } @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:GJCrashDefaultReturnIgnore];
    } @finally {
    }
}

- (void)gj_getObjectsNSArrayI:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self gj_getObjectsNSArrayI:objects range:range];
    } @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:GJCrashDefaultReturnIgnore];
    } @finally {
    }
}

@end
