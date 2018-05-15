//
//  ImageModel.h
//  fun
//
//  Created by 123 on 2018/5/11.
//  Copyright © 2018年 123. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ImageBody;
@class ImageContent;
@interface ImageModel : NSObject


@property(copy,nonatomic) NSString * showapi_res_error;
@property(assign,nonatomic) NSInteger showapi_res_code;
@property(strong,nonatomic) ImageBody * showapi_res_body;


//图片是否太大
@property (nonatomic,assign,getter=isBigPicture)BOOL bigImage;
//图片控件的frame
@property (nonatomic,assign,readonly)CGRect pictureF;

//图片下载进度
@property (nonatomic,assign)CGFloat pictureProgress;


@end



@interface ImageBody : NSObject
@property(assign,nonatomic) NSInteger allPages;
@property(assign,nonatomic) NSInteger ret_code;
@property(strong,nonatomic) ImageContent * contentlist;
@property(assign,nonatomic) NSInteger currentPage;
@property(assign,nonatomic) NSInteger allNum;
@property(assign,nonatomic) NSInteger maxResult;

@end

@interface ImageContent : NSObject

@property(copy,nonatomic) NSString * img;
@property(copy,nonatomic) NSString * title;
@property(assign,nonatomic) NSInteger type;
@property(copy,nonatomic) NSString * ct;

//图片的高度
@property (nonatomic,assign)CGFloat height;
//图片的宽度
@property (nonatomic,assign)CGFloat width;

@end
