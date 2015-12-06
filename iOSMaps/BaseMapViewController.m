//
//  BaseMapViewController.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/6.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "BaseMapViewController.h"

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
        [self initPoiSearch];
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
    
    [self.view addSubview:_mapView];
}

-(void) initLocationManager{
    // 定位
    [AMapLocationServices sharedServices].apiKey = kApiKey;
    _locationManager = [[AMapLocationManager alloc]init];
    _locationManager.delegate = self;
}

-(void) initPoiSearch{
    // 搜索
    [AMapSearchServices sharedServices].apiKey = kApiKey;
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
}

@end
