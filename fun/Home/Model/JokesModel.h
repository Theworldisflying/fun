//
//  JokesModel.h
//  fun
//
//  Created by 123 on 2018/5/14.
//  Copyright © 2018年 123. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JokesModel : NSObject
@property(copy,nonatomic) NSString * text;
@property(copy,nonatomic) NSString * title;
@property(assign,nonatomic) NSInteger type;
@property(copy,nonatomic) NSString * ct;
//额外的辅助属性
@property (nonatomic,assign)CGFloat cellHeight;
@end
