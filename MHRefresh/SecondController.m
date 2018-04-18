//
//  SecondController.m
//  MHRefresh
//
//  Created by 徐茂怀 on 2018/4/18.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "SecondController.h"
#import "MHRefreshHeader.h"
#import "UIView+Additions.h"
@interface SecondController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableview;
@property(nonatomic,strong) MHRefreshHeader *refreshHeader;
@property(nonatomic,strong) UIImageView *barImageView;
@property (nonatomic, strong) UIImageView * headerView;
@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.tableview.tableHeaderView = self.headerView;
    _barImageView = self.navigationController.navigationBar.subviews.firstObject;
    _refreshHeader = [MHRefreshHeader refreshWithScroll:self.tableview];
    __weak typeof(self) weakSelf = self;
    [_refreshHeader setRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.refreshHeader endRefreshing];
        });
    }];
}


-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:_tableview];
        _tableview.showsHorizontalScrollIndicator = YES;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = [UIColor colorWithRed:0.86 green:0.89 blue:0.91 alpha:1];
    }
    return _tableview;
}
-(UIImageView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIImageView alloc] init];
        _headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250);
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
        _headerView.image = [UIImage imageNamed:@"girl"];
    }
    return _headerView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        CGFloat minAlphaOffset = 0;
        CGFloat maxAlphaOffset = 100;
        CGFloat offset = scrollView.contentOffset.y;
        CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
        _barImageView.alpha = alpha;
}

@end
