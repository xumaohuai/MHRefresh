//
//  MHRefreshHeader.h
//  MHRefresh
//
//  Created by 徐茂怀 on 2018/4/18.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString *const BaseRefreshViewObserveKeyPath;
typedef enum {
    MHRefreshStateNormal,//闲置状态
    MHRefreshStateRefreshing,//正在刷新
    MHRefreshStateEndRresh,//结束刷新
} MHRefreshViewState;
@interface MHRefreshHeader : UIView
@property (nonatomic, copy) void(^refreshingBlock)(void);
@property(nonatomic,strong) UIImageView *refreshImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) MHRefreshViewState refreshState;

- (void)endRefreshing;
+(instancetype)refreshWithScroll:(UIScrollView *)scrollView;
@end
