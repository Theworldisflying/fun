//
//  GifModel.m
//  fun
//
//  Created by 123 on 2018/5/15.
//  Copyright © 2018年 123. All rights reserved.
//

#import "GifModel.h"

@implementation GifModel

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
//        if ([self.wpic_m_width floatValue]>Width) {
//            _cellHeight = [_wpic_s_height floatValue];
//        }else{
        
//        }
        
        
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width -4 *10, MAXFLOAT);
        CGFloat textH = [self.wbody boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]} context:nil].size.height;
        
//        CGFloat w = [self.wpic_m_width floatValue];
//        CGFloat h = [self.wpic_m_height floatValue];
//        if (h/w > Height/Width) {
//            _cellHeight = h - (h/w - Height/Width)*h;
//        }else{
//            _cellHeight = h;
//        }
        if ([self.is_gif isEqualToString:@"0"]) {
          _cellHeight  =  [GetUrlImageSize getImageSizeWithURL:self.wpic_large].height;
        }else{
            _cellHeight = [_wpic_m_height floatValue];
        }
        
        _cellHeight  += textH;
    }
    
    
    return _cellHeight + 10;
}

@end
