//
//  JokesCell.m
//  fun
//
//  Created by 123 on 2018/5/14.
//  Copyright © 2018年 123. All rights reserved.
//

#import "JokesCell.h"
#import "JokesModel.h"

@interface JokesCell()
@property(strong,nonatomic) UILabel * stepLabel;
@property(strong,nonatomic) UILabel * walkStepLabel;
@property(strong,nonatomic) UILabel * dateLabel;
@end
@implementation JokesCell

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
-(void)setUI{
    
    
    
    self.stepLabel = [[UILabel alloc] init];
    [self setLabel:_stepLabel font:20 txtColor:[UIColor blackColor]];
    [self addSubview:_stepLabel];
    
    [self.stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(5);
        make.width.mas_equalTo(Width);
        
    }];
 
    
    self.dateLabel = [[UILabel alloc] init];
    [self setLabel:_dateLabel font:16 txtColor:[UIColor grayColor]];
    [self addSubview:_dateLabel];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stepLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.stepLabel);
        make.width.mas_equalTo(Width-10);
        
    }];
}
-(void)loadData:(JokesModel *)model{
    self.stepLabel.text = model.title;
    
    self.dateLabel.text = model.text;
    if (USERDEFAULT_float(CONTENT_FONT) != 0) {
       self.dateLabel.font = Font(USERDEFAULT_float(CONTENT_FONT));
    }
    
    
}


-(void)setLabel:(UILabel*)label font:(CGFloat)font txtColor:(UIColor*)color{
    label.font = [UIFont systemFontOfSize:font];
    [label setTextColor:color];
    label.backgroundColor = [UIColor clearColor];
//    label.adjustsFontSizeToFitWidth = true;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
