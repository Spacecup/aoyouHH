//
//  CourseDetailViewController.m
//  aoyouHH
//
//  Created by jinzelu on 15/5/21.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "ClassCell.h"

@interface CourseDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSourceArr;
}
@end

NSString *const CourseDetCellIndentifier1 = @"titleClassCell";//章
NSString *const CourseDetCellIndentifier2 = @"classCell";//节

@implementation CourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"课程详情";
    _dataSourceArr = [[NSMutableArray alloc ]init];
    
    [self initTableView];
    [self getCourseDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ClassCell class] forCellReuseIdentifier:CourseDetCellIndentifier2];
    
}

-(void)getCourseDetail{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        //加载数据
        dispatch_async(dispatch_get_main_queue(), ^{
            //更新UI
        });
    });
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseDetCellIndentifier2];
    //赋值
    
    return cell;
}
#pragma mark - UITableViewDelegate

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
