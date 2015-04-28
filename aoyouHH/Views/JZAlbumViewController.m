//
//  JZAlbumViewController.m
//  aoyouHH
//
//  Created by jinzelu on 15/4/27.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZAlbumViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

@interface JZAlbumViewController ()<UIScrollViewDelegate>
{
    CGFloat lastScale;
    MBProgressHUD *HUD;
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
    [self setPicCurrentIndex:self.currentIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initScrollView{
    [[SDImageCache sharedImageCache] cleanDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(self.imgArr.count*screen_width, screen_height);
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:self.scrollView];
    

}

-(void)addLabels{
    self.sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, screen_height-64-49, 60, 30)];
    self.sliderLabel.backgroundColor = [UIColor clearColor];
    self.sliderLabel.textColor = [UIColor whiteColor];
    self.sliderLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currentIndex+1,self.imgArr.count];
    [self.view addSubview:self.sliderLabel];
}

-(void)setPicCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    self.scrollView.contentOffset = CGPointMake(screen_width*currentIndex, 0);
    [self loadPhote:_currentIndex];
}

-(void)loadPhote:(NSInteger)index{
    if (index<0 || index >=self.imgArr.count) {
        return;
    }
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    id path = [self.imgArr objectAtIndex:index];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*index, 0, width, height)];
    imageView.tag = self.currentIndex;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    //放大手势
    UIPinchGestureRecognizer *pinGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinGes:)];
    
    [imageView addGestureRecognizer:pinGes];
    
    
    [self.scrollView addSubview:imageView];
    
    if ([path isKindOfClass:[NSString class]]) {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        BOOL isCached = [manager cachedImageExistsForURL:[NSURL URLWithString:path]];
        if(!isCached){//没有缓存
            NSLog(@"1111没有缓存");
            HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            HUD.mode = MBProgressHUDModeDeterminate;
        }
        
//            [imageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"comment_empty_img"]];
//         第三方UIActivityIndicator库，暂时没用到
//            [imageView setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"comment_empty_img"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [imageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"comment_empty_img"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
            HUD.progress = ((float)receivedSize)/expectedSize;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            NSLog(@"加载完成");
            if (!isCached) {
                [HUD hide:YES];
            }
            
        }];
        NSLog(@"url:%@",path);
    }else if([path isKindOfClass:[UIImage class]]){
        [imageView setImage:[self.imgArr objectAtIndex:index]];
    }else{
        [imageView setImage:[UIImage imageNamed:@"comment_empty_img"]];
    }
    
}


-(void)OnTapView{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)pinGes:(UIPinchGestureRecognizer *)sender{
    if ([sender state] == UIGestureRecognizerStateBegan) {
        lastScale = 1.0;
    }
    CGFloat scale = 1.0 - (lastScale -[sender scale]);
    lastScale = [sender scale];
    
    CATransform3D newTransform = CATransform3DScale(sender.view.layer.transform, scale, scale, 1);
    
    sender.view.layer.transform = newTransform;
    if ([sender state] == UIGestureRecognizerStateEnded) {
        //
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    int i = scrollView.contentOffset.x/screen_width+1;
    [self loadPhote:i-1];
    self.sliderLabel.text = [NSString stringWithFormat:@"%d/%ld",i,self.imgArr.count];
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
