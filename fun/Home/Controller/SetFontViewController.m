//
//  SetFontViewController.m
//  fun
//
//  Created by 123 on 2018/5/17.
//  Copyright © 2018年 123. All rights reserved.
//

#import "SetFontViewController.h"
static float   changeFont  = 2;

@interface SetFontViewController ()

@property (nonatomic ,strong)UIButton *addButton;
@property (nonatomic ,strong)UIButton *reduceButton;

@property(nonatomic,strong) UILabel * label;

@end

@implementation SetFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"字体大小";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

-(void)setUI{
    
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(5, 200, Width-10, Height/2)];
    self.label.text = @"这是字体";
    self.label.font = Font(USERDEFAULT_float(CONTENT_FONT));
    _label.opaque = YES;
    _label.numberOfLines = 0;
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor blackColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.frame = CGRectMake(Width/4, Height-49-64-100, Width/4, 40);
    [self.addButton setTitle:@"字体变大" forState:UIControlStateNormal];
    [self.addButton setBackgroundColor:[UIColor redColor]];
    self.addButton.tag = 1;
//    self.addButton.titleLabel.font = Font(USERDEFAULT_float(CONTENT_FONT));
    [self.addButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
    
    
    self.reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reduceButton.frame = CGRectMake(Width/4*2+5, Height-49-64-100, Width/4, 40);
    [self.reduceButton setTitle:@"字体变小" forState:UIControlStateNormal];
    [self.reduceButton setBackgroundColor:[UIColor redColor]];
    self.reduceButton.tag = 2;
//    self.reduceButton.titleLabel.font = Font(USERDEFAULT_float(CONTENT_FONT));
    [self.reduceButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.reduceButton];
}

-(void)clickButton:(UIButton *)button{
    
  
    float contentFont = USERDEFAULT_float(CONTENT_FONT);
    
    if (button.tag==1) {
        
        if (contentFont > 30) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已是最大字体！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action){}];
            [alert addAction:sure];
            [self presentViewController:alert animated:true completion:nil];
        }else{
            contentFont +=changeFont;
            
            self.label.font = [UIFont systemFontOfSize:contentFont];
        }
        
        
    }
    else{
        if(contentFont < 13){
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已是最小字体！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action){}];
            [alert addAction:sure];
            [self presentViewController:alert animated:true completion:nil];
        }else{
            contentFont -=changeFont;
            self.label.font = [UIFont systemFontOfSize:contentFont];
        }
        
        
    }
    //保存
    NSUserDefaults *fontDefaults = [NSUserDefaults standardUserDefaults];
    //把所用的字体值保存下来
    [fontDefaults setFloat:contentFont forKey:CONTENT_FONT];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //发通知
    //发通知
    [[NSNotificationCenter defaultCenter]postNotificationName:ALL_FONT_CHANGE object:nil];
    
}

#pragma mark - 监听到字体改变
-(void)fontSizeChange{
    
    self.addButton.titleLabel.font = Font(USERDEFAULT_float(CONTENT_FONT));
    self.reduceButton.titleLabel.font = Font(USERDEFAULT_float(CONTENT_FONT));
    
    
    
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
