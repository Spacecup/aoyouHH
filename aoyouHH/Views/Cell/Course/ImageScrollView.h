//
//  ImageScrollView.h
//  aoyouHH
//
//  Created by jinzelu on 15/5/25.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollView : UIView

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIPageControl *pageControl;
@property(nonatomic, strong) NSArray *imgArray;

//-(ImageScrollView *)initWithFrame:(CGRect)frame;
-(void)setImageArray:(NSArray *)imageArray;
-(ImageScrollView *)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imgArr;


@end
/**
 *  轮播View
 */