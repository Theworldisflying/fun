//
//  GifCell.h
//  fun
//
//  Created by 123 on 2018/5/15.
//  Copyright © 2018年 123. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GifModel;
@interface GifCell : UITableViewCell
-(void)loadData:(GifModel*)model;
@end
