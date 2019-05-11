//
//  GTLoadConfiger.h
//  GTEmptyRuntimeKit
//
//  Created by cocomanber on 2019/5/11.
//  Copyright © 2019 cocomanber. All rights reserved.
//  全局单例配置
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GTLoadConfiger : NSObject

/// 工程主配置
+ (instancetype)shareManager;

/// 标题文字颜色
@property (nonatomic, strong)UIColor *titleTextColor;
@property (nonatomic, strong)UIFont *titleTextFont;

/// 内容文字颜色
@property (nonatomic, strong)UIColor *contentTextColor;
@property (nonatomic, strong)UIFont *contentTextFont;

/// 按钮文字颜色
@property (nonatomic, strong)UIColor *buttonTextColor;
@property (nonatomic, strong)UIFont *buttonTextFont;

@property (nonatomic, strong)UIColor *buttonBorderColor;
@property (nonatomic, assign)CGFloat buttonBorderWidth;

/// 内边距
@property (nonatomic, assign)UIEdgeInsets buttonEdgeInsets;

/// 背景颜色
@property (nonatomic, strong) UIColor *backgroundColor;

/// 垂直偏差
@property(nonatomic, assign) CGFloat verticalOffset;

/// 图片下方
@property(nonatomic, assign)CGFloat titleOffset;
/// 标题下方
@property(nonatomic, assign)CGFloat contentOffset;
/// 内容下方
@property(nonatomic, assign)CGFloat buttonOffset;

/// 默认固定模式下的配置
/// TODO...

@end

