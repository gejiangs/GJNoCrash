//
//  NSAttributedString+GJCrash.m
//  GJNoCrash
//
//  Created by gejiangs on 2019/04/01.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "NSAttributedString+GJCrash.h"
#import "NSObject+GJSwizzle.h"

@implementation NSAttributedString (GJCrash)

+ (void)load
{
    Class NSConcreteAttributedString = NSClassFromString(@"NSConcreteAttributedString");
    
    //initWithString:
    [self gj_instanceSwizzleMethodWithClass:NSConcreteAttributedString orginalMethod:@selector(initWithString:) replaceMethod:@selector(gj_initWithString:)];
    //initWithAttributedString
    [self gj_instanceSwizzleMethodWithClass:NSConcreteAttributedString orginalMethod:@selector(initWithAttributedString:) replaceMethod:@selector(gj_initWithAttributedString:)];

    //initWithString:attributes:
    [self gj_instanceSwizzleMethodWithClass:NSConcreteAttributedString orginalMethod:@selector(initWithString:attributes:) replaceMethod:@selector(gj_initWithString:attributes:)];
}

- (instancetype)gj_initWithString:(NSString *)str {
    id object = nil;
    
    @try {
        object = [self gj_initWithString:str];
    }
    @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:GJCrashDefaultReturnNil];
    }
    @finally {
        return object;
    }
}

#pragma mark - initWithAttributedString
- (instancetype)gj_initWithAttributedString:(NSAttributedString *)attrStr {
    id object = nil;
    
    @try {
        object = [self gj_initWithAttributedString:attrStr];
    }
    @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:GJCrashDefaultReturnNil];
    }
    @finally {
        return object;
    }
}

#pragma mark - initWithString:attributes:

- (instancetype)gj_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    id object = nil;
    
    @try {
        object = [self gj_initWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:GJCrashDefaultReturnNil];
    }
    @finally {
        return object;
    }
}

@end
