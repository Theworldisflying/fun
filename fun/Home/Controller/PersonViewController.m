//
//  PersonViewController.m
//  fun
//
//  Created by 123 on 2018/5/15.
//  Copyright © 2018年 123. All rights reserved.
//

#import "PersonViewController.h"
#import "CleanCache.h"

@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView * tableView;

@property (strong,nonatomic) NSMutableArray * getDataArr;

@property (strong,nonatomic) NSMutableArray * cleanArr;

@property (strong,nonatomic) NSMutableArray * totalArr;

@property(strong,nonatomic) UILabel * cacheLabel;
@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _getDataArr = [[NSMutableArray alloc] initWithObjects:@"1", nil];
    _cleanArr = [[NSMutableArray alloc] initWithObjects:@"清除缓存", nil];
    _totalArr = [[NSMutableArray alloc] init];
    [_totalArr insertObject:_cleanArr atIndex:0];
    [_totalArr addObject:_getDataArr];
    
    
    
    [self setUI];
}

#pragma mark-UITableView
-(void)setTableView{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.estimatedRowHeight = 60;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.scrollEnabled = NO;
    //    [tableView registerClass:[HistoryTableViewCell class] forCellReuseIdentifier:TableCellId];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cacheLabel);
        make.top.equalTo(self.cacheLabel.mas_bottom).offset(100);
        //        make.center.equalTo(self.cacheLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _totalArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _getDataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PersonCell"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    self.tableView.contentSize = CGSizeMake(0, Height*1.5);
}

#pragma mark--UI
-(void)setUI{
    
    
    
    
    
    self.cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width/3, 100, Width/3, Width/3)];
    _cacheLabel.layer.borderWidth = 5;
    _cacheLabel.layer.borderColor = [[UIColor grayColor] CGColor];
    _cacheLabel.layer.cornerRadius = Width/3/2;
    _cacheLabel.layer.masksToBounds = YES;
    [self setLabel:_cacheLabel font:16 txtColor:[UIColor blackColor]];
    self.cacheLabel.font = [UIFont boldSystemFontOfSize:20];
    
    
    
    [CleanCache getFileSize:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] completion:^(NSInteger size){
        self.cacheLabel.text = [NSString stringWithFormat:@"%@",[self cacheSizeStr:size]];
    }];
    
    
    
    
    
    [self.view addSubview:_cacheLabel];
    
    
    
  

    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [btn setImage:[UIImage imageNamed:@"message_videoPlay_33x33_@1x"] forState:UIControlStateNormal];
    //    [btn setBackgroundImage:[UIImage imageNamed:@"message_videoPlay_33x33_@1x"] forState:UIControlStateNormal];
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = [[UIColor blueColor] CGColor];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"清除缓存" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor blackColor]];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cacheLabel);
        make.top.equalTo(self.cacheLabel.mas_bottom).offset(100);
//        make.center.equalTo(self.cacheLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    
}
-(void)btnClick{
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",@"清除所"] preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction*action){}];
//    [alert addAction:cancel];
//    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action){
    
        [CleanCache removeDirectoryPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]];
        [self.cacheLabel setText:@"0kb"];
        
        
//    }];
//    [alert addAction:sure];
//    [self presentViewController:alert animated:true completion:nil];
}


-(void)setLabel:(UILabel*)label font:(CGFloat)font txtColor:(UIColor*)color{
    label.font = [UIFont systemFontOfSize:font];
    [label setTextColor:color];
    label.backgroundColor = [UIColor clearColor];
    label.adjustsFontSizeToFitWidth = true;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
}

- (NSString *)cacheSizeStr:(NSInteger)size {
    NSInteger totalSize = size;
    NSString *sizeStr = @"";
    if (totalSize > 1000 * 1000) {
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%.1fMB",  sizeF];
    } else if (totalSize > 1000) {
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%.1fKB",  sizeF];
    } else if (totalSize > 0) {
        sizeStr = [NSString stringWithFormat:@"%.ldB", totalSize];
    }
    return sizeStr;
}
@end
