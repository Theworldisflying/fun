//
//  CleanCache.h
//  fun
//
//  Created by 123 on 2018/5/15.
//  Copyright © 2018年 123. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CleanCache : NSObject
/**
 删除文件夹所有文件
 
 @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

/**
 获取文件夹尺寸
 
 @param directoryPath 文件夹路径
 @param completion 文件夹尺寸
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger totalSize))completion;

@end
