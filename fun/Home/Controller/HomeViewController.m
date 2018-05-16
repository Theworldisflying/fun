//
//  HomeViewController.m
//  fun
//
//  Created by 123 on 2018/5/11.
//  Copyright © 2018年 123. All rights reserved.
//http://route.showapi.com/341-1?showapi_appid=64648&showapi_sign=6b0b01cb2feb465ab842b693d1fae670&page=1&maxResult=10

#import "HomeViewController.h"
#import "UIBarButtonItem+XYMenu.h"


#import "MyContentViewController.h"
#import "MyImageViewController.h"
#import "MygifImageViewController.h"

#import "PersonViewController.h"

@interface HomeViewController ()
{
    NSArray *list;
}
@property(strong,nonatomic) NSArray * dayArr;



@property(strong,nonatomic) CBSSegmentViewController * segment;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"个人中心" style:UIBarButtonItemStylePlain target:self action:@selector(right:)];
    
   
    
//    self.segment = [[CBSSegmentViewController alloc] init];
    
    
    
//    [self segmentStyle0];
    
    
    
    //设置各个标签名字
    self.cbs_titleArray = @[@"段子",
                            @"图片",
                            @"趣图"];
    //设置各个标签对应的ViewController，如果数量不对会崩溃
    self.cbs_viewArray = @[@"MyContentViewController", @"MyImageViewController", @"MygifImageViewController"];
    self.cbs_Type = CBSSegmentHeaderTypeScroll;
    self.cbs_headerColor = [UIColor grayColor];
    self.cbs_buttonHeight = 50;
    //先设置cbs_titleArray和cbs_viewArray再调用initSegment
    [self initSegment];
    
    
    
}
-(void)right:(UIBarButtonItem*)item{

    PersonViewController * person = [[PersonViewController alloc] init];
    [self.navigationController pushViewController:person animated:YES];
}

-(void)setNav{
   
    
    self.navigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.navigationController.view.layer.shadowOffset = CGSizeMake(-10, 0);
    self.navigationController.view.layer.shadowOpacity = 0.15;
    self.navigationController.view.layer.shadowRadius = 10;
}



#pragma mark - 数据源
- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];
//    for (NSInteger i = 0; i < count; i++) {
//        
//    }
    MyContentViewController *vc = [[MyContentViewController alloc] init];
//    vc.index = i;
    [arr addObject:vc];
    MyImageViewController * imagevc = [[MyImageViewController alloc] init];
//    vc.index = i;
    [arr addObject:imagevc];
    MygifImageViewController *gifvc = [MygifImageViewController new];
//    vc.index = i;
    [arr addObject:gifvc];
    return arr;
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
