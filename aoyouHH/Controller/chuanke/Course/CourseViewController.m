//
//  CourseViewController.m
//  aoyouHH
//
//  Created by jinzelu on 15/5/21.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "CourseViewController.h"
#import "HHConfig.h"
#import "NetworkSingleton.h"
#import "FocusModel.h"
#import "UIImageView+WebCache.h"

@interface CourseViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSourceArr;
}
@end

@implementation CourseViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"仿百度传课";
    _dataSourceArr = [[NSMutableArray alloc] init];
    
    [self initTableView];
    [self getChuanKeResult];
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
}

-(void)getChuanKeResult{
    if ([HHConfig sharedManager].CourseListArr.count == 0) {
        [[NetworkSingleton sharedManager] getChuanKeMain:nil successBlock:^(id responseBody){
            NSLog(@"传课成功:%@",[HHConfig sharedManager].FocusListArr);
            _dataSourceArr = [HHConfig sharedManager].CourseListArr;
            [self.tableView reloadData];
        } failureBlock:^(NSString *error){
            NSLog(@"传课失败");
        }];
    }else{
        _dataSourceArr = [HHConfig sharedManager].CourseListArr;
        [self.tableView reloadData];
    }
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"customCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
        UIImageView *courseImg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 60, 45)];
        courseImg.tag = 20;
        [cell.contentView addSubview:courseImg];
        
        UILabel *CourseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(courseImg.frame)+8, 5, screen_width - CGRectGetMaxX(courseImg.frame) -10, 15)];
        CourseNameLabel.numberOfLines = 1;
        CourseNameLabel.font = [UIFont systemFontOfSize:13];
        CourseNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        CourseNameLabel.tag = 21;
        [cell.contentView addSubview:CourseNameLabel];
        
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(courseImg.frame)+8, CGRectGetMaxY(CourseNameLabel.frame)+5, screen_width - CGRectGetMaxX(courseImg.frame) -10, 30)];
        subTitleLabel.numberOfLines = 2;
        subTitleLabel.font = [UIFont systemFontOfSize:10];
        subTitleLabel.textColor = [UIColor lightGrayColor];
        subTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        subTitleLabel.tag = 22;
        [cell.contentView addSubview:subTitleLabel];
    }
    //赋值
    FocusModel *focus = [[FocusModel alloc] init];
    focus = [_dataSourceArr objectAtIndex:indexPath.row];
    UIImageView *courseImg = (UIImageView *)[cell.contentView viewWithTag:20];
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:21];
    UILabel *subTitleLabel = (UILabel *)[cell.contentView viewWithTag:22];
    [courseImg sd_setImageWithURL:[NSURL URLWithString:focus.PhotoURL] placeholderImage:nil];
    titleLabel.text = focus.CourseName;
    subTitleLabel.text = focus.Brief;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
