//
//  GTLoadConfiger.m
//  GTEmptyRuntimeKit
//
//  Created by cocomanber on 2019/5/11.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "GTLoadConfiger.h"

@implementation GTLoadConfiger

+ (instancetype)shareManager {
    static GTLoadConfiger * _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[GTLoadConfiger alloc] init];
    });
    return _instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        //标题文字颜色
        _titleTextColor = [UIColor blackColor];
        _titleTextFont = [UIFont systemFontOfSize:18.f];
        
        //内容文字颜色
        _contentTextColor = [UIColor darkGrayColor];
        _contentTextFont = [UIFont systemFontOfSize:14.f];
        
        //按钮文字颜色
        _buttonTextColor = [UIColor lightGrayColor];
        _buttonTextFont = [UIFont systemFontOfSize:14.f];
        
        _buttonBorderColor = [UIColor lightGrayColor];
        _buttonBorderWidth = 1.0 / [UIScreen mainScreen].scale;
        
        _buttonEdgeInsets = UIEdgeInsetsMake(8, 15, 8, 15);
        
        _backgroundColor = [UIColor whiteColor];
        
        _verticalOffset = -30;
        _titleOffset = 30;
        _contentOffset = 13;
        _buttonOffset = 15;
    }
    return self;
}

@end
