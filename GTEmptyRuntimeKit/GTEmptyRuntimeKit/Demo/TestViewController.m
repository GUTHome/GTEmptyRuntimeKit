//
//  TestViewController.m
//  GTEmptyRuntimeKit
//
//  Created by cocomanber on 2019/5/11.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "TestViewController.h"
#import "UIView+GTEmpty.h"
#import "GTCustomView.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    /// 使用默认配置项
    __weak typeof(self) weakSelf = self;
    self.view.gtLoadingStyle = GTLoadingStatusStyleLoading;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.view.gtLoadingStyle = GTLoadingStatusStyleNetError;
        self.view.loadingManager.netErrorReloadBlock = ^{
            weakSelf.view.gtLoadingStyle = GTLoadingStatusStyleNoData;
        };
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        self.view.gtLoadingStyle = GTLoadingStatusStyleDefault;
    });
    
    /// 使用Other配置DIY类型
//    GTLoadManager *manager = [[GTLoadManager alloc] init];
//    manager.statusTitleDesc = @"这是一句话，这是一句话，这是一句话，这是一句话，这是一句话，这是一句话";
//    manager.statusContentDesc = @"这是一句话，这是一句话，这是一句话，这是一句话，这是一句话，这是一句话，这是一句话，这是一句话，这是一句话，这是一句话，这是一句话，这是一句话";
//    manager.statusImageData = [UIImage imageNamed:@"icon_message_no"];
//    self.view.loadingManager = manager;
//    self.view.gtLoadingStyle = GTLoadingStatusStyleOther;
    
    /// 使用订制的类型
//    self.view.gtLoadingStyle = GTLoadingStatusStyleLoading;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        GTCustomView *view = [[NSBundle mainBundle] loadNibNamed:@"GTCustomView" owner:nil options:nil].lastObject;
//        view.frame = CGRectMake(0, 0, 0, 300);
//        [view.customButton addTarget:self action:@selector(customButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        GTLoadManager *manager = [[GTLoadManager alloc] init];
//        manager.resetView = view;
//        manager.resetViewSize = view.frame.size;
//        self.view.loadingManager = manager;
//        self.view.gtLoadingStyle = GTLoadingStatusStyleReView;
//    });
    
    
}

- (void)customButtonClick{
    [[[UIAlertView alloc] initWithTitle:@"订制的view" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

@end
