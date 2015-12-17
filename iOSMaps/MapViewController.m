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

@interface MapViewController ()<DrawerViewDelegate, IMapView>{
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

-(void) searchWithWord: (NSString *)word andLocation:(AMapGeoPoint *)location type:(NSString *) types{
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = location;
    //request.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    request.keywords = word;
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    request.types = types;
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [self.search AMapPOIAroundSearch: request];
}

-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
        if(response.pois.count == 0)
        {
            return;
        }
    
        //通过 AMapPOISearchResponse 对象处理搜索结果
        NSString *strCount = [NSString stringWithFormat:@"count: %ld",(long)response.count];
    
        NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
        NSString *strPoi = @"";
        for (AMapPOI *p in response.pois) {
            strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
        }
        NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
        NSLog(@"Place: %@", result);
}

-(void)startLocation{
    [[self locationManager] startUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    NSLog(@"================%f", location.altitude);

}


@end
