//
//  GGViewController.m
//  GGNetWorkManager
//
//  Created by Weigh156 on 05/19/2022.
//  Copyright (c) 2022 Weigh156. All rights reserved.
//

#import "GGViewController.h"
#import <GGNetWork.h>
#import "GGTestRequest.h"
#import <QMUIKit.h>
#import "GGCachesRequest.h"

@interface GGViewController ()<YTKChainRequestDelegate>

@property (nonatomic, strong) QMUIGridView *gridView;

@property (nonatomic, strong) GGTestRequest *request;

@property (nonatomic, strong) YTKChainRequest *chainRequest;

@property (nonatomic, strong) YTKBatchRequest *batchRequest;

@property (nonatomic, strong) GGCachesRequest *cacheRequest;

@end

@implementation GGViewController

#pragma mark ------------------------- Cycle -------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpUI];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    QMUILog(nil, @"iOS 网络开发管理器 Demo");
}

#pragma mark ------------------------- UI -------------------------
- (void)setUpNav {
    self.title = @"iOS 网络开发管理器 Demo";
}

- (void)setUpUI {
    NSArray *array = @[
        @"单个请求",
        @"多个请求串行",
        @"多个请求并行",
        @"缓存请求",
    ];
    BeginIgnoreDeprecatedWarning
    _gridView = [[QMUIGridView alloc] initWithColumn:1 rowHeight:50.f];
    [self.view addSubview:_gridView];
    _gridView.separatorDashed = YES;
    _gridView.separatorColor = UIColorGray;
    _gridView.separatorWidth = 0.9f;
    _gridView.frame = CGRectSetSize(CGRectZero, CGSizeMake(200.f, 50.f * array.count));
    _gridView.center = self.view.center;
    
    for (NSInteger i = 0; i < array.count; i++) {
        QMUIFillButton *btn = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
        [_gridView addSubview:btn];
        btn.fillColor = [UIColor qmui_randomColor];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        btn.qmui_tapBlock = ^(__kindof UIControl *sender) {
            NSString *actionName = [NSString stringWithFormat:@"test_Req%ld", (long)i];
            BeginIgnorePerformSelectorLeaksWarning
            [weakSelf performSelector:NSSelectorFromString(actionName)];
            EndIgnorePerformSelectorLeaksWarning
        };
    }
}

#pragma mark ------------------------- Actions -------------------------
- (void)test_Req0 {
    GGTestRequest *req = [GGTestRequest new];
    
    _request = req;
    
    req.animatingView = self.view;
    
    [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        QMUILog(nil, @"\n请求成功 : %@", request.responseObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        QMUILog(nil, @"\n请求失败 : %@\n", request.error.localizedDescription);
    }];
}

- (void)test_Req1 {
    GGTestRequest *req = [GGTestRequest new];
    req.doNotShowHUD = YES;
    req.tag = 1000;
    
    GGTestRequest *req_1 = [GGTestRequest new];
    req_1.doNotShowHUD = YES;
    req_1.tag = 1001;
    
    GGTestRequest *req_2 = [GGTestRequest new];
    req_2.doNotShowHUD = YES;
    req_2.tag = 1002;
    
    YTKChainRequest *chainReq = [YTKChainRequest new];
    
    [chainReq addRequest:req callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        if (!baseRequest.error) {
            QMUILog(nil, @"请求成功 : req");
        } else {
            QMUILog(nil, @"\n请求失败 : req %@\n", baseRequest.error.localizedDescription);
        }
    }];
    
    [chainReq addRequest:req_1 callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        if (!baseRequest.error) {
            QMUILog(nil, @"请求成功 : req-1");
        } else {
            QMUILog(nil, @"\n请求失败 : req-1 %@\n", baseRequest.error.localizedDescription);
        }
    }];
    
    [chainReq addRequest:req_2 callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        if (!baseRequest.error) {
            QMUILog(nil, @"请求成功 : req-2");
        } else {
            QMUILog(nil, @"\n请求失败 : req-2 %@\n", baseRequest.error.localizedDescription);
        }
    }];
    
    chainReq.animatingText = @"请求中..";
    chainReq.animatingView = self.view;
    
    [chainReq start];
    
    chainReq.delegate = self;
    
    _chainRequest = chainReq;
}

- (void)test_Req2 {
    GGTestRequest *req = [GGTestRequest new];
    req.doNotShowHUD = YES;
    req.tag = 1000;
    
    GGTestRequest *req_1 = [GGTestRequest new];
    req_1.doNotShowHUD = YES;
    req_1.tag = 1001;
    
    GGTestRequest *req_2 = [GGTestRequest new];
    req_2.doNotShowHUD = YES;
    req_2.tag = 1002;
    
    YTKBatchRequest *batchReq = [[YTKBatchRequest alloc] initWithRequestArray:@[
        req,
        req_1,
        req_2,
    ]];
    
    _batchRequest = batchReq;
    
    [batchReq startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        QMUILog(nil, @"请求成功 : req");
    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        QMUILog(nil, @"\n请求失败 : BatchRequest - request tag : %ld \n%@\n", (long)batchRequest.failedRequest.tag, batchRequest.failedRequest.error.localizedDescription);
    }];
    
    batchReq.animatingText = @"请求中..";
    batchReq.animatingView = self.view;
    
    [batchReq start];
}

- (void)test_Req3 {
    self.cacheRequest.ignoreCache = NO;
    
    NSError *error = [NSError new];
    BOOL loadCaches = [self.cacheRequest loadCacheWithError:&error];
    if (loadCaches) {
        [QMUITips showInfo:@"有缓存信息"];
        
        QMUILog(nil, @"缓存信息: \n%@", self.cacheRequest.responseJSONObject);
        
        return;
    } else {
        QMUILog(nil, @"%@", error.localizedDescription);
    }
    
    self.cacheRequest.successCompletionBlock = ^(__kindof YTKRequest * _Nonnull request) {
        [QMUITips showSucceed:@"请求成功"];
    };
    
    self.cacheRequest.failureCompletionBlock = ^(__kindof YTKRequest * _Nonnull request) {
        [QMUITips showError:@"请求失败"];
    };
    
    [self.cacheRequest start];
}

#pragma mark ------------------------- Delegate -------------------------
- (void)chainRequestFinished:(YTKChainRequest *)chainRequest {
    QMUILog(nil, @"请求完成 : ChainRequest");
}

- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest *)request {
    QMUILog(nil, @"\n请求失败 : ChainRequest - request tag : %ld \n%@\n", (long)request.tag, request.error.localizedDescription);
}

#pragma mark ------------------------- set / get -------------------------
- (GGCachesRequest *)cacheRequest {
    if (!_cacheRequest) {
        _cacheRequest = [GGCachesRequest new];
    }
    
    return _cacheRequest;
}

@end
