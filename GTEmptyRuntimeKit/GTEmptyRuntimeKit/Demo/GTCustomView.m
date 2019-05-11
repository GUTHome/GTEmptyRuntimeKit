//
//  GTCustomView.m
//  GTEmptyRuntimeKit
//
//  Created by cocomanber on 2019/5/11.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "GTCustomView.h"

@implementation GTCustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (CGSize)viewSize{
    return CGSizeMake(0, 300); //宽度不关心，还是按照scrollView为主
}

@end
