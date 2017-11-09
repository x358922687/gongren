//
//  YSCollectionView.m
//  BankApp
//
//  Created by yhj on 17/4/13.
//  Copyright © 2017年 QDPCI. All rights reserved.
//

#import "YSCollectionView.h"
#import "YSNewsCell.h"
//#import "TopData.h"
#import "CustomPageControl.h"

// 每一组最大的行数
#define TotalRowsInSection (5000 * self.newsArr.count)
#define DefaultRow (NSUInteger)(TotalRowsInSection * 0.5)

@interface YSCollectionView() <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation YSCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(frame.size.width, frame.size.height)];//设置cell的尺寸
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//设置边界
        flowLayout.minimumLineSpacing = 0;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, frame.size.height) collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.pagingEnabled = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        [collectionView registerClass:[YSNewsCell class] forCellWithReuseIdentifier:@"news"];
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        
        CustomPageControl *pageControl = [CustomPageControl pageControlWithFrame:CGRectZero currentPageImage:[UIImage imageNamed:@"pageControl_currentImg"] indicatorImage:[UIImage imageNamed:@"page_indicator"]];
        self.pageControl = pageControl;
        [self addSubview:pageControl];
    }
    return self;
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(nextNews) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)setNewsArr:(NSArray *)newsArr
{
    _newsArr = newsArr;
    if (self.newsArr.count == 0) return;
    [self addTimer];
    if (newsArr.count == 1) {
        self.collectionView.scrollEnabled = NO;
        [self removeTimer];
    }
    CGFloat pageControlW = newsArr.count * 20;
    self.pageControl.frame = CGRectMake((self.width - pageControlW)*0.5, self.height - 30, pageControlW, 30);
    NSLog(@"%@-----",NSStringFromCGRect(self.pageControl.frame));
    NSLog(@"%@---",NSStringFromCGRect(self.frame));
    self.pageControl.numberOfPages = newsArr.count;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:DefaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}
- (void)nextNews
{
    NSIndexPath *visiablePath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    
    NSUInteger visiableItem = visiablePath.item;
    if ((visiablePath.item % self.newsArr.count)  == 0)
    { // 第0张图片
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:DefaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        visiableItem = DefaultRow;
    }
    
    NSUInteger nextItem = visiableItem + 1;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return TotalRowsInSection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"news";
    YSNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    long index = indexPath.item % self.newsArr.count;
//        TopData *data = self.newsArr[index];
//        cell.imgName = data.outerUrl;
    
     return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *visiablePath = [[collectionView indexPathsForVisibleItems] firstObject];
    self.pageControl.currentPage = visiablePath.item % self.newsArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    long index = indexPath.item % self.newsArr.count;
    NSString *indexStr = [NSString stringWithFormat:@"%ld",index];
    if (_selectBlock)
    {
        _selectBlock(indexStr);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self addTimer];
}

@end
