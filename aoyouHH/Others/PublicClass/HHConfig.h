//
//  HHConfig.h
//  aoyouHH
//
//  Created by jinzelu on 15/4/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHConfig : NSObject

+(HHConfig *)sharedManager;

//热门话题
@property(nonatomic, strong) NSMutableArray *hotTopicArr;


//传课
@property(nonatomic, strong) NSMutableArray *FocusListArr;
@property(nonatomic, strong) NSMutableArray *CourseListArr;
@property(nonatomic, strong) NSMutableArray *AlbumListArr;





@end
