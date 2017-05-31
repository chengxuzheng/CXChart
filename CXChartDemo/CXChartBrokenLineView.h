//
//  CXChartBrokenLineView.h
//  CXChartDemo
//
//  Created by Zheng on 2017/5/25.
//  Copyright © 2017年 Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CXChartLinkPointPathDrawModeStroke, //线
    CXChartLinkPointPathDrawModeFill, //填充
} CXChartLinkPointPathDrawMode; //绘制类型

@interface CXChartBrokenLineView : UIView

/**
 绘制XY轴线
 
 @param x x轴线数量
 @param y y轴线数量
 @param dash 内部轴线是否为虚线
 */
- (void)setCountToXAxis:(NSUInteger)x
                toYAxis:(NSUInteger)y
           withLineDash:(BOOL)dash;


/**
 设置XY轴线颜色

 @param xColor x轴线颜色
 @param yColor y轴线颜色
 */
- (void)setColorToXAxis:(UIColor *)xColor
                toYAxis:(UIColor *)yColor;


/**
 设置折线点坐标数据

 @param points 点坐标数据 
 
 example for points = [@{@"x":@10,@"y":@100},@{@"x":@100,@"y":@80}]
 */
- (void)setLinePointsData:(NSArray *)points;


/**
 设置折线颜色

 @param color 折线颜色
 */
- (void)setColorToLine:(UIColor *)color;


/**
 设置链接点颜色及链接点半径大小

 @param color 链接点颜色
 @param r 链接点半径
 */
- (void)setColorToLinkPoint:(UIColor *)color
            withPointRadius:(CGFloat)r;


/**
 设置链接点填充模式

 @param mode 填充模式
 */
- (void)setLinkPointDrawPathMode:(CXChartLinkPointPathDrawMode)mode;


@end
