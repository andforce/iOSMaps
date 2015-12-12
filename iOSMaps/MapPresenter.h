//
//  MapPresenter.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/11.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMapView.h"

@interface MapPresenter : NSObject

@property(nonatomic, assign) id<IMapView> iMapView;

-(id)initWithGaoDeMap:(id<IMapView>)iMapView;
-(void) changeMapStyle:(NSInteger)type;
-(void) changeUserTrackingMode:(NSInteger) mode;

@end
