//
//  NSMutableDictionary+GJCrash.m
//  GJNoCrash
//
//  Created by gejiangs on 2019/04/01.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "NSMutableDictionary+GJCrash.h"
#import "NSObject+GJSwizzle.h"

@implementation NSMutableDictionary (GJCrash)

+ (void)load
{
    Class dictionaryM = NSClassFromString(@"__NSDictionaryM");
    
    //setObject:forKey:
    [self gj_instanceSwizzleMethodWithClass:dictionaryM orginalMethod:@selector(setObject:forKey:) replaceMethod:@selector(gj_setObject:forKey:)];
    
    // iOS11
    [self gj_instanceSwizzleMethodWithClass:dictionaryM orginalMethod:@selector(setObject:forKeyedSubscript:) replaceMethod:@selector(gj_setObject:forKeyedSubscript:)];

    
    //removeObjectForKey:
    [self gj_instanceSwizzleMethodWithClass:dictionaryM orginalMethod:@selector(removeObjectForKey:) replaceMethod:@selector(gj_removeObjectForKey:)];
}

- (void)gj_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    @try {
        [self gj_setObject:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
    }
    @finally {
    }
}

- (void)gj_setObject:(id)anObject forKeyedSubscript:(id<NSCopying>)aKey {
    
    @try {
        [self gj_setObject:anObject forKeyedSubscript:aKey];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
    }
    @finally {
    }
}

- (void)gj_removeObjectForKey:(id)aKey {
    
    @try {
        [self gj_removeObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
    }
    @finally {
    }
}

@end
