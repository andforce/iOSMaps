//
//  ViewController.m
//  iOSMaps
//
//  Created by WDY on 15/12/4.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "ViewController.h"


#import "SearchView.h"
#import "LocationView.h"

#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#define kApiKey @"f6a86f7a8d176d2ee0ae836d9e580158"


@interface ViewController ()<MAMapViewDelegate ,AMapLocationManagerDelegate, AMapSearchDelegate>{
    MAMapView *_mapView;
    AMapLocationManager *_locationManager;
    AMapSearchAPI *_search;

}

@end




@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];


    
    [self initMapView];
    
    [self initLocationServices];
    
    [self initPoiSearchServices];

    [self.view addSubview:_mapView];
    
    
    
    // 顶部的搜索空间
    SearchView *searchView = [SearchView searvchView];
    [self.view addSubview:searchView];
    
    
    // 右下角的定位按钮
    LocationView *locationView = [LocationView locationView:self.view];
    
    [self.view addSubview:locationView];
    
    
    
    // 定位
    [self startLocation];
    
    
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
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
    [_search AMapPOIAroundSearch: request];
}



-(void) initPoiSearchServices{
    // 搜索
    [AMapSearchServices sharedServices].apiKey = kApiKey;
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    
}

-(void) initMapView{
    // 3D地图
    [MAMapServices sharedServices].apiKey = kApiKey;
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
}

-(void) initLocationServices{
    // 定位
    [AMapLocationServices sharedServices].apiKey = kApiKey;
    _locationManager = [[AMapLocationManager alloc]init];
    _locationManager.delegate = self;
}


-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
        if(response.pois.count == 0)
        {
            return;
        }
    
        //通过 AMapPOISearchResponse 对象处理搜索结果
        NSString *strCount = [NSString stringWithFormat:@"count: %ld",response.count];
    
        NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
        NSString *strPoi = @"";
        for (AMapPOI *p in response.pois) {
            strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
        }
        NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
        NSLog(@"Place: %@", result);
}

-(void)startLocation{
    [_locationManager startUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    NSLog(@"================%f", location.altitude);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
