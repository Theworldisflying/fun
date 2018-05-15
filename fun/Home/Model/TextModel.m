//
//  TextModel.m
//  fun
//
//  Created by 123 on 2018/5/11.
//  Copyright © 2018年 123. All rights reserved.
//

#import "TextModel.h"

@implementation TextModel
{
    CGFloat _cellHeight;
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        //文字的Y值
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width -4 *10, MAXFLOAT);
        //    CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
        //计算文字高度
        CGFloat textH = [self.showapi_res_body.contentlist.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
        CGFloat titleH = [self.showapi_res_body.contentlist.title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
        
        _cellHeight += textH + titleH + 10;
        
        
    }
    return _cellHeight;
}


@end
