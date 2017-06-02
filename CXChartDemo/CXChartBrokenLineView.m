//
//  CXChartBrokenLineView.m
//  CXChartDemo
//
//  Created by Zheng on 2017/5/25.
//  Copyright © 2017年 Zheng. All rights reserved.
//

#import "CXChartBrokenLineView.h"

NSUInteger const DEFAULT_X_AXIS_COUNT = 10;
NSUInteger const DEFAULT_Y_AXIS_COUNT = 10;
CGFloat const DEFAULT_LINK_POINT_RADIUS = 6;

@interface CXChartBrokenLineView () {
    @private
    NSUInteger _xAxisCount; //x轴线数量
    NSUInteger _yAxisCount; //y轴线数量
    BOOL _isLineDash; //是否是虚线
    UIColor *_xColor; //x轴线颜色
    UIColor *_yColor; //y轴线颜色
    NSArray *_pointsDataArr; //坐标数据
    UIColor *_pointLineColor; //折线颜色
    UIColor *_linkPointColor; //链接点填充颜色
    CGFloat _linePointRadius; //链接点半径
    CXChartLinkPointPathDrawMode _pathDrawMode; //链接点绘制类型
}

@end

@implementation CXChartBrokenLineView

#pragma mark - 接口方法
- (void)setCountToXAxis:(NSUInteger)x toYAxis:(NSUInteger)y withLineDash:(BOOL)dash {
    _xAxisCount = x;
    _yAxisCount = y;
    _isLineDash = dash;
}

- (void)setColorToXAxis:(UIColor *)xColor toYAxis:(UIColor *)yColor {
    _xColor = xColor;
    _yColor = yColor;
}
- (void)setLinePointsData:(NSArray *)points {
    _pointsDataArr = points;
}

- (void)setColorToLine:(UIColor *)color {
    _pointLineColor = color;
}

- (void)setColorToLinkPoint:(UIColor *)color withPointRadius:(CGFloat)r {
    _linkPointColor = color;
    _linePointRadius = r;
}

- (void)setLinkPointDrawPathMode:(CXChartLinkPointPathDrawMode)mode {
    _pathDrawMode = mode;
}


#pragma mark - 图形绘制
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawXYAxisWithContext:context];

    [self drawBrokenLineWithContext:context];
    
    [self drawLineLinkPointWithContext:context];
    
}

#pragma mark - 绘制XY轴线
//绘制XY轴线
- (void)drawXYAxisWithContext:(CGContextRef)context {
    [self drawBrokenLineWithContext:context
                      withAxisCount:_xAxisCount
                      withAxisColor:_xColor withIsXAxis:YES];
    
    [self drawBrokenLineWithContext:context
                      withAxisCount:_yAxisCount
                      withAxisColor:_yColor withIsXAxis:NO];
}

//绘制轴线
- (void)drawBrokenLineWithContext:(CGContextRef)context
                    withAxisCount:(NSUInteger)count
                    withAxisColor:(UIColor *)color
                      withIsXAxis:(BOOL)isXAxis{
    
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    for (int i = 0; i < count; i++) {
        CGFloat width = (i == 0 || i == count-1)? 2.f: 1.f;
        CGContextSetLineWidth(context, width);
        
        CGFloat xMove = isXAxis? 0.f: self.frame.size.width/(count-1)*i;
        CGFloat yMove = isXAxis? self.frame.size.height/(count-1)*i: 0.f;
        
        CGFloat xAdd = isXAxis? self.frame.size.width: self.frame.size.width/(count-1)*i;
        CGFloat yAdd = isXAxis? self.frame.size.height/(count-1)*i: self.frame.size.height;
            
        CGContextMoveToPoint(context, xMove, yMove);
        CGContextAddLineToPoint(context, xAdd, yAdd);
        [self setXYAxisInternalDashWithContext:context withAxisCount:count-1 withIndex:i];
        CGContextStrokePath(context);
    }
}

/**
 设置XY轴线内部为虚线

 @param context 图形上下文
 @param count 轴线数量
 @param i 第几条轴线
 */
- (void)setXYAxisInternalDashWithContext:(CGContextRef)context
                           withAxisCount:(NSUInteger)count
                               withIndex:(int)i {
    if (_isLineDash) {
        if (i != 0 && i != count) {
            CGContextSetLineDash(context, 0, (CGFloat[]){2,1}, 2);
        } else {
            CGContextSetLineDash(context, 0, (CGFloat[]){1,0}, 2);
        }
    } else {
        CGContextSetLineDash(context, 0, (CGFloat[]){1,0}, 2);
    }
}

#pragma mark 绘制折线链接点
/**
 折线链接点(包括起始点和结束点)

 @param context 图形上下文
 */
- (void)drawLineLinkPointWithContext:(CGContextRef)context {
    if (_pointsDataArr && _pointsDataArr.count != 0) {
        for (int i = 0; i < _pointsDataArr.count; i++) {
            NSNumber *xNumber = _pointsDataArr[i][@"x"];
            CGFloat xCenter = xNumber.floatValue-_linePointRadius/2.f;
            NSNumber *yNumber = _pointsDataArr[i][@"y"];
            CGFloat yCenter = yNumber.floatValue-_linePointRadius/2.f;
            
            CGContextSetStrokeColorWithColor(context, _linkPointColor.CGColor);
            
            if (_pathDrawMode == CXChartLinkPointPathDrawModeStroke) {
                CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            } else {
                CGContextSetFillColorWithColor(context, _linkPointColor.CGColor);
            }
            
            CGContextAddEllipseInRect(context, CGRectMake(xCenter, yCenter, _linePointRadius, _linePointRadius));
            CGContextDrawPath(context, kCGPathStroke);
            
            CGContextFillEllipseInRect(context, CGRectMake(xCenter, yCenter, _linePointRadius, _linePointRadius));
            CGContextDrawPath(context, kCGPathFill);
            
//            //矩形边框
//            CGContextAddRect(context, CGRectMake(xCenter, yCenter, _linePointRadius, _linePointRadius));
//            CGContextDrawPath(context, kCGPathStroke);
//            
//            //填充矩形
//            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//            CGContextFillRect(context, CGRectMake(xCenter, yCenter, _linePointRadius, _linePointRadius));
//            CGContextDrawPath(context, kCGPathFill);
        }
    }
}

#pragma mark 绘制折线
/**
 绘制折线

 @param context 图形上下文
 */
- (void)drawBrokenLineWithContext:(CGContextRef)context {
    if (_pointsDataArr && _pointsDataArr.count != 0) {
        for (int i = 0; i < _pointsDataArr.count-1; i++) {
            CGContextSetStrokeColorWithColor(context, _pointLineColor.CGColor);
            CGContextSetLineWidth(context, 1);
            
            NSString *xKey = @"x";
            NSString *yKey = @"y";
            
            NSNumber *xNumber = _pointsDataArr[i][xKey];
            CGFloat xMove = xNumber.floatValue;
            NSNumber *yNumber = _pointsDataArr[i][yKey];
            CGFloat yMove = yNumber.floatValue;
            CGContextMoveToPoint(context, xMove, yMove);
            
            NSNumber *xAddNumber = _pointsDataArr[i+1][xKey];
            CGFloat xAddMove = xAddNumber.floatValue;
            NSNumber *yAddNumber = _pointsDataArr[i+1][yKey];
            CGFloat yAddMove = yAddNumber.floatValue;
            CGContextAddLineToPoint(context, xAddMove, yAddMove);
            
            CGContextStrokePath(context);
        }
    }
}


#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSettings];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self defaultSettings];
    }
    return self;
}

#pragma mark - 默认配置
- (void)defaultSettings {
    self.backgroundColor = [UIColor whiteColor];
    
    _xColor = [UIColor lightGrayColor];
    _yColor = [UIColor lightGrayColor];
    
    _xAxisCount = DEFAULT_X_AXIS_COUNT;
    _yAxisCount = DEFAULT_Y_AXIS_COUNT;
    
    _pointLineColor = [UIColor lightGrayColor];
    
    _linkPointColor = [UIColor orangeColor];
    _linePointRadius = DEFAULT_LINK_POINT_RADIUS;
    
    _pathDrawMode = CXChartLinkPointPathDrawModeFill;
}



@end
