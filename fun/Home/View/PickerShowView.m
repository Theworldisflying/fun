//
//  PickerShowView.m
//  fun
//
//  Created by 123 on 2018/5/15.
//  Copyright © 2018年 123. All rights reserved.
//

#import "PickerShowView.h"
#import <WebKit/WebKit.h>

@implementation PickerShowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setImageView:(NSString*)url{
    
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = @"Loading...";
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        
      
        //读取gif图片数据
        NSData *gifData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        //UIWebView生成
        dispatch_async(dispatch_get_main_queue(), ^{
            WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 70, Width, Height-49-70)];
            [webView loadData:gifData MIMEType:@"image/gif" characterEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
            webView.userInteractionEnabled = NO;
            [self addSubview:webView];
            
            
            [hud hideAnimated:YES];
        });
       
    });
    
    
  
    
   
    
}


@end
