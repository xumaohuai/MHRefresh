//
//  ViewController.m
//  MHRefresh
//
//  Created by 徐茂怀 on 2018/4/18.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "ViewController.h"
#import "FirstController.h"
#import "SecondController.h"
@interface ViewController ()
@property(nonatomic,strong) NSArray *styleNameArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _styleNameArr = @[@"普通样式",@"头部视图样式"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
    cell.textLabel.text = _styleNameArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FirstController *vc = [[FirstController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        SecondController *vc = [[SecondController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
