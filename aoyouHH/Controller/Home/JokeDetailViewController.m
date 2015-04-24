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

@interface JokeDetailViewController ()
{
    UIView *_backView;
}
@end

@implementation JokeDetailViewController

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
    self.view.backgroundColor = RGB(241, 241, 241);
    [self addJokeViews];
    [self loadJokeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addJokeViews{
    
    JokeCell *cell = [[JokeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jokeCell"];
    [cell setJokeData:self.joke];
    [cell resizeHeight];
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+5, screen_width, cell.cellHeight)];
    [_backView addSubview:cell];
    [self.view addSubview:_backView];
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
