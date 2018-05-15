//
//  PictureModel.h
//  fun
//
//  Created by 123 on 2018/5/14.
//  Copyright © 2018年 123. All rights reserved.
//

#import <Foundation/Foundation.h>

//"thumburl": "http://ww3.sinaimg.cn/large/e4e2bea6jw1esgbeluoflj20bo0e9mxp.jpg",
//"title": "小黑别怕，我来保护你",
//"height": "513",
//"sourceurl": "http://down.laifudao.com/images/tupian/2015521203511.jpg",
//"width": "420",
//"class": "5",
//"url": "http://www.laifudao.com/tupian/44375.htm"
@interface PictureModel : NSObject
@property(copy,nonatomic) NSString * thumburl;
@property(copy,nonatomic) NSString * title;
@property(copy,nonatomic) NSString *height;
@property(copy,nonatomic) NSString *sourceurl;
@property(copy,nonatomic) NSString * width;
//@property(copy,nonatomic) NSString * class;
@property(copy,nonatomic) NSString * url;
@end
