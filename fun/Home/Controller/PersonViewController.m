//
//  PersonViewController.m
//  fun
//
//  Created by 123 on 2018/5/15.
//  Copyright © 2018年 123. All rights reserved.
//

#import "PersonViewController.h"
#import "CleanCache.h"

#import "AboutViewController.h"
#import "SetFontViewController.h"
@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView * tableView;

@property (strong,nonatomic) NSMutableArray * getDataArr;

@property (strong,nonatomic) NSMutableArray * versionArr;

@property (strong,nonatomic) NSMutableArray * cleanArr;

@property (strong,nonatomic) NSMutableArray * totalArr;

@property(strong,nonatomic) UILabel * cacheLabel;
@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _getDataArr = [[NSMutableArray alloc] initWithObjects:@"字体大小",@"关于我们", nil];
    _cleanArr = [[NSMutableArray alloc] initWithObjects:@"清除缓存", nil];
    
    _versionArr = [[NSMutableArray alloc] initWithObjects:@"当前版本", nil];
    _totalArr = [[NSMutableArray alloc] init];
    [_totalArr insertObject:_cleanArr atIndex:0];
    [_totalArr addObject:_getDataArr];
    [_totalArr addObject:_versionArr];
    
    
    
    [self setUI];
    
    
}

#pragma mark-UITableView
-(void)setTableView{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.cacheLabel.height+100+100, self.view.frame.size.width, self.view.frame.size.height-49-Width/3-100) style:UITableViewStyleGrouped];
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
    
//
//    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.cacheLabel);
//        make.top.equalTo(self.cacheLabel.mas_bottom).offset(100);
//        //        make.center.equalTo(self.cacheLabel.mas_bottom).offset(20);
//        make.width.mas_equalTo(Width);
//    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _totalArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _cleanArr.count;
    }else if(section == 1){
       return _getDataArr.count;
    }
    return _versionArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PersonCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0) {
            cell.textLabel.text = _cleanArr[indexPath.row];
//            cell.textLabel.textAlignment = []
        }else if(indexPath.section == 1){
            cell.textLabel.text = _getDataArr[indexPath.row];
        }else{
            cell.textLabel.text = _versionArr[indexPath.row];
            UILabel * label = [[UILabel alloc] init];
            label.textColor = [UIColor grayColor];
           // 获取当前版本号
            NSString *currentVerison = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
            label.text = [currentVerison stringByAppendingString:@".1.0.0"];
            label.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(100);
                      make.top.equalTo(cell).offset(5);
                
                        make.height.mas_equalTo(cell.height);
                make.width.mas_equalTo(100);
                    }];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.frame = CGRectMake((Width-50)/2, 200, 150, 150);
        hud.mode = MBProgressHUDModeDeterminate;
        hud.label.text = @"正在清除缓存...";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [CleanCache removeDirectoryPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]];
            [self.cacheLabel setText:@"0kb"];
            
            [hud hideAnimated:YES];
        });
       
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            SetFontViewController * setVC = [[SetFontViewController alloc] init];
            [self.navigationController pushViewController:setVC animated:YES];
        }else if(indexPath.row == 1){
            AboutViewController * aboutVC = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }else{
            
        }
    }else{
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 1)];
    header.opaque = YES;
    header.backgroundColor = [UIColor clearColor];
    
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        return 40;
//    }else if (section == 1){
//        return 40;
//    }
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footer = [[UIView alloc] init];
//    if (section == 0) {
        footer.frame = CGRectMake(0, 0, Width, 40);
//    }else{
//        footer.frame = CGRectMake(0, 0, Width, 1);
//    }
    
    footer.opaque = YES;
    footer.backgroundColor = [UIColor clearColor];
    
    return footer;
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
        if ([self cacheSizeStr:size] == nil || [[self cacheSizeStr:size] isEqualToString:@""]) {
            self.cacheLabel.text = [NSString stringWithFormat:@"0kb"];
        }else{
          self.cacheLabel.text = [NSString stringWithFormat:@"%@",[self cacheSizeStr:size]];
        }
        
    }];
    
    
    
    
    
    [self.view addSubview:_cacheLabel];
    
    
    [self setTableView];
  
//
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
////    [btn setImage:[UIImage imageNamed:@"message_videoPlay_33x33_@1x"] forState:UIControlStateNormal];
//    //    [btn setBackgroundImage:[UIImage imageNamed:@"message_videoPlay_33x33_@1x"] forState:UIControlStateNormal];
//    btn.layer.borderWidth = 2;
//    btn.layer.borderColor = [[UIColor blueColor] CGColor];
//    btn.layer.cornerRadius = 5;
//    btn.layer.masksToBounds = YES;
//    [btn setTitle:@"清除缓存" forState:UIControlStateNormal];
//    [btn setTintColor:[UIColor blackColor]];
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.cacheLabel);
//        make.top.equalTo(self.cacheLabel.mas_bottom).offset(100);
////        make.center.equalTo(self.cacheLabel.mas_bottom).offset(20);
//        make.width.mas_equalTo(Width/3);
//        make.height.mas_equalTo(40);
//    }];
    
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
