//
//  HotTopicCell.h
//  aoyouHH
//
//  Created by jinzelu on 15/4/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuijianAttModel.h"

@interface HotTopicCell : UITableViewCell

@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UIImageView *hotImg;
@property(nonatomic, strong) UILabel *numberLable;

@property(nonatomic, strong) TuijianAttModel *tuijianArr;

-(void)setData:(TuijianAttModel *)tuijianArr;

-(void)resizeHeight;

@end
