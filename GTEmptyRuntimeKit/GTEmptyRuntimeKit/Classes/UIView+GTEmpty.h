//
//  UIView+GTEmpty.h
//  GTEmptyRuntimeKit
//
//  Created by cocomanber on 2019/5/11.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTLoadManager.h"

@interface UIView (GTEmpty)

/** 更改当前视图加载状态 */
@property (nonatomic, assign)GTLoadingStatusStyle gtLoadingStyle;

/** 可设置的参数 */
@property (nonatomic ,strong)GTLoadManager *loadingManager;

@end


