//
//  NSMutableString+GJCrash.m
//  GJNoCrash
//
//  Created by gejiangs on 2019/04/01.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "NSMutableString+GJCrash.h"
#import "NSObject+GJSwizzle.h"

@implementation NSMutableString (GJCrash)

+ (void)load
{
    Class __NSCFString = NSClassFromString(@"__NSCFString");
    
    //replaceCharactersInRange
    [self gj_instanceSwizzleMethodWithClass:__NSCFString orginalMethod:@selector(replaceCharactersInRange:withString:) replaceMethod:@selector(gj_replaceCharactersInRange:withString:)];
    
    //insertString:atIndex:
    [self gj_instanceSwizzleMethodWithClass:__NSCFString orginalMethod:@selector(insertString:atIndex:) replaceMethod:@selector(gj_insertString:atIndex:)];

    //deleteCharactersInRange
    [self gj_instanceSwizzleMethodWithClass:__NSCFString orginalMethod:@selector(deleteCharactersInRange:) replaceMethod:@selector(gj_deleteCharactersInRange:)];
}

#pragma mark - replaceCharactersInRange
- (void)gj_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    @try {
        [self gj_replaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:GJCrashDefaultReturnIgnore];
    }
    @finally {
    }
}

#pragma mark - insertString:atIndex:
- (void)gj_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    
    @try {
        [self gj_insertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:GJCrashDefaultReturnIgnore];
    }
    @finally {
    }
}

#pragma mark - deleteCharactersInRange

- (void)gj_deleteCharactersInRange:(NSRange)range {
    
    @try {
        [self gj_deleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        [GJCrashLog gj_noteErrorWithException:exception attachedTODO:GJCrashDefaultReturnIgnore];
    }
    @finally {
    }
}

@end
