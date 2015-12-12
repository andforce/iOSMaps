//
//  MapPresenter.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/11.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "MapPresenter.h"

@implementation MapPresenter

-(id)initWithGaoDeMap:( id<IMapView>)iMapView{
    
    if (self = [super init]) {
        [self setIMapView:iMapView];
    }
    
    return self;
}

-(void) changeUserTrackingMode:(NSInteger)mode{
    
    [_iMapView changeUserTrackingMode:mode];
}


-(void) changeMapStyle:(NSInteger)type{
    [_iMapView changeMapStyle:type];
}
@end
