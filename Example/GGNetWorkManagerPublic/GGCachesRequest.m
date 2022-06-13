//
//  GGCachesRequest.m
//  GGNetWorkManager_Example
//
//  Created by GG on 2022/6/13.
//  Copyright © 2022 1563084860@qq.com. All rights reserved.
//

#import "GGCachesRequest.h"

@implementation GGCachesRequest

- (NSInteger)cacheTimeInSeconds {
    return 60;
}

/// 如果缓存验证不通过，是否自动删除缓存文件
- (BOOL)autoClearCachesIfNotValidate {
    return YES;
}

/// 是否使用公共参数（默认YES）
- (BOOL)useCommenParameters {
    return YES;
}

/// 是否使用公共Header（默认YES）
- (BOOL)useCommenHeader {
    return YES;
}

@end
