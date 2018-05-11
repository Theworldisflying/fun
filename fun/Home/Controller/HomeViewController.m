//
//  HomeViewController.m
//  fun
//
//  Created by 123 on 2018/5/11.
//  Copyright © 2018年 123. All rights reserved.
//http://route.showapi.com/341-1?showapi_appid=64648&showapi_sign=6b0b01cb2feb465ab842b693d1fae670&page=1&maxResult=10

#import "HomeViewController.h"
#import "UIBarButtonItem+XYMenu.h"

@interface HomeViewController ()
@property(strong,nonatomic) NSArray * dayArr;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    self.dayArr = @[@"7天内", @"30天内", @"一年内", @"所有"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.dayArr[0] style:UIBarButtonItemStylePlain target:self action:@selector(right:)];
}
-(void)right:(UIBarButtonItem*)item{
    NSArray *imgArr = @[@"clock", @"clock", @"clock", @"clock"];
    [item xy_showMenuWithImages:imgArr titles:_dayArr menuType:XYMenuRightNavBar currentNavVC:self.navigationController withItemClickIndex:^(NSInteger index) {
        NSLog(@"index==%ld",index);
        
       
        
    }];
}

-(void)setNav{
   
    
    self.navigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.navigationController.view.layer.shadowOffset = CGSizeMake(-10, 0);
    self.navigationController.view.layer.shadowOpacity = 0.15;
    self.navigationController.view.layer.shadowRadius = 10;
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
