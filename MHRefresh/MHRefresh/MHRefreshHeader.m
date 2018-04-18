//
//  MHRefreshHeader.m
//  MHRefresh
//
//  Created by 徐茂怀 on 2018/4/18.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MHRefreshHeader.h"
#import "UIView+Additions.h"
static const CGFloat RefreshMinY = - 64.f;

NSString *const BaseRefreshViewObserveKeyPath = @"contentOffset";
@implementation MHRefreshHeader

//使点击穿透
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return nil;
}
+(instancetype)refreshWithScroll:(UIScrollView *)scrollView
{
    MHRefreshHeader *header = [MHRefreshHeader new];
    header.centerX = scrollView.centerX;
    header.y = scrollView.y;
    header.scrollView = scrollView;
    [scrollView.superview addSubview:header];
    return header;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    //添加监听
    [scrollView addObserver:self forKeyPath:BaseRefreshViewObserveKeyPath options:NSKeyValueObservingOptionNew context:nil];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self.scrollView removeObserver:self forKeyPath:BaseRefreshViewObserveKeyPath];
    }
}

-(void)endRefreshing
{
    self.refreshState = MHRefreshStateEndRresh;
}
//初始化图片
- (void)setupView
{
    self.backgroundColor = [UIColor clearColor];
    _refreshImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_1"]];
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i < 6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%zd", i]];
        [refreshingImages addObject:image];
    }
    _refreshImageView.animationImages = refreshingImages;
    self.bounds = _refreshImageView.bounds;
    [self addSubview:_refreshImageView];
    _refreshImageView.alpha = 0;
    self.refreshState = MHRefreshStateNormal;
}
//刷新状态改变
- (void)setRefreshState:(MHRefreshViewState)refreshState
{
    
    if (refreshState == MHRefreshStateRefreshing) {
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
        [_refreshImageView startAnimating];
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        }];
    } else if (refreshState == MHRefreshStateNormal) {
        if (_refreshImageView.isAnimating) {
            [_refreshImageView stopAnimating];
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }else if (refreshState == MHRefreshStateEndRresh){
        if (_refreshImageView.isAnimating) {
            [_refreshImageView stopAnimating];
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            }];
        }
    }
}

//改变透明度
-(void)setPullingPercent:(CGFloat)percent
{
    _refreshImageView.alpha = percent;
}

//滑动处理
- (void)updateRefreshHeaderWithOffsetY:(CGFloat)y
{
    if (y > 0) {//防止往上划的时候动图显示出来
        return;
    }
    [self setPullingPercent:(fabs(y) - 20) / (fabs(RefreshMinY) - 20)];
    if (self.refreshState == MHRefreshStateRefreshing) {
        return;
    }
    if (y < RefreshMinY) {
        if(!self.scrollView.isDragging ){
            self.refreshState = MHRefreshStateRefreshing;
        }
    }else{
        if (self.refreshState == MHRefreshStateNormal) {
            return;
        }
        self.refreshState = MHRefreshStateNormal;
    }
    
}
//监听滑动
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (keyPath != BaseRefreshViewObserveKeyPath) return;
    
    [self updateRefreshHeaderWithOffsetY:self.scrollView.contentOffset.y];
}

@end
