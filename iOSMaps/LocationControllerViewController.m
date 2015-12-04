//
//  LocationControllerViewController.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/5.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "LocationControllerViewController.h"

#import <AMapLocationKit/AMapLocationKit.h>

@interface LocationControllerViewController ()<AMapLocationManagerDelegate>{

    AMapLocationManager *_locationManager;
}

@end

@implementation LocationControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"===============");
    
    _locationManager = [[AMapLocationManager alloc]init];
    _locationManager.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}

-(void)startLocation{
    [_locationManager startUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    NSLog(@"================%f", location.altitude);
}

@end
