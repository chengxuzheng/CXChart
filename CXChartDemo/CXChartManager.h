//
//  CXChartManager.h
//  CXChartDemo
//
//  Created by Zheng on 2017/5/25.
//  Copyright © 2017年 Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXChartManager : NSObject

+ (void)cx_addPoint:(void(^)(CXChartManager *manager))block;


@end
