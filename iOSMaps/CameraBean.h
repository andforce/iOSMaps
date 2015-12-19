//
//  CameraBean.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/18.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface CameraBean : JSONModel

@property (nonatomic, assign) int cameraId;
@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longtitude;
@property (nonatomic, assign) NSString *direction;

@end
