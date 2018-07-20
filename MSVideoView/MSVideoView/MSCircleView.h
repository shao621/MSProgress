//
//  MSCircleView.h
//  进度条
//
//  Created by MS on 2018/7/19.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSCircleView : UIView
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) CGFloat time;
@property (nonatomic, strong) UIColor *color;

@end
