//
//  DiscoverViewController.m
//  aoyouHH
//
//  Created by jinzelu on 15/4/21.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "DiscoverViewController.h"
#import "HHConfig.h"
#import "TuijianAttModel.h"
#import "NetworkSingleton.h"
#import "HotTopicCell.h"

@interface DiscoverViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSources;//tableview的数据源
    NSMutableArray *_dataArr1;
    NSMutableArray *_dataArr2;
    NSMutableArray *_dataArr3;
    
    NSInteger _currentPage;
}

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self addMyTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化私有变量
-(void)initData{
    _currentPage = 1;
    _dataSources = [[NSMutableArray alloc] init];
    _dataArr1 = [[NSMutableArray alloc] init];
    _dataArr2 = [[NSMutableArray alloc] init];
    _dataArr3 = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setValue:@"24小时最哈" forKey:@"title"];
    [dic1 setValue:@"clock_img" forKey:@"pic"];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setValue:@"一周最哈" forKey:@"title"];
    [dic2 setValue:@"week_joke_img" forKey:@"pic"];
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setValue:@"热门评论" forKey:@"title"];
    [dic3 setValue:@"hot_comment_img" forKey:@"pic"];
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] init];
    [dic4 setValue:@"活动专区" forKey:@"title"];
    [dic4 setValue:@"activity_area_img" forKey:@"pic"];
    
    [_dataArr1 addObject:dic1];
    [_dataArr1 addObject:dic2];
    [_dataArr1 addObject:dic3];
    [_dataArr1 addObject:dic4];
    
    _dataArr2 = [HHConfig sharedManager].hotTopicArr;
    
}

-(void)addMyTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-49) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
    
    [self loadFirstPageData];
}

-(void)loadFirstPageData{
    _currentPage = 1;
    [self loadData:_currentPage];
}

-(void)loadData:(NSInteger)Page{
    NSString *r = @"topic";
    NSString *login_info = @"010000005EBBA6009CE535551C1917574FAFAE4E8BF03B02E6AD6D074AD69809B5AD76DFB9B12D28";
    NSString *page = [NSString stringWithFormat:@"%ld",(long)Page];
    NSString *type = @"update";
    NSDictionary *dic = @{@"r":r,
                          @"login_info":login_info,
                          @"page":page,
                          @"type":type};
    [[NetworkSingleton sharedManager] getTuijianAttResult:dic successBlock:^(id responseBody){
        NSLog(@"热门话题成功");
        NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:responseBody];
        _dataArr3 = responseBody;
        [self.tableView reloadData];
        
    } failureBlock:^(NSString *error){
        NSLog(error);
    }];
//    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
}







#pragma mark - UITableViewDataSource
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
//每组的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else if(section == 1){
        return 4;
    }else{
        return _dataArr3.count;
    }
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *disCellIndentifier1 = @"disCell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:disCellIndentifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:disCellIndentifier1];
        }
        //赋值
        cell.textLabel.text = [[_dataArr1 objectAtIndex:indexPath.row] objectForKey:@"title"];
        NSString *imgStr = [[_dataArr1 objectAtIndex:indexPath.row] objectForKey:@"pic"];
        cell.imageView.image = [UIImage imageNamed:imgStr];
        
        return cell;
    }else if(indexPath.section == 1){
        static NSString *disCellIndentifier2 = @"disCell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:disCellIndentifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:disCellIndentifier2];
        }
        //赋值
        TuijianAttModel *tuijianModel = [[TuijianAttModel alloc] init];
        if (_dataArr2.count>0) {
            tuijianModel = _dataArr2[indexPath.row];
            cell.textLabel.text = tuijianModel.content;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",tuijianModel.number];
        }
        
        return cell;
    }else{
        static NSString *disCellIndentifier3 = @"disCell3";
        HotTopicCell *cell = (HotTopicCell *)[tableView dequeueReusableCellWithIdentifier:disCellIndentifier3];
        if (cell == nil) {
            cell = [[HotTopicCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:disCellIndentifier3];
        }
        if (_dataArr3.count>0) {
            TuijianAttModel *tuijianModel = [[TuijianAttModel alloc] init];
            tuijianModel = _dataArr3[indexPath.row];
            [cell setData:tuijianModel];
            [cell resizeHeight];
        }
        
        return cell;
    }
}
#pragma mark - UITableViewDelegate
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
//组标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 15;
    }
}
//标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else if(section == 1){
        return @"推荐话题";
    }else{
        return @"热门话题";
    }
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
