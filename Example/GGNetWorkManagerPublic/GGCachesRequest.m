//
//  GGCachesRequest.m
//  GGNetWorkManager_Example
//
//  Created by GG on 2022/6/13.
//  Copyright © 2022 1563084860@qq.com. All rights reserved.
//

#import "GGCachesRequest.h"

@implementation GGCachesRequest

- (BOOL)autoClearCachesIfNotValidate {
    return YES;
}

- (NSInteger)cacheTimeInSeconds {
    return 60;
}

@end
