//
//  GTLoadEmptyView.m
//  GTEmptyRuntimeKit
//
//  Created by cocomanber on 2019/5/11.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "GTLoadEmptyView.h"
#import <CoreText/CoreText.h>
#import "GTLoadConfiger.h"

@interface GTLoadEmptyView ()

@property (nonatomic, strong)GTLoadManager *manager;

@end

@implementation GTLoadEmptyView

- (instancetype)initWithFrame:(CGRect)frame withConfig:(GTLoadManager *)manager{
    self = [super initWithFrame:frame];
    if (self) {
        NSAssert(manager != nil, @"GTLoadEmptyView异常情况");
        self.manager = manager;
        
        // 创建
        self.backgroundColor = [GTLoadConfiger shareManager].backgroundColor;
        self.scrollView = [[UIScrollView alloc] init];
        if (@available(iOS 11, *)) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
        [self addSubview:self.scrollView];
        
        self.contentView = [[UIView alloc] init];
        self.contentView.backgroundColor = [GTLoadConfiger shareManager].backgroundColor;
        [self.scrollView addSubview:self.contentView];
        
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = [GTLoadConfiger shareManager].titleTextColor;
        self.titleLabel.font = [GTLoadConfiger shareManager].titleTextFont;
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.textColor = [GTLoadConfiger shareManager].contentTextColor;
        self.contentLabel.font = [GTLoadConfiger shareManager].contentTextFont;
        [self.contentView addSubview:self.contentLabel];
        
        self.actionButton = [[UIButton alloc] init];
        self.actionButton.contentEdgeInsets = [GTLoadConfiger shareManager].buttonEdgeInsets;
        self.actionButton.titleLabel.font = [GTLoadConfiger shareManager].buttonTextFont;
        [self.actionButton setTitleColor:[GTLoadConfiger shareManager].buttonTextColor forState:UIControlStateNormal];
        self.actionButton.layer.borderWidth = [GTLoadConfiger shareManager].buttonBorderWidth;
        self.actionButton.layer.borderColor = [GTLoadConfiger shareManager].buttonBorderColor.CGColor;
        [self.actionButton addTarget:self action:@selector(actionButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.actionButton];
        
        //loading
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.indicatorView.hidesWhenStopped = YES;
        [self.contentView addSubview:self.indicatorView];
        
        // 赋值，并控制是否可见
        [self setupSubvuews:manager];
    }
    return self;
}

- (void)setupSubvuews:(GTLoadManager *)manager{
    
    // 隐藏loading
    self.indicatorView.hidden = YES;
    UIImage *iconImage = nil;
    NSString *title = nil;
    NSString *content = nil;
    NSString *button = nil;
    
    GTLoadingStatusStyle style = manager.loadStyle;
    switch (style) {
        case GTLoadingStatusStyleNoData:
        case GTLoadingStatusStyleNetError:
            {
                iconImage = [manager imageOnStatus:style];
                title     = [manager titlrOnStatus:style];
                content   = [manager contentOnStatus:style];
                button    = [manager buttonOnStatus:style];
            }
            break;
        case GTLoadingStatusStyleLoading:
            {
                // nothings 都隐藏，只显示loading
                self.indicatorView.hidden = NO;
                [self.indicatorView startAnimating];
            }
            break;
        case GTLoadingStatusStyleOther:
            {
                iconImage = manager.statusImageData;
                title     = manager.statusTitleDesc;
                content   = manager.statusContentDesc;
                button    = manager.statusButtonDesc;
                
                manager.statusTitleColor ? self.titleLabel.textColor = manager.statusTitleColor : nil;
                
                manager.statusTitleFont ? self.titleLabel.font = manager.statusTitleFont : nil;
                
                manager.statusContentColor ? self.contentLabel.textColor = manager.statusContentColor : nil;
                manager.statusConetntFont ? self.contentLabel.font = manager.statusConetntFont : nil;
                
                manager.statusButtonFont ? self.actionButton.titleLabel.font = manager.statusButtonFont : nil;
                manager.statusButtonColor ? [self.actionButton setTitleColor:manager.statusButtonColor forState:UIControlStateNormal] : nil;
                self.actionButton.layer.borderWidth = manager.statusButtonBorderWidth ?: 0;
                self.actionButton.layer.borderColor = manager.statusButtonBorderColor.CGColor ?: [UIColor clearColor].CGColor;
            }
            break;
        case GTLoadingStatusStyleReView:
        {
            //展示一个全新的subview
            
        }
            break;
        default:
            break;
    }
    
    self.iconImageView.hidden = YES;
    if (iconImage) {
        self.iconImageView.image = iconImage;
        self.iconImageView.hidden = NO;
        [self.iconImageView sizeToFit];
    }
    
    self.titleLabel.hidden = YES;
    if (title) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.lineSpacing = 4.5;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSAttributedString *title_butedString = [[NSAttributedString alloc] initWithString:title attributes:@{
                                                                                                                  NSFontAttributeName: self.titleLabel.font,
                                                                                                                  NSForegroundColorAttributeName: self.titleLabel.textColor,
                                                                                                                  NSParagraphStyleAttributeName: paragraphStyle
                                                                                                                  }];
        self.titleLabel.attributedText = title_butedString;
        self.titleLabel.hidden = NO;
    }
    
    self.contentLabel.hidden = YES;
    if (content) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.lineSpacing = 4.5;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSAttributedString *content_butedString = [[NSAttributedString alloc] initWithString:content attributes:@{
                                                                                                  NSFontAttributeName: self.contentLabel.font,
                                                                                                  NSForegroundColorAttributeName: self.contentLabel.textColor,
                                                                                                  NSParagraphStyleAttributeName: paragraphStyle
                                                                                                  }];
        self.contentLabel.attributedText = content_butedString;
        self.contentLabel.hidden = NO;
    }
    
    self.actionButton.hidden = YES;
    if (button) {
        [self.actionButton setTitle:button forState:UIControlStateNormal];
        self.actionButton.hidden = NO;
        [self.actionButton sizeToFit];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    CGSize contentSize = [self sizeThatContentViewFits];
    CGSize contentViewSize = CGSizeMake(ceil(contentSize.width), ceil(contentSize.height));
    
    //loading情况
    if (contentViewSize.height == 0) {
        contentViewSize.height = CGRectGetHeight(self.indicatorView.bounds);
    }
    
    //resetView情况
    if (self.manager.loadStyle == GTLoadingStatusStyleReView) {
        contentViewSize.height = self.manager.resetViewSize.height;
    }
    
    // contentView 默认垂直居中于 scrollView
    CGFloat verticalOffset = [GTLoadConfiger shareManager].verticalOffset;
    self.contentView.frame = CGRectMake(0, CGRectGetMidY(self.scrollView.bounds) - contentViewSize.height / 2 + verticalOffset, contentViewSize.width, contentViewSize.height);
    
    // 设置scrollView
    CGFloat scrollView_w = fmax(CGRectGetWidth(self.scrollView.bounds) -self.scrollView.contentInset.left -self.scrollView.contentInset.right, contentViewSize.width);
    CGFloat scrollView_h = fmax(CGRectGetHeight(self.scrollView.bounds) -self.scrollView.contentInset.top -self.scrollView.contentInset.bottom, CGRectGetMaxY(self.contentView.frame));
    self.scrollView.contentSize = CGSizeMake(scrollView_w, scrollView_h);
    
    //resetView情况
    if (self.manager.loadStyle == GTLoadingStatusStyleReView) {
        [self.contentView addSubview:self.manager.resetView];
        self.manager.resetView.frame = self.contentView.bounds;
    }
    
    CGFloat originY = 0;
    CGFloat resultWidth = contentViewSize.width;
    if (!self.iconImageView.isHidden) {
        
        CGRect rect = self.iconImageView.frame;
        rect.origin.x = (resultWidth - CGRectGetWidth(self.iconImageView.frame)) / 2.0;
        self.iconImageView.frame = rect;
        originY = CGRectGetMaxY(self.iconImageView.frame);
    }
    
    if (!self.titleLabel.isHidden) {
        
        CGRect rect = self.titleLabel.frame;
        rect.origin.x = (resultWidth - CGRectGetWidth(self.titleLabel.frame)) / 2.0;
        rect.origin.y = originY + (self.iconImageView.isHidden?0:[GTLoadConfiger shareManager].titleOffset);
        self.titleLabel.frame = rect;
        originY = CGRectGetMaxY(self.titleLabel.frame);
    }
    
    if (!self.contentLabel.isHidden) {
        
        CGRect rect = self.contentLabel.frame;
        rect.origin.x = (resultWidth - CGRectGetWidth(self.contentLabel.frame)) / 2.0;
        rect.origin.y = originY + ((!self.iconImageView.isHidden || !self.titleLabel.isHidden)?[GTLoadConfiger shareManager].contentOffset:0);
        self.contentLabel.frame = rect;
        originY = CGRectGetMaxY(self.contentLabel.frame);
    }
    
    if (!self.actionButton.hidden) {
       
        CGRect rect = self.actionButton.frame;
        rect.origin.x = (resultWidth - CGRectGetWidth(self.actionButton.frame)) / 2.0;
        rect.origin.y = originY + ((!self.iconImageView.isHidden || !self.titleLabel.isHidden || !self.contentLabel.isHidden)?[GTLoadConfiger shareManager].buttonOffset:0);
        self.actionButton.frame = rect;
        originY = CGRectGetMaxY(self.actionButton.frame);
        self.actionButton.layer.cornerRadius = self.actionButton.frame.size.height / 2.0;
    }
    
    if (!self.indicatorView.isHidden) {
        
        CGRect rect = self.indicatorView.frame;
        rect.origin.x = (resultWidth - CGRectGetWidth(self.indicatorView.frame)) / 2.0;
        rect.origin.y = 0;
        self.indicatorView.frame = rect;
        originY = CGRectGetMaxY(self.iconImageView.frame);
    }
    
}


- (CGSize)sizeThatContentViewFits{
    
    // 内容的规定宽度
    CGFloat resultWidth = CGRectGetWidth(self.scrollView.bounds) - self.scrollView.contentInset.left - self.scrollView.contentInset.right;
    
    CGFloat imageViewHeight = [self.iconImageView sizeThatFits:CGSizeMake(resultWidth, CGFLOAT_MAX)].height;
    imageViewHeight = ceil(imageViewHeight);
    
    CGFloat titleHeight = [self getTextHeightWithStr:self.titleLabel.text withWidth:resultWidth withLineSpacing:4.5 withFont:self.titleLabel.font];
    titleHeight = ceil(titleHeight);
    
    CGFloat contentHeight = [self getTextHeightWithStr:self.contentLabel.text withWidth:resultWidth withLineSpacing:4.5 withFont:self.contentLabel.font];
    contentHeight = ceil(contentHeight);
    
    CGFloat actionButtonHeight = [self.actionButton sizeThatFits:CGSizeMake(resultWidth, CGFLOAT_MAX)].height;
    actionButtonHeight = ceil(actionButtonHeight);
    
    CGFloat resultHeight = 0;
    if (!self.iconImageView.isHidden) {
        resultHeight += imageViewHeight;
    }
    if (!self.titleLabel.isHidden) {
        
        CGRect rect = self.titleLabel.frame;
        rect.size.width = resultWidth;
        rect.size.height = titleHeight;
        self.titleLabel.frame = rect;
        
        resultHeight += titleHeight;
    }
    if (!self.contentLabel.hidden) {
        
        CGRect rect = self.contentLabel.frame;
        rect.size.width = resultWidth;
        rect.size.height = contentHeight;
        self.contentLabel.frame = rect;
        
        resultHeight += contentHeight;
    }
    
    if (!self.actionButton.isHidden) {
        resultHeight += actionButtonHeight;
    }
    
    if (!self.titleLabel.isHidden && !self.iconImageView.isHidden) {
        resultHeight += [GTLoadConfiger shareManager].titleOffset;
    }
    
    if (!self.contentLabel.isHidden) {
        if (!self.iconImageView.isHidden || !self.titleLabel.isHidden) {
            resultHeight += [GTLoadConfiger shareManager].contentOffset;
        }
    }

    if (!self.actionButton.isHidden) {
        if (!self.iconImageView.isHidden || !self.titleLabel.isHidden || !self.contentLabel.isHidden) {
            resultHeight += [GTLoadConfiger shareManager].buttonOffset;
        }
    }
    
    return CGSizeMake(resultWidth, resultHeight);
}

/// 回调
- (void)actionButtonClick{
    if (self.manager.netErrorReloadBlock) {
        self.manager.netErrorReloadBlock();
    }
}

#pragma mark - 计算高度

/**
 计算文本高度
 
 @param str         文本内容
 @param width       lab宽度
 @param lineSpacing 行间距(没有行间距就传0)
 @param font        文本字体
 
 @return 文本高度
 */
- (CGFloat)getTextHeightWithStr:(NSString *)str
                     withWidth:(CGFloat)width
               withLineSpacing:(CGFloat)lineSpacing
                      withFont:(UIFont *)font
{
    if (!str || str.length == 0) {
        return 0;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
    paraStyle.lineSpacing = lineSpacing;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:str
                                                                                       attributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:font}];
    
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                context:nil];
    
    if ((rect.size.height - font.lineHeight)  <= lineSpacing){
        if ([self containChinese:str]){
            rect.size.height -= lineSpacing;
        }
    }
    return rect.size.height;
}
//判断是否包含中文
- (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

@end
