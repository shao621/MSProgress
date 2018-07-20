//
//  ViewController.m
//  进度条
//
//  Created by MS on 2018/7/19.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "MSCircleView.h"
@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) MSCircleView *circleView;
@property (nonatomic, assign) CGFloat time;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.time=13;
    //添加定时器
    // 延时10秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addTimer];
    });
    
    //创建控件
    [self creatControl];
    
}
- (void)creatControl
{
    
    //圆圈
    MSCircleView *circleView = [[MSCircleView alloc] initWithFrame:CGRectMake(220, 100, 100, 39)];
    circleView.time=self.time;
    circleView.color=[UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:circleView];
    self.circleView = circleView;
    
    
}

- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction
{
    self.circleView.color=[UIColor lightGrayColor];
    _circleView.progress += 0.01;
    if (_circleView.progress >= self.time) {
        [self removeTimer];
        NSLog(@"完成");
    }
}

- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

