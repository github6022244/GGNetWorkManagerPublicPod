//
//  GGNetWorkManagerDefine.h
//  GGNetWorkManager
//
//  Created by GG on 2022/5/20.
//

#import <Foundation/Foundation.h>

#pragma mark --- ENUM
// 指定的接口环境
typedef NS_ENUM(NSUInteger, GGNetManagerServerType) {
    // 上架
    GGNetManagerServerType_Public,
    // 开发
    GGNetManagerServerType_Develop,
    // 测试
    GGNetManagerServerType_Test,
};

// 接口类型
typedef NS_ENUM(NSUInteger, GGNetManagerURLType) {
    GGNetManagerURLType_Server,// 普通接口
    GGNetManagerURLType_H5,// H5 接口
    GGNetManagerURLType_CDN,// CDN 接口
};

#ifdef DEBUG
#define GGNetWorkLog(...) NSLog(__VA_ARGS__)
#else
#define GGNetWorkLog(...)
#endif

