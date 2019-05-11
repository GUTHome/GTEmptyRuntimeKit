//
//  GTCustomView.h
//  GTEmptyRuntimeKit
//
//  Created by cocomanber on 2019/5/11.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTCustomView : UIView

@property (weak, nonatomic) IBOutlet UIButton *customButton;

+ (CGSize)viewSize;

@end

NS_ASSUME_NONNULL_END
