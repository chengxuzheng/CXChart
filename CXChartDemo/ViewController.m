//
//  ViewController.m
//  CXChartDemo
//
//  Created by Zheng on 2017/5/25.
//  Copyright © 2017年 Zheng. All rights reserved.
//

#import "ViewController.h"
#import "CXChartManager.h"
#import "CXChartBrokenLineView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [CXChartManager cx_addPoint:^(CXChartManager *manager) {
        
    }];
    
    CXChartBrokenLineView *hview = [[CXChartBrokenLineView alloc] initWithFrame:CGRectMake(60, 100, 250, 300)];
    
    [hview setCountToXAxis:12 toYAxis:8 withLineDash:YES];
    
    NSArray *dataArr = @[@{@"x":@10,@"y":@150},
                         @{@"x":@40,@"y":@100},
                         @{@"x":@80,@"y":@200},
                         @{@"x":@110,@"y":@80},
                         @{@"x":@140,@"y":@110},
                         @{@"x":@155,@"y":@150},
                         @{@"x":@180,@"y":@150},
                         @{@"x":@200,@"y":@100},
                         @{@"x":@222,@"y":@200},
                         @{@"x":@235,@"y":@80}];
    
    [hview setLinkPointDrawPathMode:CXChartLinkPointPathDrawModeStroke];
    
    [hview setLinePointsData:dataArr];

    [self.view addSubview:hview];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
