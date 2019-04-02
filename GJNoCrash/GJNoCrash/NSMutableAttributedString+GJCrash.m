//
//  NSMutableAttributedString+GJCrash.m
//  GJNoCrash
//
//  Created by gejiangs on 2019/04/01.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "NSMutableAttributedString+GJCrash.h"
#import "NSObject+GJSwizzle.h"

@implementation NSMutableAttributedString (GJCrash)

+ (void)load
{
    Class NSConcreteMutableAttributedString = NSClassFromString(@"NSConcreteMutableAttributedString");
    
    //initWithString:
    [self gj_instanceSwizzleMethodWithClass:NSConcreteMutableAttributedString orginalMethod:@selector(initWithString:) replaceMethod:@selector(gj_initWithString:)];

    //initWithString:attributes:
    [self gj_instanceSwizzleMethodWithClass:NSConcreteMutableAttributedString orginalMethod:@selector(initWithString:attributes:) replaceMethod:@selector(gj_initWithString:attributes:)];
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
