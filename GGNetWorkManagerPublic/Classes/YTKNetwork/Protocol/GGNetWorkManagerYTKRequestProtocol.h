//
//  GGNetWorkManagerYTKRequestProtocol.h
//  GGNetWorkManager
//
//  Created by GG on 2022/6/10.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GGNetWorkManagerYTKRequestProtocol <NSObject>

@optional
/// 如果缓存验证不通过，是否自动删除缓存文件
- (BOOL)autoClearCachesIfNotValidate;

@end

NS_ASSUME_NONNULL_END
