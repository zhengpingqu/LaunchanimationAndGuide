//
//  AnimationViewController.h
//  LaunchAnimationDemo
//
//  Created by 曲正平 on 2017/3/23.
//  Copyright © 2017年 曲正平. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PlayFinishedNotify @"PlayFinishedNotify"

@interface LaunchAnimationViewController : UIViewController
/*
 动画播放完的回调
 */
@property (nonatomic, copy) void (^playFinished)();
/*
 mp4动画路径
 */
@property (nonatomic, copy) NSString *pVideoPath;
/*
 引导页数组
 */
@property (nonatomic ,copy) NSArray *guideArray;
@end
