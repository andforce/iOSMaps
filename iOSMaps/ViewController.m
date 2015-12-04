//
//  ViewController.m
//  iOSMaps
//
//  Created by WDY on 15/12/4.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>

#import "SearchView.h"

#import "LocationView.h"
#import "LocationControllerViewController.h"


//#import "Mamap"

@interface ViewController ()<MAMapViewDelegate>{
    MAMapView *_mapView;
    LocationControllerViewController *locationController;
    
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];


    locationController = [[LocationControllerViewController alloc]init];
    [locationController startLocation];
    [self addChildViewController:locationController];
    
    
    //配置用户Key
    [MAMapServices sharedServices].apiKey = @"f6a86f7a8d176d2ee0ae836d9e580158";
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    

    [self.view addSubview:_mapView];
    
    
    
    SearchView *searchView = [SearchView searvchView];
    
    
    [self.view addSubview:searchView];
    
    LocationView *locationView = [LocationView locationView:self.view];
    
    [self.view addSubview:locationView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
