//
//  FirstController.m
//  MHRefresh
//
//  Created by 徐茂怀 on 2018/4/18.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "FirstController.h"
#import "MHRefreshHeader.h"
#import "UIView+Additions.h"
@interface FirstController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) MHRefreshHeader *refreshHeader;
@end

@implementation FirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"普通样式";
    self.navigationController.navigationBar.translucent = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    _refreshHeader = [MHRefreshHeader refreshWithScroll:_tableView];
    __weak typeof(self) weakSelf = self;
    [_refreshHeader setRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.refreshHeader endRefreshing];
        });
    }];
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
    NSLog(@"%.2f",scrollView.contentOffset.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
