//
//  NSMutableArray+GJCrash.m
//  GJNoCrash
//
//  Created by gejiangs on 2019/04/01.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "NSMutableArray+GJCrash.h"
#import "NSObject+GJSwizzle.h"

@implementation NSMutableArray (GJCrash)

+ (void)load
{
    Class __NSArrayM = NSClassFromString(@"__NSArrayM");
    
    // objectAtIndex:
    [self gj_instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(objectAtIndex:) replaceMethod:@selector(gj_objectAtIndex:)];
    
    [self gj_instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(objectAtIndexedSubscript:) replaceMethod:@selector(gj_objectAtIndexedSubscript:)];

    //insertObject:atIndex:
    [self gj_instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(insertObject:atIndex:) replaceMethod:@selector(gj_insertObject:atIndex:)];

    //removeObjectAtIndex:
    [self gj_instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(removeObjectAtIndex:) replaceMethod:@selector(gj_removeObjectAtIndex:)];

    //setObject:atIndexedSubscript:
    [self gj_instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(setObject:atIndexedSubscript:) replaceMethod:@selector(gj_setObject:atIndexedSubscript:)];

    [self gj_instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(getObjects:range:) replaceMethod:@selector(gj_getObjects:range:)];
}

- (id)gj_objectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self gj_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
    }
    @finally {
        return object;
    }
}

- (id)gj_objectAtIndexedSubscript:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self gj_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
    }
    @finally {
        return object;
    }
}

- (void)gj_insertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self gj_insertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
    }
    @finally {
    }
}

- (void)gj_removeObjectAtIndex:(NSUInteger)index {
    @try {
        [self gj_removeObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
    }
    @finally {
    }
}

- (void)gj_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    @try {
        [self gj_setObject:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
    }
    @finally {
    }
}

- (void)gj_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self gj_getObjects:objects range:range];
    } @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
    } @finally {
    }
}

@end
