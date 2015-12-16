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


@interface MainViewController ()<ControllerSwitchDelegate>{
    MapViewController *_mapVC;
    
    MapSettingViewController *_mapSettingVC;
}


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _mapVC = [[MapViewController alloc]init];
    _mapVC.controllerSwitchDelegate = self;
    
    _mapSettingVC = [[MapSettingViewController alloc]init];
   
    
    
    [self addChildViewController:_mapVC];

    [self addChildViewController:_mapSettingVC];
    
    [self.view addSubview:_mapVC.view];
    

    [self transitionFromViewController:_mapSettingVC toViewController:_mapVC duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

-(void)switchToSettingController{
        [self transitionFromViewController:_mapVC toViewController:_mapSettingVC duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
            //NSLog(@"=======000000099999999999999999999999999999999switchToSettingController");
            

            
            
    
        } completion:^(BOOL finished) {
    
        }];
}

-(void)switchToMapController{
    
        [self transitionFromViewController:_mapVC toViewController:_mapSettingVC duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
            
        } completion:^(BOOL finished) {
    
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
