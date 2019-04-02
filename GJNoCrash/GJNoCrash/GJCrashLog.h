//
//  GJCrashLog.h
//  GJNoCrash
//
//  Created by gejiangs on 2017/12/15.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

//user can ignore below define
static NSString * _Nullable GJCrashDefaultReturnNil = @"This framework default is to return nil to avoid crash.";
static NSString * _Nullable GJCrashDefaultReturnIgnore  = @"This framework default is to ignore this operation to avoid crash.";

@interface GJCrashLog : NSObject

@property (nonatomic,copy) NSString * _Nullable crashMsg;

- (void)getCrashMsg;

+ (void)printCrashMsg:(NSString *_Nullable)crashMsg;

+ (void)gj_noteErrorWithException:(NSException *_Nonnull)exception attachedTODO:(NSString *_Nullable)todo;

@end
