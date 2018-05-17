//
//  JokesModel.m
//  fun
//
//  Created by 123 on 2018/5/14.
//  Copyright © 2018年 123. All rights reserved.
//

#import "JokesModel.h"

@implementation JokesModel

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        //文字的Y值
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width -4 *10, MAXFLOAT);
        //    CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
        
        if( USERDEFAULT_float(CONTENT_FONT) != 0){
            //计算文字高度
            CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : Font(USERDEFAULT_float(CONTENT_FONT))} context:nil].size.height;
            CGFloat titleH = [self.title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]} context:nil].size.height;
            _cellHeight += textH + titleH + 10;
        }else{
            //计算文字高度
            CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
            CGFloat titleH = [self.title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]} context:nil].size.height;
            _cellHeight += textH + titleH + 10;
        }
        
        
        
        

    }
    return _cellHeight;
}
- (NSString *)text{
//    if (!_text) {
        if ([_text containsString:@"<br />"]) {
            [_text stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
        }
//    }
    return _text;
}

@end
