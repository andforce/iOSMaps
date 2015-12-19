//
//  CameraBean.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/18.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol CameraBean
@end

@interface CameraBean : JSONModel

@property (nonatomic, assign) int cameraId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longtitude;
@property (nonatomic, strong) NSString *direction;

@end
