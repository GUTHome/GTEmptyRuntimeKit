//
//  GTLoadEmptyView.h
//  GTEmptyRuntimeKit
//
//  Created by cocomanber on 2019/5/11.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTLoadManager.h"

@interface GTLoadEmptyView : UIView

/// 根据当前的manager配置出合适的视图给到外面展示
- (instancetype)initWithFrame:(CGRect)frame withConfig:(GTLoadManager *)manager;

/// 常规默认配置，由上到下的布局：图片-title-content-button
/// 视图层级：superView - view(GTLoadEmptyView) - scrollView - view(可扩展自定义) - subviews[icon+title+content+button]

/// 保证内容超出屏幕时也不至于直接被clip
@property(nonatomic, strong) UIScrollView *scrollView;

///载体：可添加自定义的view
@property(nonatomic, strong) UIView *contentView;

/// subviews
@property (nonatomic ,strong) UIImageView *iconImageView;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UILabel *contentLabel;
@property (nonatomic ,strong) UIButton *actionButton;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

