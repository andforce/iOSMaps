//
//  CameraDAO.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/18.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CameraBean;

@interface CameraDAO : NSObject

-(NSArray<CameraBean*> *)praseCameras:(NSString *)jsonFilePath;

@end
