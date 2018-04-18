# MHRefresh
      
使用方法
```
_refreshHeader = [MHRefreshHeader refreshWithScroll:_tableView];
__weak typeof(self) weakSelf = self;
    [_refreshHeader setRefreshingBlock:^{
       //获取数据
       [weakSelf.refreshHeader endRefreshing];//结束刷新
    }];

```
