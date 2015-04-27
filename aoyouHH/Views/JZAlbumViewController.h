//
//  JZAlbumViewController.h
//  aoyouHH
//
//  Created by jinzelu on 15/4/27.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZAlbumViewController : UIViewController

/**
 *  接收图片数组
 */
@property(nonatomic, strong) NSMutableArray *imgArr;
/**
 *  接收当前显示图片的序号
 */
@property(nonatomic, assign) NSInteger imageTag;
/**
 *  显示scrollView
 */
@property(nonatomic, strong) UIScrollView *scrollView;
/**
 *  显示下标
 */
@property(nonatomic, strong) UILabel *sliderLabel;


@end
