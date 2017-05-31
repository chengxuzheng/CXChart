//
//  CXChartManager.m
//  CXChartDemo
//
//  Created by Zheng on 2017/5/25.
//  Copyright © 2017年 Zheng. All rights reserved.
//

#import "CXChartManager.h"
#import "CXChartBrokenLineView.h"

static CXChartManager *instance = nil;

@interface CXChartManager ();

@property (nonatomic, strong) CXChartBrokenLineView *brokenLineView;

@end

@implementation CXChartManager

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CXChartManager alloc] init];
    });
    return instance;
}

+ (void)cx_addPoint:(void (^)(CXChartManager *))block {
    block([CXChartManager defaultManager]);
}




@end
