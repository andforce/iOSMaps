//
//  MainViewController.m
//  iOSMaps
//
//  Created by WDY on 15/12/16.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "MainViewController.h"
#import "MapViewController.h"
#import "SettingViewController.h"

@interface MainViewController (){
    MapViewController *_mapVC;
    SettingViewController *_settingVC;
}


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _mapVC = [[MapViewController alloc]init];
    _settingVC = [[SettingViewController alloc]init];
    
    [self addChildViewController:_mapVC];
    [self addChildViewController:_settingVC];
    
    [self.view addSubview:_mapVC.view];
    
//    [self transitionFromViewController:_mapVC toViewController:_settingVC duration:10 options:UIViewAnimationOptionTransitionCurlUp animations:^{
//        
//        
//    } completion:^(BOOL finished) {
//        
//    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
