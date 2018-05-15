//
//  PictureCell.m
//  fun
//
//  Created by 123 on 2018/5/14.
//  Copyright © 2018年 123. All rights reserved.
//

#import "PictureCell.h"
#import "PictureModel.h"
#import "SDWebImageManager.h"


@interface PictureCell()
@property(strong,nonatomic) UILabel * stepLabel;
@property(strong,nonatomic) UILabel * walkStepLabel;
@property(strong,nonatomic) UILabel * dateLabel;


@property(strong,nonatomic) UIImageView * iamgeView;
@end

@implementation PictureCell

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
    
    
    self.stepLabel = [[UILabel alloc] init];
    [self setLabel:_stepLabel font:16 txtColor:[UIColor blackColor]];
    self.stepLabel.font = [UIFont boldSystemFontOfSize:20];
    [self addSubview:_stepLabel];
    
    [self.stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(5);
        make.width.mas_equalTo(self.width-5);
        
    }];
    
    
  
    
    self.iamgeView = [[UIImageView alloc] init];
    self.iamgeView.contentMode = UIViewContentModeScaleToFill;
//    self.iamgeView.image
    [self addSubview:_iamgeView];
    
    [self.iamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stepLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.stepLabel);
        make.width.mas_equalTo(Width-10);

    }];
    
    
}
-(void)loadData:(PictureModel *)model{
    self.stepLabel.text = model.title;
//    self.dateLabel.text = model.img;

    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.thumburl]];
//    SDWebImageManager * manager = [SDWebImageManager sharedManager];

    [self.iamgeView sd_setImageWithURL:[NSURL URLWithString:model.thumburl] placeholderImage:[UIImage imageNamed:@"timg"]];
    
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.thumburl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize,NSURL * url) {
//
//    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//
////        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
////            self.imageView.image = image;
////        }];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.imageView setImage:image];
//        });
    
//        [self setNeedsDisplay];
        
//    }];
//    [[manager imageDownloader] downloadImageWithURL:imageURL options:0 progress:^(NSInteger   receivedSize, NSInteger expectedSize) {
//        // progression tracking code
//    }  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType,   BOOL finished, NSURL *imageURL) {
//        if (image) {
//            // do something with image
//        }
//    }];
    
   
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
