
//  MyContentViewController.m
//  fun
//
//  Created by 123 on 2018/5/14.
//  Copyright © 2018年 123. All rights reserved.
//FLAnimatedImage

#import "MygifImageViewController.h"
#import "TextModel.h"
#import "JokesModel.h"
#import "GifModel.h"
#import "GifCell.h"


@interface MygifImageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) UITableView * tableView;
@property(strong,nonatomic) NSMutableArray * dataArr;
@property NSInteger page;

@end

@implementation MygifImageViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.page = 0;
    [self setTableView];
    [self setupRefresh];
    
    
}
-(void)setTableView{
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, Width, Height-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    // iOS11适配
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    //注册
    //    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JokesCell class]) bundle:nil] forCellReuseIdentifier:@"commintCell"];
    //    [self.tableView registerClass:[JokesCell class] forCellReuseIdentifier:@"commintCell"];
    //    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JokesCell class]) bundle:nil] forCellReuseIdentifier:@"commintCell"];
    [self.view addSubview:_tableView];
}
//添加刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //    /自动更改透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //一进入就刷新
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    //    self.tableView.mj_footer.hidden = YES;
    
    
}


-(void)loadNewTopics{
    
    
    [self getData];
}
-(void)loadMoreComments{
    
    
    GifModel * getmodel = self.dataArr[_dataArr.count-1];
    
    NSMutableDictionary * para = [[NSMutableDictionary alloc] init];
    para[@"apiver"] = @10901;
    para[@"category"] = @"weibo_pics";
    para[@"page"] = @(-1);
    para[@"page_size"] = @(30);
    para[@"max_timestamp"] = getmodel.update_time;
    para[@"atest_viewed_ts"] = @(-1);
    
    [AFNManager getWithUrlString:GifUrl parameter:para success:^(id data){
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //        NSLog(@"===1===%@",dic);
        [self.tableView.mj_footer endRefreshing];
        //        NSLog(@"===1===%@",dic);
        
        //        NSDictionary * getbody = dic[@"showapi_res_body"];
        NSArray * arr = [GifModel mj_objectArrayWithKeyValuesArray:dic[@"items"]];
        
        [self.dataArr addObjectsFromArray:arr];
        [self.tableView reloadData];
        
        if (dic != nil) {
          self.page += 1;
        }
        
        
        
    } failure:^(NSError *error){
        [self.tableView.mj_footer endRefreshing];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",error] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action){}];
        [alert addAction:sure];
        [self presentViewController:alert animated:true completion:nil];
    }];
}
#pragma mark-网络请求
-(void)getData{
//    http://lunchsoft.com/weibofun/weibo_list.php?apiver=10901&category=weibo_pics&page=-1&page_size=30
    NSMutableDictionary * para1 = [[NSMutableDictionary alloc] init];
    para1[@"apiver"] = @10901;
    para1[@"category"] = @"weibo_pics";
    para1[@"page"] = @(-1);
    para1[@"page_size"] = @(30);
//    para1[@"ax_timestamp"] = @(-1);
//    para1[@"atest_viewed_ts"] = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    
    [AFNManager getWithUrlString:GifUrl parameter:para1 success:^(id data){
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //        NSLog(@"===1===%@",dic);
        [self.tableView.mj_header endRefreshing];
        //        NSLog(@"===1===%@",dic);
        
        //        NSDictionary * getbody = dic[@"showapi_res_body"];
        NSArray * arr = [GifModel mj_objectArrayWithKeyValuesArray:dic[@"items"]];
        
        self.dataArr = [NSMutableArray arrayWithArray:arr];
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        
    } failure:^(NSError *error){
        [self.tableView.mj_header endRefreshing];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",error] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action){}];
        [alert addAction:sure];
        [self presentViewController:alert animated:true completion:nil];
    }];
   
    //    [request GET:JokesUrl parameters:para progress:^(NSProgress*progress){} success:^(NSURLSessionDataTask * data,id n){
    //        NSLog(@"===%@",data);
    //        NSLog(@"==%@===",n);
    //
    //
    //    } failure:^(NSURLSessionDataTask * data,NSError * error){
    //
    //        NSLog(@"%@",error);
    //
    //    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    GifCell * cell = [[GifCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"gifCell"];
    [cell loadData:_dataArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GifModel * model = _dataArr[indexPath.row];
//    if ([model.is_gif isEqualToString:@"0"]) {
//        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width -4 *10, MAXFLOAT);
//        //    CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
//        //计算文字高度
//        CGFloat textH = [model.wbody boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]} context:nil].size.height;
//        
//        return [GetUrlImageSize getImageSizeWithURL:model.wpic_large].height + 10 + textH;
//    }
  
    
    return model.cellHeight + 10;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    UIViewController *vc = [[UIViewController alloc] init];
    //    vc.view.backgroundColor = [UIColor whiteColor];
    //    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
