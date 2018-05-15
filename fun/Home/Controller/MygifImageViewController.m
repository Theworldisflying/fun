
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
    
    self.page = 1;
    [self setTableView];
    [self setupRefresh];
    
    
}
-(void)setTableView{
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, Width, Height-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.estimatedRowHeight = 60;
    _tableView.rowHeight = UITableViewAutomaticDimension;
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
    _tableView.estimatedRowHeight = 300;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    //一进入就刷新
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
//    self.tableView.mj_footer.hidden = YES;
    
    
}


-(void)loadNewTopics{
    
    
    [self getData];
}
-(void)loadMoreComments{
    self.page += 1;
    NSMutableDictionary * para = [[NSMutableDictionary alloc] init];
    para[@"showapi_appid"] = @(64648);
    para[@"showapi_sign"] = Assin;
    para[@"page"] = @(_page);
    para[@"maxResult"] = @(10);
    
    
    [AFNManager postWithUrlString:GifUrl parameters:para success:^(id data){
        
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"===1===%@",dic);
        [self.tableView.mj_footer endRefreshing];
        NSDictionary * getbody = dic[@"showapi_res_body"];
        NSArray * arr = [GifModel mj_objectArrayWithKeyValuesArray:getbody[@"contentlist"]];
        
//        self.dataArr = [NSMutableArray arrayWithCapacity:30];
        [self.dataArr addObjectsFromArray:arr];
        [self.tableView reloadData];
        
        
        
    } failure:^(NSError * error){
        [self.tableView.mj_footer endRefreshing];
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",error] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action){}];
        [alert addAction:sure];
        [self presentViewController:alert animated:true completion:nil];
    }];
}
#pragma mark-网络请求
-(void)getData{
    
    //http://route.showapi.com/341-1?showapi_appid=64648&showapi_sign=6b0b01cb2feb465ab842b693d1fae670&page=1&maxResult=10
    //    NetWorkingManager * request = [NetWorkingManager shareManager];
    NSMutableDictionary * para = [[NSMutableDictionary alloc] init];
    para[@"showapi_appid"] = @(64648);
    para[@"showapi_sign"] = Assin;
    para[@"page"] = @(1);
    para[@"maxResult"] = @(10);
    
    
    [AFNManager postWithUrlString:GifUrl parameters:para success:^(id data){
       [self.tableView.mj_header endRefreshing];
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"===1===%@",dic);
        
        NSDictionary * getbody = dic[@"showapi_res_body"];
        NSArray * arr = [GifModel mj_objectArrayWithKeyValuesArray:getbody[@"contentlist"]];
        
        self.dataArr = [NSMutableArray arrayWithArray:arr];
        [self.tableView reloadData];
        
       
        
    } failure:^(NSError * error){
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
    
    
    
    GifCell * cell = [[GifCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"commintCell"];
    [cell loadData:_dataArr[indexPath.row]];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

//    GifModel * model = _dataArr[indexPath.row];

//      dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)

//    return [GetUrlImageSize getImageSizeWithURL:model.img].height + 30;

    return 350;
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end