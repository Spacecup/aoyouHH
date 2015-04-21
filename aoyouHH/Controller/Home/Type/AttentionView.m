//
//  AttentionView.m
//  aoyouHH
//
//  Created by jinzelu on 15/4/21.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "AttentionView.h"
#import "ReAttentionCell.h"

@interface AttentionView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSource;//tableview的数据源
    NSMutableArray *_tuiJianArr;//推荐关注数组
    NSMutableArray *_attentionArr;//关注的数组
}

@end


NSString *const AttentionCellIndentifier1 = @"tuijianCell";
NSString *const AttentionCellIndentifier2 = @"myAttentionCell";


@implementation AttentionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.backgroundColor = RGB(248, 248, 248);
        [self initData];
        [self addMyTableView];
    }
    return self;
}

-(void)initData{
    _dataSource = [[NSMutableArray alloc] init];
    _tuiJianArr = [[NSMutableArray alloc] init];
    _attentionArr = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:@"绕口令" forKey:@"title"];
    [dic1 setObject:@"100" forKey:@"number"];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:@"糗事百科" forKey:@"title"];
    [dic2 setObject:@"678" forKey:@"number"];
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:@"哈哈" forKey:@"title"];
    [dic3 setObject:@"99" forKey:@"number"];
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] init];
    [dic4 setObject:@"闹眼子" forKey:@"title"];
    [dic4 setObject:@"365" forKey:@"number"];
    [_tuiJianArr addObject:dic1];
    [_tuiJianArr addObject:dic2];
    [_tuiJianArr addObject:dic3];
    [_tuiJianArr addObject:dic4];
    
    
    
    [_dataSource addObject:_tuiJianArr];
    [_dataSource addObject:_attentionArr];
    
}

-(void)addMyTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-64-49) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    NSLog(@"",)
    [self.tableView registerNib:[UINib nibWithNibName:@"ReAttentionCell" bundle:nil] forCellReuseIdentifier:AttentionCellIndentifier1];
    
    [self addSubview:self.tableView];
}


#pragma mark - UITableViewDataSource
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//每组的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _tuiJianArr.count;
    }else{
        if (_attentionArr.count == 0) {
            return 1;
        }else{
            return _attentionArr.count;
        }
    }
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ReAttentionCell *cell = (ReAttentionCell *)[tableView dequeueReusableCellWithIdentifier:AttentionCellIndentifier1];
        //赋值
        cell.titleLabel.text = [_tuiJianArr[indexPath.row] objectForKey:@"title"];
        NSString *numStr = [_tuiJianArr[indexPath.row] objectForKey:@"number"];
        cell.numberLable.text = [NSString stringWithFormat:@"帖子数：%@",numStr];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        static NSString *cellIndentifier2 = @"myAttentionCell";
        ReAttentionCell *cell = (ReAttentionCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier2];
        if (cell == nil) {
            //
            cell = [[ReAttentionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier2];
        }
        //赋值
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}

#pragma mark - UITableViewDelegate
//
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"推荐关注";
    }else{
        return @"我的关注";
    }
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else{
        return 10;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
