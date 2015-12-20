//
//  MainViewController.m
//  iOSMaps
//
//  Created by WDY on 15/12/16.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "MainViewController.h"
#import "MapViewController.h"
#import "ControllerSwitchDelegate.h"
#import "MapSettingViewController.h"
#import "MapScrollSetttingViewController.h"
#import "CameraDAO.h"
#import "CameraBean.h"
#import "JSONModel+networking.h"
#import "Cameras.h"
#import "MapSettingNavigationViewController.h"
#import "UIViewController+Transition.h"

@interface MainViewController ()<ControllerSwitchDelegate>{
    MapViewController *_mapVC;
    
    //MapSettingViewController *_mapSettingVC;
    
    //MapScrollSetttingViewController *_scrollSettingVC;
    
    MapSettingNavigationViewController *_naviGationBarSettingVC;
}


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _mapVC = [[MapViewController alloc]init];
    _mapVC.controllerSwitchDelegate = self;
    
//    _mapSettingVC = [[MapSettingViewController alloc]init];
//    _mapSettingVC.controllerSwitchDelegate = self;
    
    
//    _scrollSettingVC = [[MapScrollSetttingViewController alloc]init];
//    _scrollSettingVC.controllerSwitchDelegate = self;
    
    
    [self addChildViewController:_mapVC];

//    [self addChildViewController:_mapSettingVC];
    
//    [self addChildViewController:_scrollSettingVC];
    
    
    
    
    _naviGationBarSettingVC = [[MapSettingNavigationViewController alloc]init];
    _naviGationBarSettingVC.controllerSwitchDelegate = self;
    [self addChildViewController:_naviGationBarSettingVC];
    
    [self transitionFromViewController:_naviGationBarSettingVC toViewController:_mapVC];
    [self.view addSubview:_mapVC.view];

}

-(void)switchToSettingController{
    
    [self transitionFromViewController:_mapVC toViewController:_naviGationBarSettingVC duration:0.5 animations:^{
        [_mapVC switchMaps];
        [_naviGationBarSettingVC switchSetting];
    }];
}

-(void)switchToMapController{
    
        [self.view addSubview:_mapVC.view];
    
        [self transitionFromViewController:_mapVC toViewController:_naviGationBarSettingVC duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
            [_mapVC switchMaps];
            [_naviGationBarSettingVC switchSetting];
            
        } completion:^(BOOL finished) {
            
            [self.view addSubview:_mapVC.view];
        }];
}



@end
