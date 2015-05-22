//
//  ClassCell.m
//  aoyouHH
//
//  Created by jinzelu on 15/5/21.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "ClassCell.h"

@implementation ClassCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self initViews];
    }
    return self;
}

-(void)initViews{
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 1, 50)];
    self.lineView.backgroundColor = navigationBarColor;
    [self.contentView addSubview:self.lineView];
    
    self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, screen_width-40, 30)];
    self.titleLable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLable];
    
    UILabel *typeLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 30, 20)];
    typeLable.text = @"视频";
    typeLable.textColor = [UIColor whiteColor];
    typeLable.font = [UIFont systemFontOfSize:11];
    typeLable.backgroundColor = RGB(118, 179, 224);
    [typeLable sizeToFit];
    [self.contentView addSubview:typeLable];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, screen_width-70, 20)];
    self.timeLabel.font = [UIFont systemFontOfSize:11];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.timeLabel];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
