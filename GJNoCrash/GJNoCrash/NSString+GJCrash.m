//
//  NSString+GJCrash.m
//  GJNoCrash
//
//  Created by gejiangs on 2019/04/01.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "NSString+GJCrash.h"
#import "NSObject+GJSwizzle.h"

@implementation NSString (GJCrash)

+ (void)load
{
    Class __NSCFConstantString = NSClassFromString(@"__NSCFConstantString");
    
    //substringFromIndex
    [self gj_instanceSwizzleMethodWithClass:__NSCFConstantString orginalMethod:@selector(substringFromIndex:) replaceMethod:@selector(gj_substringFromIndex:)];
    
    //substringToIndex
    [self gj_instanceSwizzleMethodWithClass:__NSCFConstantString orginalMethod:@selector(substringToIndex:) replaceMethod:@selector(gj_substringToIndex:)];
    
    //substringWithRange:
    [self gj_instanceSwizzleMethodWithClass:__NSCFConstantString orginalMethod:@selector(substringWithRange:) replaceMethod:@selector(gj_substringWithRange:)];
    
    //characterAtIndex
    [self gj_instanceSwizzleMethodWithClass:__NSCFConstantString orginalMethod:@selector(characterAtIndex:) replaceMethod:@selector(gj_characterAtIndex:)];
    
    /* 注意swizzling先后顺序 👇： */
    //stringByReplacingOccurrencesOfString:withString:options:range:
    [self gj_instanceSwizzleMethodWithClass:__NSCFConstantString orginalMethod:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) replaceMethod:@selector(gj_stringByReplacingOccurrencesOfString:withString:options:range:)];

    //stringByReplacingCharactersInRange:withString:
    [self gj_instanceSwizzleMethodWithClass:__NSCFConstantString orginalMethod:@selector(stringByReplacingCharactersInRange:withString:) replaceMethod:@selector(gj_stringByReplacingCharactersInRange:withString:)];
}

//=================================================================
//                           characterAtIndex:
//=================================================================
#pragma mark - characterAtIndex:

- (unichar)gj_characterAtIndex:(NSUInteger)index {
    
    unichar characteristic;
    @try {
        characteristic = [self gj_characterAtIndex:index];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
    }
    @finally {
        return characteristic;
    }
}

#pragma mark - substringFromIndex:

- (NSString *)gj_substringFromIndex:(NSUInteger)from {
    
    NSString *subString = nil;
    
    @try {
        subString = [self gj_substringFromIndex:from];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

#pragma mark - substringToIndex
- (NSString *)gj_substringToIndex:(NSUInteger)index {
    
    NSString *subString = nil;
    
    @try {
        subString = [self gj_substringToIndex:index];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

#pragma mark - stringByReplacingCharactersInRange:withString:

- (NSString *)gj_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self gj_stringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

- (NSString *)gj_stringByReplacingOccurrencesOfString:(NSRange)range withString:(NSString *)replacement {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self gj_stringByReplacingOccurrencesOfString:range withString:replacement];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

#pragma mark - stringByReplacingOccurrencesOfString:withString:options:range:

- (NSString *)gj_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self gj_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

#pragma mark - substringWithRange:
- (NSString *)gj_substringWithRange:(NSRange)range {
    
    NSString *subString = nil;
    
    @try {
        subString = [self gj_substringWithRange:range];
    }
    @catch (NSException *exception) {
        [[GJCrashLog manager] printObject:self exception:exception];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

@end
