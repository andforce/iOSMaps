//
//  BaseMapViewController.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/6.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapNaviKit/MAMapView.h>
#import <AMapNaviKit/MAMapServices.h>


#define kApiKey @"f6a86f7a8d176d2ee0ae836d9e580158"


@interface BaseMapViewController : UIViewController<MAMapViewDelegate ,AMapLocationManagerDelegate>

@property (nonatomic, retain) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;


@end

