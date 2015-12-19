//
// Created by 迪远 王 on 15/12/19.
// Copyright (c) 2015 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "CameraBean.h"


@interface Cameras : JSONModel

@property (strong, nonatomic) NSArray<CameraBean *>* Cameras;

@end