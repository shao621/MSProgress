//
//  MSCircleView.m
//  进度条
//
//  Created by MS on 2018/7/19.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MSCircleView.h"
#define MSCircleLineWidth 10.0f
#define MSCircleFont [UIFont boldSystemFontOfSize:26.0f]
#define MSCircleColor [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1]
@interface MSCircleView ()

@end
@implementation MSCircleView

-(instancetype)init{
    if (self=[super init]) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //1 计算周长 ，
    CGFloat circleLong=((rect.size.width-rect.size.height)*2+(rect.size.height-6)*3.14);
    //2 走的总长度
    CGFloat value =circleLong/self.time*self.progress;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    //3
    CGFloat value1=(value/((rect.size.height-6)*3.14/2.0));
    [path moveToPoint:CGPointMake(rect.size.width-rect.size.height/2.0, 3)];
    if (value<=(rect.size.height/2.0-3)*3.14) {
        [path addArcWithCenter:(CGPoint){rect.size.width -(rect.size.height * 0.5), rect.size.height * 0.5} radius:rect.size.height/2.0-3 startAngle:M_PI*1.5   endAngle:M_PI*1.5+M_PI*value1 clockwise:YES];
    }else if (value<=(rect.size.width-rect.size.height)+(rect.size.height-6)/2.0*3.14){
        CGFloat value1time=(rect.size.height/2.0-3)*3.14/circleLong*self.time;
        CGFloat value2time=(rect.size.width-rect.size.height)/circleLong*self.time;
        CGFloat value2=(self.progress-value1time)/value2time;
        [path addArcWithCenter:(CGPoint){rect.size.width -(rect.size.height * 0.5), rect.size.height * 0.5} radius:rect.size.height/2.0-3 startAngle:M_PI*1.5   endAngle:M_PI*1.5+M_PI clockwise:YES];
        [path addLineToPoint:CGPointMake((rect.size.width-rect.size.height-3)*(1-value2)+(rect.size.height/2.0), rect.size.height-3)];
    }else if (value<=((rect.size.width-rect.size.height)+(rect.size.height-6)*3.14)){
        [path addArcWithCenter:(CGPoint){rect.size.width -(rect.size.height * 0.5), rect.size.height * 0.5} radius:rect.size.height/2.0-3 startAngle:M_PI*1.5   endAngle:M_PI*1.5+M_PI clockwise:YES];
        [path addLineToPoint:CGPointMake(rect.size.height/2.0-3, rect.size.height-3)];
        CGFloat valuetime=((rect.size.height/2.0-3)*3.14+rect.size.width-rect.size.height)/circleLong*self.time;
        CGFloat value3time=((rect.size.height/2.0-3)*3.14)/circleLong*self.time;
        CGFloat value3=(self.progress-valuetime)/value3time;
        //1 获取前面所需要的时间 2 自己需要的时间
        [path addArcWithCenter:(CGPoint){rect.size.height/2.0, rect.size.height * 0.5} radius:rect.size.height/2.0-3 startAngle:M_PI*0.5   endAngle:M_PI*0.5+M_PI*value3 clockwise:YES];
    }else{
        [path addArcWithCenter:(CGPoint){rect.size.width -(rect.size.height * 0.5), rect.size.height * 0.5} radius:rect.size.height/2.0-3 startAngle:M_PI*1.5   endAngle:M_PI*1.5+M_PI clockwise:YES];
        [path addLineToPoint:CGPointMake(rect.size.height/2.0-3, rect.size.height-3)];
        [path addArcWithCenter:(CGPoint){rect.size.height/2.0, rect.size.height * 0.5} radius:rect.size.height/2.0-3 startAngle:M_PI*0.5   endAngle:M_PI*1.5 clockwise:YES];
        
        CGFloat valuetime=((rect.size.height-6)*3.14+rect.size.width-rect.size.height)/circleLong*self.time;
        CGFloat value3time=(rect.size.width-rect.size.height)/circleLong*self.time;
        CGFloat value3=(self.progress-valuetime)/value3time;
        [path addLineToPoint:CGPointMake((rect.size.height/2.0-3)+(rect.size.width-rect.size.height)*value3, 3)];
    }

    UIBezierPath *circlePath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.origin.x+3, rect.origin.y+3, rect.size.width-6, rect.size.height-6) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(rect.size.width, rect.size.height)];
    circlePath.lineWidth =3.0;// MSCircleLineWidth;
    //颜色
    [self.color set];
    //拐角
    circlePath.lineCapStyle = kCGLineCapRound;
    circlePath.lineJoinStyle = kCGLineJoinRound;
    //连线
    [circlePath stroke];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = MSCircleColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 3;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    CAShapeLayer* lineLayer = [CAShapeLayer layer];
    lineLayer.fillColor = [UIColor whiteColor].CGColor;
    lineLayer.strokeColor = MSCircleColor.CGColor;
    lineLayer.lineWidth = 3.0f;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.lineJoin = kCALineCapRound;
    [self.layer addSublayer:lineLayer];
    
    UIBezierPath* path3 = [UIBezierPath bezierPath];
    int x = rect.size.width/2.0-1;
    int y = rect.origin.y+6+3;
    [path3 moveToPoint:CGPointMake(x, y)];
    [path3 addLineToPoint:CGPointMake(x, rect.size.height-3-6)];
    lineLayer.path = path3.CGPath;
    CAShapeLayer* lineTwoLayer = [CAShapeLayer layer];
    lineTwoLayer.fillColor = [UIColor whiteColor].CGColor;
    lineTwoLayer.strokeColor = MSCircleColor.CGColor;
    lineTwoLayer.lineWidth = 4.0f;
    lineTwoLayer.lineCap = kCALineCapRound;
    lineTwoLayer.lineJoin = kCALineCapRound;
    [self.layer addSublayer:lineTwoLayer];
    
    UIBezierPath* path2 = [UIBezierPath bezierPath];
    int x2 = rect.size.width/2.0 - 2 - 6 -4;
    int y2 = rect.origin.y + 3 + 10 ;
    [path2 moveToPoint:CGPointMake(x2, y2)];
    [path2 addLineToPoint:CGPointMake(x2, rect.size.height-3-10)];
    lineTwoLayer.path = path2.CGPath;

    
    CAShapeLayer* lineFourLayer = [CAShapeLayer layer];
    lineFourLayer.fillColor = [UIColor whiteColor].CGColor;
    lineFourLayer.strokeColor = MSCircleColor.CGColor;
    lineFourLayer.lineWidth = 4.0f;
    lineFourLayer.lineCap = kCALineCapRound;
    lineFourLayer.lineJoin = kCALineCapRound;
    [self.layer addSublayer:lineFourLayer];
    
    UIBezierPath* path4 = [UIBezierPath bezierPath];
    int x4 = rect.size.width/2.0 + 2 + 6 ;
    int y4 = rect.origin.y + 3 + 10;
    [path4 moveToPoint:CGPointMake(x4, y4)];
    [path4 addLineToPoint:CGPointMake(x4, rect.size.height-3-10)];
    lineFourLayer.path = path4.CGPath;

    
    CAShapeLayer* lineOneLayer = [CAShapeLayer layer];
    lineOneLayer.fillColor = [UIColor whiteColor].CGColor;
    lineOneLayer.strokeColor = MSCircleColor.CGColor;
    lineOneLayer.lineWidth = 4.0f;
    lineOneLayer.lineCap = kCALineCapRound;
    lineOneLayer.lineJoin = kCALineCapRound;
    [self.layer addSublayer:lineOneLayer];
    
    UIBezierPath* path1 = [UIBezierPath bezierPath];
    int x1 = rect.size.width/2.0 - 2 - 19 ;
    int y1 = rect.origin.y + 3 + 14;
    [path1 moveToPoint:CGPointMake(x1, y1)];
    [path1 addLineToPoint:CGPointMake(x1, rect.size.height-3-14)];
    lineOneLayer.path = path1.CGPath;
    
    
    CAShapeLayer* lineFiveLayer = [CAShapeLayer layer];
    lineFiveLayer.fillColor = [UIColor whiteColor].CGColor;
    lineFiveLayer.strokeColor = MSCircleColor.CGColor;
    lineFiveLayer.lineWidth = 4.0f;
    lineFiveLayer.lineCap = kCALineCapRound;
    lineFiveLayer.lineJoin = kCALineCapRound;
    [self.layer addSublayer:lineFiveLayer];
    
    UIBezierPath* path5 = [UIBezierPath bezierPath];
    int x5 = rect.size.width/2.0 + 2 + 15 ;
    int y5 = rect.origin.y + 3 + 14;
    [path5 moveToPoint:CGPointMake(x5, y5)];
    [path5 addLineToPoint:CGPointMake(x5, rect.size.height-3-14)];
    lineFiveLayer.path = path5.CGPath;
#pragma mark 一秒跳动一次， 范围0-2 3个位置
    int count = self.progress;
    if (self.progress>=self.time) {
        lineOneLayer.strokeColor=MSCircleColor.CGColor;
        lineFiveLayer.strokeColor=MSCircleColor.CGColor;
        lineTwoLayer.strokeColor=MSCircleColor.CGColor;
        lineFourLayer.strokeColor=MSCircleColor.CGColor;
    }else{
        for (int i = 0; i<count; i++) {
            int index=i*100%3;
            switch (index) {
                case 0:{
                    lineOneLayer.strokeColor=[UIColor whiteColor].CGColor;
                    lineFiveLayer.strokeColor=[UIColor whiteColor].CGColor;
                    lineTwoLayer.strokeColor=[UIColor whiteColor].CGColor;
                    lineFourLayer.strokeColor=[UIColor whiteColor].CGColor;
                }
                    break;
                case 1:{
                    lineOneLayer.strokeColor=[UIColor whiteColor].CGColor;
                    lineFiveLayer.strokeColor=[UIColor whiteColor].CGColor;
                    lineTwoLayer.strokeColor=MSCircleColor.CGColor;
                    lineFourLayer.strokeColor=MSCircleColor.CGColor;
                }
                    break;
                case 2:{
                    lineOneLayer.strokeColor=MSCircleColor.CGColor;
                    lineFiveLayer.strokeColor=MSCircleColor.CGColor;
                    lineTwoLayer.strokeColor=MSCircleColor.CGColor;
                    lineFourLayer.strokeColor=MSCircleColor.CGColor;
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    

    
    
}

@end
