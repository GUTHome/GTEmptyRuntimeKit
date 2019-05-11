//
//  GTLoadManager.m
//  GTEmptyRuntimeKit
//
//  Created by cocomanber on 2019/5/11.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "GTLoadManager.h"

@implementation GTLoadManager

- (instancetype)initWithStyle:(GTLoadingStatusStyle)style{
    self = [super init];
    if (self) {
        _loadStyle = style;
        _loadingAreaInsets = UIEdgeInsetsZero;
    }
    return self;
}

#pragma mark - 默认两种：无数据空白页 / 网络问题

- (UIImage *)imageOnStatus:(GTLoadingStatusStyle)status{
    switch (status) {
        case GTLoadingStatusStyleNoData:
            return [UIImage imageNamed:@"icon_nothing"];
            break;
        case GTLoadingStatusStyleNetError:
            return [UIImage imageNamed:@"icon_network_error"];
            break;
            
        default:
            return nil;
            break;
    }
}

- (NSString *)titlrOnStatus:(GTLoadingStatusStyle)status{
    switch (status) {
        case GTLoadingStatusStyleNoData:
            return @"空空如也";
            break;
        case GTLoadingStatusStyleNetError:
            return @"网络异常，请检查网络状态";
            break;
            
        default:
            return nil;
            break;
    }
}

- (NSString *)contentOnStatus:(GTLoadingStatusStyle)status{
    switch (status) {
        case GTLoadingStatusStyleNoData:
            return @"空空如也，空空如也，空空如也，空空如也，空空如也，空空如也，空空如也";
            break;
        case GTLoadingStatusStyleNetError:
            return @"网络异常，请检查网络状态，网络异常，请检查网络状态，网络异常，请检查网络状态，网络异常，请检查网络状态";
            break;
            
        default:
            return nil;
            break;
    }
}

- (NSString *)buttonOnStatus:(GTLoadingStatusStyle)status{
    switch (status) {
        case GTLoadingStatusStyleNoData:
            return @"返回上一页";
            break;
        case GTLoadingStatusStyleNetError:
            return @"重新加载";
            break;
            
        default:
            return nil;
            break;
    }
}


@end
