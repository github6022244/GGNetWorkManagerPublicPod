//
//  YTKNetworkAgent+GGNetWork.m
//  GGNetWorkManager
//
//  Created by GG on 2022/5/20.
//

#import "YTKNetworkAgent+GGNetWork.h"
#import <objc/runtime.h>
#import "GGNetWorkManager.h"
#import "GGNetWorkHelper.h"

@implementation YTKNetworkAgent (GGNetWork)

+ (void)load {
#ifdef DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        Method oriMethod = class_getInstanceMethod([self class], @selector(addRequest:));
//        Method newMethod = class_getInstanceMethod([self class], @selector(gg_addRequest:));
//        method_exchangeImplementations(oriMethod, newMethod);
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        Method oriMethod = class_getInstanceMethod([self class], @selector(sessionTaskForRequest:error:));
#pragma clang diagnostic pop
        Method newMethod = class_getInstanceMethod([self class], @selector(gg_sessionTaskForRequest:error:));
        method_exchangeImplementations(oriMethod, newMethod);
        
    });
#endif
}

#pragma mark --- 统一打印网络请求参数、url
- (NSURLSessionTask *)gg_sessionTaskForRequest:(YTKBaseRequest *)request error:(NSError * _Nullable __autoreleasing *)error {
    NSURLSessionTask *task = [self gg_sessionTaskForRequest:request error:error];

    if ([GGNetWorkManager share].debugLogEnable) {
        // 打印
        NSString *resStr = [NSString stringWithFormat:@"完整URL:\n%@", task.originalRequest.URL.absoluteString];
        
        NSString *logStr = [GGNetWorkHelper getStringToLogRequest:request forRequestFail:NO appendString:resStr];
        
        GGNetWorkLog(@"%@", logStr);
    }
    
    return task;
}

@end
