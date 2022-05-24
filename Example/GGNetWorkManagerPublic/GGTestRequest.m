//
//  GGTestRequest.m
//  GGNetWorkManager
//
//  Created by GG on 2022/5/17.
//

#import "GGTestRequest.h"
#import <QMUIKit.h>
#import <GGNetWork.h>

#define Dev_Path @"v4.activityIndex/appIndexActivityInfo"

@implementation GGTestRequest

#pragma mark ------------------------- Cycle -------------------------
- (instancetype)init {
    if (self = [super init]) {
        [self configAnimatingView];
    }
    return self;
}

#pragma mark ------------------------- Config -------------------------
- (void)configAnimatingView {
    self.animatingView = [QMUIHelper visibleViewController].view ? : [GGNetWorkHelper getKeyWindow];
    self.animatingText = @"加载中..";
}

#pragma mark ------------------------- Override -------------------------
// 请求 path
- (NSString *)requestUrl {
    return Dev_Path;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

// 可以定制参数，不影响已经配置的公共参数
- (id)requestArgument {
    return nil;
}

// 可以指定域名，也可以不指定，按照配置的来
- (NSString *)baseUrl {
    return nil;
}

- (NSTimeInterval)requestTimeoutInterval {
    return [GGNetWorkManager share].timeoutInterval;
}

- (BOOL)useCDN {
    return NO;
}

- (void)requestCompleteFilter {
    NSString *resStr = [NSString stringWithFormat:@"返回数据:\n%@", self.responseObject];
    
    NSString *logStr = [GGNetWorkHelper getStringToLogRequest:self forRequestFail:NO appendString:resStr];
    
//    NSLog(@"%@", logStr);
    
}

- (void)requestFailedFilter {
//    NSLog(@"%@", [GGNetWorkHelper getStringToLogRequest:self forRequestFail:YES appendString:nil]);
}

@end
