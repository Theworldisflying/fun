//
//  JokesCell.h
//  fun
//
//  Created by 123 on 2018/5/14.
//  Copyright © 2018年 123. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JokesModel;

@interface JokesCell : UITableViewCell

-(void)loadData:(JokesModel*)model;
@end
