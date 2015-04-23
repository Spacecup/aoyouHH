//
//  JokeCell.h
//  aoyouHH
//
//  Created by jinzelu on 15/4/23.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JokeModel.h"

@interface JokeCell : UITableViewCell

@property(nonatomic, strong) UIView *backView;

@property(nonatomic, strong) UIImageView *userImg;
@property(nonatomic, strong) UILabel *userNameLable;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UIButton *topicBtn;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UIImageView *picImg;


@property(nonatomic, strong) JokeModel *joke;

-(void)setJokeData:(JokeModel *)joke;

-(void)resizeHeight;

@end
