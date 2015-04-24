//
//  HotView.h
//  aoyouHH
//
//  Created by jinzelu on 15/4/21.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotView : UIView

@property(nonatomic, strong) UITableView *tableView;
/**
 *  图片大小类型，默认的时normal
 */
@property(nonatomic, strong) NSString *imgType;

@end
