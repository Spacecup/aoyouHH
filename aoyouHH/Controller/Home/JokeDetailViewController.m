//
//  JokeDetailViewController.m
//  aoyouHH
//
//  Created by jinzelu on 15/4/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JokeDetailViewController.h"
#import "NetworkSingleton.h"
#import "JokeCell.h"
#import "CustomCell.h"

@interface JokeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_backView;
    JokeModel *_jokeData;//joke数据
    NSMutableArray *_commentArray;//评论数据
    CGFloat _marginTop;
    NSInteger _contenType;
}
@end

NSString *const jokeDetailCellIndentifier1 = @"jokeCell";
NSString *const jokeDetailCellIndentifier2 = @"customCell";

@implementation JokeDetailViewController

+(JokeDetailViewController *)shareManeger{
    static JokeDetailViewController *sharedJokeDetailVC = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedJokeDetailVC = [[self alloc] init];
    });
    return sharedJokeDetailVC;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
        NSLog(@"JokeDetailViewController===initWithNibName");
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
        //
        _jokeData = self.joke;
        NSLog(@"JokeDetailViewController===init");
    }
    return self;
}

-(void)setData:(JokeModel *)joke{
    self.joke = joke;
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(241, 241, 241);
    NSLog(@"viewdidload");
    [self initData];
    [self addJokeViews];
//    [self loadJokeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addJokeViews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[JokeCell class] forCellReuseIdentifier:jokeDetailCellIndentifier1];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:jokeDetailCellIndentifier2];
    [self.view addSubview:self.tableView];
}

-(void)initData{
    _jokeData = [[NSMutableArray alloc] init];
    _commentArray = [[NSMutableArray alloc] init];
    _jokeData = self.joke;//接收上一个界面传来的数据
    _marginTop = 5.0;
    _contenType = 1;
}

-(void)loadJokeData{
    NSString *r = @"joke_one";
    NSString *drive_info = DRIVE_INFO;
    NSString *login_info = LOGIN_INFO_NO;
    NSString *jid = [NSString stringWithFormat:@"%@",self.joke.id];
    NSDictionary *dic = @{
                          @"r":r,
                          @"drive_info":drive_info,
                          @"login_info":login_info,
                          @"jid":jid
                          };
    [[NetworkSingleton sharedManager] getOneJokeResule:dic successBlock:^(id responbody){
        NSLog(@"joke详情成功");
    } failureBlock:^(NSString *error){
        NSLog(@"%@",error);
    }];
}

#pragma mark - UITableViewDataSource
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        if (_commentArray.count == 0) {
            return 1;
        }else{
            return _commentArray.count;
        }
    }
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        JokeCell *cell = (JokeCell *)[tableView dequeueReusableCellWithIdentifier:jokeDetailCellIndentifier1];
        if (_jokeData!=nil) {
            cell.contentType = _contenType;
            [cell setJokeData:_jokeData];

        }
        
        return cell;
    }else{
        CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:jokeDetailCellIndentifier2];
        //赋值
        cell.MsgLabel.text = @"快快来抢沙发";
        
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat height = 0;
        height=_marginTop + height + _marginTop + 30 + _marginTop;
//        if (_jokeData!=nil) {
            JokeModel *joke = _jokeData;
        CGSize contentSize = {0,0};
        
        if (_contenType == 0) {
            contentSize = [joke.content sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(screen_width-8*2, 100) lineBreakMode:UILineBreakModeTailTruncation];
        }else{
            contentSize = [joke.content sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(screen_width-8*2, 1000) lineBreakMode:UILineBreakModeTailTruncation];
        }
        
            height =height + contentSize.height;
            
            if (joke.pic!=nil) {
                //
                NSString *urlStr = [NSString stringWithFormat:@"%@%@normal/%@", URL_IMAGE, joke.pic.path, joke.pic.name];
                NSURL *url = [NSURL URLWithString:urlStr];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                height = height + _marginTop + image.size.height;
            }else{
                height = height +_marginTop;
            }
            height = height +_marginTop+30;
            //        NSLog(@"222222height:%f",height);
            return height + _marginTop;
    }else{
        return 100;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 10.0f;
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
