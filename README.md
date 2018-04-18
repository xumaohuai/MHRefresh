# MHRefresh
效果图:
![](https://github.com/xumaohuai/MHRefresh/blob/master/MHRefresh/%E4%B8%8B%E6%8B%892.gif)![](https://github.com/xumaohuai/MHRefresh/blob/master/MHRefresh/%E4%B8%8B%E6%8B%891.gif)
使用方法
```
_refreshHeader = [MHRefreshHeader refreshWithScroll:_tableView];
__weak typeof(self) weakSelf = self;
    [_refreshHeader setRefreshingBlock:^{
       //获取数据
       [weakSelf.refreshHeader endRefreshing];//结束刷新
    }];

```
