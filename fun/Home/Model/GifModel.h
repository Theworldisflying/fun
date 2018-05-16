//
//  GifModel.h
//  fun
//
//  Created by 123 on 2018/5/15.
//  Copyright © 2018年 123. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GifModel : NSObject
@property(copy,nonatomic) NSString * wid;
@property(copy,nonatomic) NSString * update_time;
@property(copy,nonatomic) NSString * wbody;
@property(copy,nonatomic) NSString * comments;
@property(copy,nonatomic) NSString * likes;
@property(copy,nonatomic) NSString * wpic_s_width;
@property(copy,nonatomic) NSString * wpic_s_height;
@property(copy,nonatomic) NSString * wpic_m_width;
@property(copy,nonatomic) NSString * wpic_m_height;
@property(copy,nonatomic) NSString * is_gif;
@property(copy,nonatomic) NSString * wpic_small;
@property(copy,nonatomic) NSString * wpic_large;


@property (nonatomic,assign)CGFloat cellHeight;
@end
