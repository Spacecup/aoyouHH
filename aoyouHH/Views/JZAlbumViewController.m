//
//  JZAlbumViewController.m
//  aoyouHH
//
//  Created by jinzelu on 15/4/27.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZAlbumViewController.h"
#import "UIImageView+WebCache.h"

@interface JZAlbumViewController ()<UIScrollViewDelegate>
{
    CGFloat lastScale;
}

@end

@implementation JZAlbumViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lastScale = 1.0;
    self.view.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapView)];
    [self.view addGestureRecognizer:tap];
    
    [self initScrollView];
    [self addLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(self.imgArr.count*screen_width, screen_height);
    self.scrollView.delegate = self;
    
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    for (int i = 0; i < self.imgArr.count; i++) {
        id path = [self.imgArr objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*i, 0, width, height)];
        imageView.tag = self.imageTag;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
//        imageView.backgroundColor = [UIColor redColor];
        
        if ([path isKindOfClass:[NSString class]]) {
            //待完成
            [imageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"comment_empty_img"]];
            NSLog(@"url:%@",path);
        }else if([path isKindOfClass:[UIImage class]]){
            [imageView setImage:[self.imgArr objectAtIndex:i]];
        }else{
            [imageView setImage:[UIImage imageNamed:@"comment_empty_img"]];
        }
        
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    [self.view addSubview:self.scrollView];
}

-(void)addLabels{
    self.sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, screen_height-64-49, 60, 30)];
    self.sliderLabel.backgroundColor = [UIColor clearColor];
    self.sliderLabel.textColor = [UIColor whiteColor];
    self.sliderLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.imageTag+1,self.imgArr.count];
    [self.view addSubview:self.sliderLabel];
}

-(void)OnTapView{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int i = scrollView.contentOffset.x/screen_width+1;
    self.sliderLabel.text = [NSString stringWithFormat:@"%ld/%ld",i,self.imgArr.count];
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
