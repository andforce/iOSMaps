//
//  IGaoDeMapView.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/11.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/AMapNaviKit.h>



@protocol IMapView <NSObject>

@required
-(void) changeMapStyle:(NSInteger)type;
-(void) changeUserTrackingMode:(NSInteger) mode;
-(MAMapView *) mapView;
@end
