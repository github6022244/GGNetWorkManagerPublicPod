//
//  YTKRequest+GGNetWork.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/10.
//

#import "YTKRequest+GGNetWork.h"
#import <objc/runtime.h>
#import "GGNetWorkManager.h"
#import "GGNetWorkManagerDefine.h"

@implementation YTKRequest (GGNetWork)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oriMethod = class_getInstanceMethod([self class], @selector(saveResponseDataToCacheFile:));
        Method newMethod = class_getInstanceMethod([self class], @selector(gg_saveResponseDataToCacheFile:));
        method_exchangeImplementations(oriMethod, newMethod);
        
        Method oriMethod_2 = class_getInstanceMethod([self class], @selector(validateCacheWithError:));
        Method newMethod_2 = class_getInstanceMethod([self class], @selector(gg_validateCacheWithError:));
        method_exchangeImplementations(oriMethod_2, newMethod_2);
    });
}

- (BOOL)gg_validateCacheWithError:(NSError * _Nullable __autoreleasing *)error {
    BOOL reslut = [self gg_validateCacheWithError:error];
    
    BOOL autoClear = NO;
    if ([self respondsToSelector:@selector(autoClearCachesIfNotValidate)]) {
        autoClear = [self performSelector:@selector(autoClearCachesIfNotValidate)];
    }
    
    if (!reslut && autoClear) {
        // 未验证通过
        [self clearCachesIfExists];
    }
    
    return reslut;
}

#pragma mark --- 重新指定缓存 Data
- (void)gg_saveResponseDataToCacheFile:(NSData *)data {
    NSData *exchangeData = data;
    
    if (!data && !self.responseData) {
        /// YTK只有在 responseObject 是 NSData 时，responseData 才有值，才会进行缓存操作
        /// 这里重新指定一下 responseData
        if ([self.responseObject isKindOfClass:[NSData class]]) {
            exchangeData = self.responseObject;
        } else if ([self.responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = self.responseObject;
            exchangeData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        } else if ([self.responseObject isKindOfClass:[NSString class]]) {
            NSString *string = self.responseObject;
            exchangeData = [string dataUsingEncoding:NSUTF8StringEncoding];
        } else if ([self.responseObject isKindOfClass:[NSNumber class]]) {
            NSNumber *number = self.responseObject;
            exchangeData = [number.stringValue dataUsingEncoding:NSUTF8StringEncoding];
        } else {
            if ([GGNetWorkManager share].debugLogEnable) {
                GGNetWorkLog(@"responseObject 类型转换失败, 需完善类型判断");
            }
        }
    }
    
    [self gg_saveResponseDataToCacheFile:exchangeData];
}

#pragma mark --- 如果存在缓存文件则删除
- (void)clearCachesIfExists {
    if ([self respondsToSelector:NSSelectorFromString(@"cacheMetadataFilePath")]) {
        NSString *path = [self performSelector:NSSelectorFromString(@"cacheMetadataFilePath")];
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path]) {
            BOOL remove = [fileManager removeItemAtPath:path error:nil];
            if (remove) {
                GGNetWorkLog(@"缓存验证未通过,自动删除缓存成功");
            }
        }
    }
}

@end
