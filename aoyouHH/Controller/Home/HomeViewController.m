//
//  HomeViewController.m
//  aoyouHH
//
//  Created by jinzelu on 15/4/21.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "HomeViewController.h"
#import "AttentionView.h"
#import "HotView.h"
#import "NewView.h"
#import "FunView.h"
#import "WordView.h"

#import "NetworkSingleton.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self addScrollViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addScrollViews{
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 20)];
    statusBarView.backgroundColor = navigationBarColor;
    [self.view addSubview:statusBarView];
    
    CGRect frame = CGRectMake(0, 20, screen_width, screen_height-49-20);
    NSArray *views = @[[AttentionView new],[HotView new],[NewView new],[FunView new],[WordView new]];
    NSArray *names = @[@"关注",@"最火",@"最新",@"趣图",@"文字"];
    //创建
    self.scroll = [XLScrollViewer scrollWithFrame:frame withViews:views withButtonNames:names withThreeAnimation:211];
    self.scroll.xl_topBackColor = navigationBarColor;
    self.scroll.xl_topHeight = 44;
    self.scroll.xl_buttonColorSelected = [UIColor whiteColor];
    self.scroll.xl_buttonColorNormal = [UIColor whiteColor];
    self.scroll.xl_sliderColor = [UIColor whiteColor];
    self.scroll.xl_sliderHeight = 0;
    
    //加入
    [self.view addSubview:self.scroll];
    [self getHotestData];
}


-(void)getHotestData{
    NSString *r = @"joke_list";
    NSString *drive_info = @"61f8612436df7ac7f0142a2de879846475f80000";
    NSString *page = @"1";
    NSString *offset = @"2";
    NSString *type = @"web_good";
    NSDictionary *dic = @{
                          @"r":r,
                          @"drive_info":drive_info,
                          @"page":page,
                          @"offset":offset,
                          @"type":type
                          };
    [[NetworkSingleton sharedManager] getHotestResule:dic successBlock:^(id responseBody){
        NSLog(@"成功");
    } failureBlock:^(NSString *error){
        NSLog(error);
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
