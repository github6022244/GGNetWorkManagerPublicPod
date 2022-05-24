//
//  YTKBaseRequest+GGNetWork.m
//  GGNetWorkManager
//
//  Created by GG on 2022/5/20.
//

#import "YTKBaseRequest+GGNetWork.h"
#import <objc/runtime.h>
#import "GGNetWorkManager.h"
#import "GGNetWorkHelper.h"

@implementation YTKBaseRequest (GGNetWork)

+ (void)load {
#ifdef DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oriMethod_1 = class_getInstanceMethod([self class], @selector(requestFailedFilter));
        Method newMethod_1 = class_getInstanceMethod([self class], @selector(gg_requestFailedFilter));
        method_exchangeImplementations(oriMethod_1, newMethod_1);
    });
#endif
}

#pragma mark --- 统一处理失败回调
///  Called on the main thread when request failed.
- (void)gg_requestFailedFilter {
    if ([GGNetWorkManager share].debugLogEnable) {
        GGNetWorkLog(@"%@", [GGNetWorkHelper getStringToLogRequest:self forRequestFail:YES appendString:nil]);
    }
    
    [self gg_requestFailedFilter];
}



@end
