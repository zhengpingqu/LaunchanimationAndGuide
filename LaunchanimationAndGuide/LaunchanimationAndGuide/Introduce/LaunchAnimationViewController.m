//
//  AnimationViewController.m
//  LaunchAnimationDemo
//
//  Created by 曲正平 on 2017/3/23.
//  Copyright © 2017年 曲正平. All rights reserved.
//

#import "LaunchAnimationViewController.h"
#import <MediaPlayer/MediaPlayer.h>

#define ScreenWidth self.view.bounds.size.width
#define ScreenHeight self.view.bounds.size.height
@interface LaunchAnimationViewController ()
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic ,strong) UIScrollView *welcomeScrollView;
@end
@implementation LaunchAnimationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moviePlayer.view.backgroundColor = [UIColor blackColor];
    // 设置播放的路径
//    self.moviePlayer.contentURL = [[NSURL alloc] initFileURLWithPath:self.pVideoPath];
    [self.moviePlayer prepareToPlay];
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"kIsNoFirstRun"] boolValue]){
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"kIsNoFirstRun"];
        
        self.welcomeScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        self.welcomeScrollView.showsVerticalScrollIndicator = NO;
        self.welcomeScrollView.showsHorizontalScrollIndicator = NO;
        self.welcomeScrollView.pagingEnabled = YES;
        self.welcomeScrollView.bounces = NO;
        self.welcomeScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 4, self.view.bounds.size.height);
        [self.view addSubview:self.welcomeScrollView];
        
      
        for (NSInteger i = 0; i < self.guideArray.count; i++) {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, ScreenHeight)];
            imageView.image = [UIImage imageNamed:self.guideArray[i]];
            if (i == 3) {
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(100, ScreenHeight - 100, ScreenWidth - 200, (ScreenWidth - 200) / 4.1)];
                imageView.userInteractionEnabled = YES;
                [button setImage:[UIImage imageNamed:@"立即体验"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(welcomePageFinish) forControlEvents:UIControlEventTouchUpInside];
                [imageView addSubview:button];
            }
            [self.welcomeScrollView addSubview:imageView];
        }
    }else{
        
        [self startPlay];
    }
}

- (void)welcomePageFinish{
    [self.welcomeScrollView removeFromSuperview];
    [self startPlay];
    
}

- (void)startPlay{
    
    [self.moviePlayer play];
}


- (void)playFinsihed{
    self.playFinished();
}

-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        _moviePlayer = [[MPMoviePlayerController alloc]init];
        [_moviePlayer.view setFrame:self.view.bounds];
        //设置自动播放
        [_moviePlayer setShouldAutoplay:NO];
        //设置源类型 因为新特性一般都是播放本地的小视频 所以设置源类型为file
        _moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        //取消控制视图 如：播放暂停等
        _moviePlayer.controlStyle = MPMovieControlStyleNone;
        [self.view addSubview:_moviePlayer.view];
        //监听播放完成
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playFinsihed) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    }
    return _moviePlayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
