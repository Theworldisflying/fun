//
//  TextModel.h
//  fun
//
//  Created by 123 on 2018/5/11.
//  Copyright © 2018年 123. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Body;
@class Content;

@interface TextModel : NSObject


@property(copy,nonatomic) NSString * showapi_res_error;
@property(assign,nonatomic) NSInteger showapi_res_code;
@property(strong,nonatomic) Body * showapi_res_body;



@end



@interface Body : NSObject
@property(assign,nonatomic) NSInteger allPages;
@property(assign,nonatomic) NSInteger ret_code;
@property(strong,nonatomic) Content * contentlist;
@property(assign,nonatomic) NSInteger currentPage;
@property(assign,nonatomic) NSInteger allNum;
@property(assign,nonatomic) NSInteger maxResult;

@end

@interface Content : NSObject

@property(copy,nonatomic) NSString * text;
@property(copy,nonatomic) NSString * title;
@property(assign,nonatomic) NSInteger type;
@property(copy,nonatomic) NSString * ct;
//额外的辅助属性
///@property (nonatomic,assign,readonly)CGFloat cellHeight;

@end



