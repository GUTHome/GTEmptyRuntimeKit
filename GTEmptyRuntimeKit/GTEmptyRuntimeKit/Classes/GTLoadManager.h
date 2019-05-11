//
//  GTLoadManager.h
//  GTEmptyRuntimeKit
//
//  Created by cocomanber on 2019/5/11.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GTLoadingStatusStyle){
    GTLoadingStatusStyleDefault = 0,        //移除视图
    GTLoadingStatusStyleNoData  = 1,        //暂无数据
    GTLoadingStatusStyleNetError= 2,        //网络失败
    GTLoadingStatusStyleOther   = 3,        //特殊需求
    GTLoadingStatusStyleReView  = 4,        //全新订制
    GTLoadingStatusStyleLoading = 5,        //加载菊花
};

@interface GTLoadManager : NSObject

/// 初始化
- (instancetype)initWithStyle:(GTLoadingStatusStyle)style;
@property (nonatomic, assign)GTLoadingStatusStyle loadStyle;

/// 按钮统一回调
@property (nonatomic, copy) dispatch_block_t netErrorReloadBlock;

/// 快速获取各个状态的默认值
- (UIImage *)imageOnStatus:(GTLoadingStatusStyle)status;
- (NSString *)titlrOnStatus:(GTLoadingStatusStyle)status;
- (NSString *)contentOnStatus:(GTLoadingStatusStyle)status;
- (NSString *)buttonOnStatus:(GTLoadingStatusStyle)status;

@property(nonatomic, assign) UIEdgeInsets loadingAreaInsets;     //整个视图的边距

/// 以下自定义操作针对GTLoadingStatusStyleOther类型起作用
@property (nonatomic ,strong) UIImage *statusImageData;       //图片
@property (nonatomic ,strong) NSString *statusTitleDesc;      //标题
@property (nonatomic ,strong) NSString *statusContentDesc;    //内容
@property (nonatomic ,strong) NSString *statusButtonDesc;     //按钮

@property (nonatomic ,strong) UIColor *statusTitleColor;      //标题颜色
@property (nonatomic ,strong) UIColor *statusContentColor;    //内容颜色
@property (nonatomic ,strong) UIColor *statusButtonColor;     //按钮颜色

@property (nonatomic ,strong) UIFont *statusTitleFont;        //标题字体
@property (nonatomic ,strong) UIFont *statusConetntFont;      //内容字体
@property (nonatomic ,strong) UIFont *statusButtonFont;       //按钮字体

@property (nonatomic ,strong) UIColor *statusButtonBorderColor; //按钮边框颜色
@property (nonatomic, assign) CGFloat statusButtonBorderWidth;  //宽度

/// 以下属性针对GTLoadingStatusStyleReView类型起作用
@property (nonatomic, strong)UIView *resetView;
@property (nonatomic, assign)CGSize resetViewSize;

@end


