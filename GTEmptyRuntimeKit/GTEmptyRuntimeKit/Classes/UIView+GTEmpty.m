//
//  UIView+GTEmpty.m
//  GTEmptyRuntimeKit
//
//  Created by cocomanber on 2019/5/11.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "UIView+GTEmpty.h"
#import <objc/runtime.h>
#import "GTLoadEmptyView.h"

const char * kGT_LOADING_STYLE_KEY = "kGT_LOADING_STYLE_KEY";
const char * kGT_LOADING_MANAGER_KEY = "kGT_LOADING_MANAGER_KEY";
const char * kGT_LOADING_VIEW_KEY = "kGT_LOADING_VIEW_KEY";

@implementation UIView (GTEmpty)

@dynamic gtLoadingStyle;
- (void)setGtLoadingStyle:(GTLoadingStatusStyle)gtLoadingStyle{
    
    //记录当前的状态
    objc_setAssociatedObject(self, &(kGT_LOADING_STYLE_KEY), @(gtLoadingStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //superView
    UIView *superView = self;
    
    //清空原来记录的view
    UIView *statusView = objc_getAssociatedObject(self, &(kGT_LOADING_VIEW_KEY));
    if (statusView) {
        [statusView removeFromSuperview];
        statusView = nil;
    }
    
    UIView *stateView = nil;
    switch (gtLoadingStyle) {
        case GTLoadingStatusStyleDefault:
        {
            //do nothing..
        }
            break;
        case GTLoadingStatusStyleLoading:
        case GTLoadingStatusStyleNoData:
        case GTLoadingStatusStyleNetError:
        case GTLoadingStatusStyleOther:
        case GTLoadingStatusStyleReView:
        {
            stateView = [self statusViewForState:gtLoadingStyle];
        }
            break;
        default:
            break;
    }
    
    //记录当前的遮盖层
    if (stateView) {
        objc_setAssociatedObject(self, &(kGT_LOADING_VIEW_KEY), stateView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    //展示视图
    if (stateView) {
        [superView addSubview:stateView];
        [superView bringSubviewToFront:stateView];
        stateView.alpha = 0.f;
        [UIView animateWithDuration:0.2 animations:^{
            stateView.alpha = 1.0;
        }];
    }
}

/// 获取对应状态的视图
- (UIView *)statusViewForState:(GTLoadingStatusStyle)currentLoadingStyle{
    self.loadingManager.loadStyle = currentLoadingStyle;
    GTLoadEmptyView *emptyView = [[GTLoadEmptyView alloc] initWithFrame:self.bounds withConfig:self.loadingManager];
    return emptyView;
}

#pragma mark -

- (GTLoadingStatusStyle)gtLoadingStyle{
    GTLoadingStatusStyle style = [objc_getAssociatedObject(self, &(kGT_LOADING_STYLE_KEY)) integerValue];
    return style;
}

- (void)setLoadingManager:(GTLoadManager *)loadingManager{
    objc_setAssociatedObject(self, &(kGT_LOADING_MANAGER_KEY), loadingManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (GTLoadManager *)loadingManager{
    GTLoadManager *manager = (GTLoadManager *)objc_getAssociatedObject(self, &(kGT_LOADING_MANAGER_KEY));
    //默认配置
    if (!manager) {
        manager = [[GTLoadManager alloc] init];
        [self setLoadingManager:manager];
    }
    return manager;
}

@end
