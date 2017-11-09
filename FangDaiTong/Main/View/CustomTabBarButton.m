//
//  CustomTabBarButton.m
//  Store
//
//  Created by lijun on 14/11/9.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "CustomTabBarButton.h"
#import "YSBadgeButton.h"

// 图标的比例
#define YSTabBarButtonImageRatio 0.6
// 按钮的默认文字颜色
#define  YSTabBarButtonTitleColor [UIColor colorWithHex:@"#bbbbbb"]
// 按钮的选中文字颜色
#define  YSTabBarButtonTitleSelectedColor [UIColor colorWithHex:@"#5695f0"]

@interface CustomTabBarButton()

@property (nonatomic, weak) YSBadgeButton *badgeButton;

@end

@implementation CustomTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 图标居中
        self.imageView.contentMode = UIViewContentModeBottom;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:9.0f];
        // 文字颜色
        
        [self setTitleColor:YSTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:YSTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
        
        // 添加一个提醒数字按钮
        YSBadgeButton *badgeButton = [[YSBadgeButton alloc] init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}

// 设置item
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // KVO 监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * YSTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * YSTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

/** 监听到badgeValue属性改变，就会调用*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    // 设置提醒数字的位置
    CGFloat badgeY = 1;
    CGFloat badgeX = 48;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
}


@end
