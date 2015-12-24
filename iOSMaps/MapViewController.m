//
//  ViewController.m
//  iOSMaps
//
//  Created by WDY on 15/12/4.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "MapViewController.h"


#import "SearchView.h"
#import "CircleLocationView.h"
#import "MapDrawerView.h"
#import "DrawerViewDelegate.h"
#import "IMapView.h"
#import "CommonUtils.h"
#import "Constances.h"
#import "SearchView.h"

#import <AMapNaviKit/MAMapView.h>
#import <AMapNaviKit/MAAnnotation.h>
#import <AMapNaviKit/MAPointAnnotation.h>
#import <AMapNaviKit/MAAnnotationView.h>
#import <AMapNaviKit/MACircle.h>
#import <AMapNaviKit/MACircleView.h>
#import <AMapNavi/AMapNaviKit/MAAnnotation.h>
#import "CameraDAO.h"
#import "CameraBean.h"
#import "OfflineDetailViewController.h"


@interface MapViewController ()<DrawerViewDelegate, IMapView, MAMapViewDelegate>{
    CircleLocationView *_locationView;

    MapDrawerView *_drawerView;
    
}
@end

@implementation MapViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化Presenter
    _mapPresenter = [[MapPresenter alloc] initWithGaoDeMap:self];
    
    
    // 右下角的定位按钮
    _locationView = [[CircleLocationView alloc] init];
    [self.view addSubview:_locationView];
    [_locationView changeImageByUserTrackingMode:self.mapView.userTrackingMode];
    [_locationView addTarget:self action:@selector(onLocationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 顶部的搜索空间
    _searchView = [[SearchView alloc] init];
    _searchView.frame = CGRectMake(kViewHeight / 4.0f, kViewHeight / 2.0f, self.view.frame.size.width - kViewHeight / 2.0f, kViewHeight);


    __block OnClickListener blockSef = ^(id view){
        [_drawerView openLeftDrawer];
    };
    
    [_searchView addDrawerOpenButtonClickListener:blockSef];
    
    [self.view addSubview:_searchView];
    
    
    _drawerView = [[MapDrawerView alloc]initWithDrawerType:DrawerViewTypeLeft];
    _drawerView.delegate = self;
    [self.view addSubview:_drawerView];
    
    
    // Drawer Item 点击回调
    __block OnClickListener itemClickListener = ^(id view){
        NSLog(@"addOnItemClickListener   %ld", (long)((UIButton*)view).tag);
        
        switch (((UIButton*)view).tag) {
            case DrawerItemTypeSatellite:{
                BOOL selected = ((UIButton*)view).selected;

                [self.mapPresenter changeMapStyle: selected ? MAMapTypeStandard : MAMapTypeSatellite];
                
                break;
            }
            case DrawerItemTypeCamera:{
                break;
            }
            case DrawerItemTypeSetting:{
                if (_controllerSwitchDelegate != NULL) {
                    [_controllerSwitchDelegate switchToSettingController];
                }
                break;
            }
            case DrawerItemTypeAbout:{
                
                break;
            }
        }
        
        [_drawerView closeLeftDrawer];
    };

    [_drawerView addOnItemClickListener:itemClickListener];
    
    // 定位
    [self startLocation];
    
    
    ////////////////test block
    //[CommonUtils writeUserData:KMapStyleKey withValue:100];
    NSLog(@"CommonUtils ========> %ld", (long)[CommonUtils readUserData:KMapStyleKey]);
    ////////////////test block
    
    
    // 加载用户设置
    [_mapPresenter changeMapStyle:[CommonUtils readUserData:KMapStyleKey]];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];



//    MAAnnotationView *maAnnotationView = [[MAAnnotationView alloc] init];
//    MyMAAnnotation *ann = [[MyMAAnnotation alloc]init];
//    [ann setCoordinate:<#(CLLocationCoordinate2D)#>]
//
//    [self.mapView addAnnotation:maAnnotationView];


    //MAAnnotationView *maAnnotationView = [MAAnnotationView alloc]initWithAnnotation:nil reuseIdentifier:@"11111111"];

    CameraDAO *dao = [[CameraDAO alloc]init];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"presetCameraDB" ofType:@"json"];
    
    NSArray *cameras = [dao praseCameras:path];
    
//    CameraBean *cameraBean = cameras.firstObject;
//    
//    MAAnnotationImpl *pointAnnotation = [[MAAnnotationImpl alloc] init];
//    
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(cameraBean.latitude, cameraBean.longtitude);
//    
//    
//    pointAnnotation.title = cameraBean.name;
//    
//    pointAnnotation.subtitle = cameraBean.direction;
//    
//    
//    [self.mapView addAnnotation:pointAnnotation];
    
    for (CameraBean *cameraBean in cameras) {
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(cameraBean.latitude, cameraBean.longtitude);
        
        
        pointAnnotation.title = cameraBean.name;
        
        pointAnnotation.subtitle = cameraBean.direction;
        
        
        [self.mapView addAnnotation:pointAnnotation];
        
        
//        //构造圆
//        MACircle *circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(cameraBean.latitude, cameraBean.longtitude) radius:100];
//        //在地图上添加圆
//        [self.mapView addOverlay: circle];
        
    }

    self.mapView.showTraffic= YES;

}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]){
        if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
            static NSString *reuseIndetifier = @"annotationReuseIndetifier";
            MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
            if (annotationView == nil) {
                annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];
            }
            annotationView.image = [UIImage imageNamed:@"icon_camera_location"];
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -annotationView.image.size.height / 2);
            return annotationView;
        }
        return nil;
    }
    
    return nil;
}

//- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay{
//    if ([overlay isKindOfClass:[MACircle class]]){
//        MACircleView *circleView = [[MACircleView alloc] initWithCircle:overlay];
//        
//        circleView.lineWidth = 5.f;
//        circleView.strokeColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
//        circleView.fillColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:0.8];
//        circleView.lineDash = YES;
//        
//        return circleView;
//    }
//    return nil;
//}


-(void)switchMaps{
    CGRect tmp = _searchView.frame;
    
    if (tmp.origin.y == kViewHeight / 2.0f) {
        tmp.origin.y = -kViewHeight;
    } else{
        tmp.origin.y = kViewHeight / 2.0f;
    }
    _searchView.frame = tmp;
}

-(void) changeUserTrackingMode:(NSInteger)mode{

    [self.mapView setUserTrackingMode:mode animated:YES];
    
    [_locationView changeImageByUserTrackingMode:mode];
    
}

-(void) changeMapStyle:(NSInteger)type{
    self.mapView.mapType = type;
    
    UIButton *button = [[_drawerView findDrawerWithDrawerIndex:DrawerIndexLeft] viewWithTag:DrawerItemTypeSatellite];
    button.selected = type == MAMapTypeSatellite;
    
    NSLog(@"changeMapStyle =======>>>   %@     %ld", [[_drawerView findDrawerWithDrawerIndex:DrawerIndexLeft] subviews], (long)DrawerItemTypeSatellite);
    
}

-(void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
 
    NSLog(@"regionWillChangeAnimated %ld", (long)mapView.userTrackingMode);
    
    [_locationView changeImageByUserTrackingMode:mapView.userTrackingMode];
    
}

-(void) mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"regionDidChangeAnimated");
}


-(void) onLocationBtnClick{
    
    
    
    MAUserTrackingMode mode = self.mapView.userTrackingMode;
    if (mode == MAUserTrackingModeFollow) {
        
        [self.mapPresenter changeUserTrackingMode:MAUserTrackingModeFollowWithHeading];
        
    } else if(mode == MAUserTrackingModeFollowWithHeading){

        [self.mapPresenter changeUserTrackingMode:MAUserTrackingModeNone];
        
    } else if(mode == MAUserTrackingModeNone){
        
        [self.mapPresenter changeUserTrackingMode:MAUserTrackingModeFollow];

    }
    
    NSLog(@"onLocationBtnClick current mode: %ld", (long)mode);
}


-(void)startLocation{
    [[self locationManager] startUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    NSLog(@"================%f", location.altitude);

}


@end
