//
//  GifCell.m
//  fun
//
//  Created by 123 on 2018/5/15.
//  Copyright © 2018年 123. All rights reserved.
//

#import "GifCell.h"
#import "GifModel.h"


#import "FLAnimatedImage.h"

#import <WebKit/WebKit.h>

#import "PickerShowView.h"

@interface GifCell()
@property(strong,nonatomic) UILabel * titleLabel;
@property(strong,nonatomic) UILabel  * urlLabel;


@property(strong,nonatomic) UIImageView * iamgeView;


@property(strong,nonatomic) PickerShowView * gview;

@end
@implementation GifCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    
    return self;
}


- (void)prepareForReuse{
    [super prepareForReuse];
}

-(void)setUI{
    
    
    self.titleLabel = [[UILabel alloc] init];
    [self setLabel:_titleLabel font:16 txtColor:[UIColor blackColor]];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self addSubview:_titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(5);
        make.width.mas_equalTo(self.width-5);
        
    }];
    
    self.urlLabel = [[UILabel alloc] init];
    self.urlLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_urlLabel];
    
    
    self.iamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, Width, 350)];
    self.iamgeView.contentMode = UIViewContentModeScaleToFill;
    _iamgeView.userInteractionEnabled = YES;
    //    self.iamgeView.image
    [self addSubview:_iamgeView];
        [self.iamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(5);
            make.left.equalTo(self.titleLabel);
            make.width.mas_equalTo(Width);
    
        }];
    
    
    UIButton * btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"message_videoPlay_33x33_@1x"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"message_videoPlay_33x33_@1x"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.iamgeView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.iamgeView);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    
}

-(void)btnClick:(UIButton*)btn{
//    btn.hidden = YES;
    
//    NSLog(@"%@=====",self.urlLabel.text);
    
    NSString * url = self.urlLabel.text;
//        [self removeGif];
    
    
    
    
    
    
    
    PickerShowView * gview = [[PickerShowView alloc] initWithFrame:CGRectMake(0, 64, Width, Height)];
    gview.backgroundColor = [UIColor whiteColor];
    [gview setImageView:url];
    self.gview = gview;
    [[[UIApplication sharedApplication] keyWindow] addSubview:gview];
    
    
    UIButton * gbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [gbtn setImage:[UIImage imageNamed:@"navigationButtonReturn_15x21_"] forState:UIControlStateNormal];
    [gbtn addTarget:self action:@selector(gbtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [gview addSubview:gbtn];
    
    

    
//    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
//                    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
//                    imageView.animatedImage = image;
//                    imageView.frame = CGRectMake(0, 230, Width, 320);
//                    [gview addSubview:imageView];
//    //读取gif图片数据
//    NSData *gifData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//    //UIWebView生成
//    
//    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 70, Width, Height-49-70)];
////    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
//    [webView loadData:gifData MIMEType:@"image/gif" characterEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
//    webView.userInteractionEnabled = NO;
//    [gview addSubview:webView];
    
    
    
    


    
}
-(void)gbtnCLick{
    [self.gview removeFromSuperview];
}


-(void)loadData:(GifModel *)model{
    self.titleLabel.text = model.title;

  
    
    self.urlLabel.text = model.img;
    
    [self.iamgeView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"timg"]];
    
    
}


-(void)setLabel:(UILabel*)label font:(CGFloat)font txtColor:(UIColor*)color{
    label.font = [UIFont systemFontOfSize:font];
    [label setTextColor:color];
    label.backgroundColor = [UIColor clearColor];
    label.adjustsFontSizeToFitWidth = true;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
