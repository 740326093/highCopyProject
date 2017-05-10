//
//  XHQForumAllViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQForumAllViewController.h"


#import "XHQForumAllTableViewCell.h"

#import "XHQDaoGoDescViewController.h"

#import "XHQFoundDescViewController.h"

@interface XHQForumAllViewController ()<UITableViewDataSource,UITableViewDelegate>



@property(nonatomic,strong)UITableView *tableView;



@end

@implementation XHQForumAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
       
    [self GetGata];
    
    
}

#pragma mark -- tableview的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHQForumAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
   
    XHQForumAllModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    XHQFoundDescViewController *desc = [[XHQFoundDescViewController alloc]init];
        XHQForumAllModel *model = self.dataSource[indexPath.row];
        desc.url = model.uri;
        desc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:desc animated:YES];
        
        
    
}
#pragma mark -- 懒加载 --
- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 168;
       
        UINib *nib = [UINib nibWithNibName:@"XHQForumAllTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"CELL"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)GetGata
{
    [self request:@"GET" url:MADINGDB9 para:nil];
}
- (void)parserData:(id)data


{
    
    NSArray *array = data[@"topicList"];
    for(NSDictionary *dict in array)
    {
        XHQForumAllModel *model = [[XHQForumAllModel alloc]initWithDictionary:dict error:nil];
        [self.dataSource addObject:model];
        
    }
     
    [self.tableView reloadData];
       
}




@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com