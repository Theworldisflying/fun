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

#import "ZRUploadProgressView.h"



@interface GifCell()
@property(strong,nonatomic) UILabel * titleLabel;
//@property(strong,nonatomic) UILabel  * urlLabel;


@property(strong,nonatomic) UIImageView * iamgeView;



@property(strong,nonatomic) ZRUploadProgressView *circle1;

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
        make.width.mas_equalTo(Width-5);
        
    }];

    
    
    self.iamgeView = [[UIImageView alloc] init];
    _iamgeView.contentMode = UIViewContentModeScaleAspectFill;
    
    _iamgeView.autoresizesSubviews = YES;
    
    _iamgeView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
  
    _iamgeView.userInteractionEnabled = YES;
    //    self.iamgeView.image
    [self addSubview:_iamgeView];
        [self.iamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(5);
            make.left.equalTo(self.titleLabel);
            make.width.mas_equalTo(Width);

        }];
    

    
    
}




-(void)loadData:(GifModel *)model{
    self.titleLabel.text = model.wbody;

  
    
//    self.urlLabel.text = model.img;
    if ([model.is_gif isEqualToString:@"1"]) {
        
        NSString * url;
        CGFloat w,h;
//        if ([model.wpic_m_height floatValue] == model.cellHeight) {
            url = model.wpic_large;
            w = [model.wpic_m_width floatValue];
            h = [model.wpic_m_height floatValue];
//        }else{
//            url = model.wpic_small;
//            w = [model.wpic_s_width floatValue];
//            h = [model.wpic_s_height floatValue];
//        }
        
        self.circle1 = [[ZRUploadProgressView alloc] initWithFrame:CGRectMake(Width/2-Width/4, 60, Width/4, Width/4)];
        self.circle1.progressColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.circle1.backgroundColor = [UIColor clearColor];
        self.circle1.completionBlock = ^{
            NSLog(@"uploadView - completion");
        };
        [self addSubview:self.circle1];
        [self.circle1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(Width/4);
            make.height.mas_equalTo(Width/4);
            
        }];

        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
        [downloader downloadImageWithURL:[NSURL URLWithString:url]
                                 options:0
                                progress:^(NSInteger receivedSize, NSInteger expectedSize,NSURL* url) {
                                   
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                     
                                        
                                         self.circle1.progress = (float)receivedSize/(float)expectedSize;
                                      
                                    });
                                   
                                    
                                    
                                   
                                }
                               completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                   if (image && finished) {
                                       [self.circle1 removeFromSuperview];
                                       FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
                                               FLAnimatedImageView*imageView = [[FLAnimatedImageView alloc] init];
                                               imageView.animatedImage = image;
                                               [self addSubview:imageView];
                                               [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                                                   make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
                                                   make.width.mas_equalTo(Width);
                                                   make.height.mas_equalTo(h);
                                               }];
                                 
                                   }
                               }];
        

    }else{
//        NSString * url;
//        if ([model.wpic_m_height floatValue] == model.cellHeight) {
//            url = model.wpic_large;
//        }else{
//            url = model.wpic_small;
//        }
        
       [self.iamgeView sd_setImageWithURL:[NSURL URLWithString:model.wpic_large] placeholderImage:[UIImage imageNamed:@"timg"]];
    }
    
    
    
    
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
