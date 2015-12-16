//
//  SettingViewController.m
//  iOSMaps
//
//  Created by WDY on 15/12/16.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

@dynamic controllerSwitchDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect parentFrame = self.view.frame;
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, parentFrame.size.width, parentFrame.size.height);
    
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(switchToMapView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
}

-(void) switchToMapView{
    if (self.controllerSwitchDelegate != nil) {
        
        [self.controllerSwitchDelegate switchToMapController];
    }
}


@end
