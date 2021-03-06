//
//  BaseMapViewController.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/6.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "BaseMapViewController.h"
#import <AMapNaviKit/MAMapView.h>

@interface BaseMapViewController ()

@end

@implementation BaseMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMapView];
}

-(id)init{
    if (self = [super init]) {
        [self initLocationManager];
    }
    
    return self;
}

-(void) initMapView{
    // 3D地图
    [MAMapServices sharedServices].apiKey = kApiKey;
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    
    //  启动默认现实手机当前位置
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    // 指南针
    _mapView.showsCompass = NO;
    // 比例尺
    _mapView.showsScale = NO;
    
    MAUserTrackingMode mode = _mapView.userTrackingMode;
    NSLog(@"MAUserTrackingMode : %ld", (long)mode);
    
    [self.view addSubview:_mapView];
}


-(void) initLocationManager{
    // 定位
    [AMapLocationServices sharedServices].apiKey = kApiKey;
    _locationManager = [[AMapLocationManager alloc]init];
    _locationManager.delegate = self;
}

@end
