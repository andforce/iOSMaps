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
#import "ControllerSwitchDelegate.h"

@interface MainViewController ()<ControllerSwitchDelegate>{
    MapViewController *_mapVC;
    SettingViewController *_settingVC;
}


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _mapVC = [[MapViewController alloc]init];
    _mapVC.controllerSwitchDelegate = self;
    
    _settingVC = [[SettingViewController alloc]init];
    _settingVC.controllerSwitchDelegate = self;
    
    
    [self addChildViewController:_mapVC];
    [self addChildViewController:_settingVC];
    
    [self.view addSubview:_mapVC.view];
    

    [self transitionFromViewController:_settingVC toViewController:_mapVC duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

-(void)switchToSettingController{
        [self transitionFromViewController:_mapVC toViewController:_settingVC duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
    
    
        } completion:^(BOOL finished) {
    
        }];
}

-(void)switchToMapController{
        [self transitionFromViewController:_settingVC toViewController:_mapVC duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
    
    
        } completion:^(BOOL finished) {
    
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
