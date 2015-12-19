//
//  CameraDAO.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/18.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "CameraDAO.h"
#import "CameraBean.h"
#import "Cameras.h"

@implementation CameraDAO


-(NSArray<CameraBean*> *)praseCameras:(NSString *)jsonFilePath{
    
    NSError *error;
    
    NSData *jsonData = [[NSData alloc]initWithContentsOfFile:jsonFilePath];

    // 系统自带的json解析方法
    //id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    //[jsonObject objectForKey:@"Cameras"];
    Cameras *cameras = [[Cameras alloc] initWithData:jsonData error:&error];


    return cameras.cameras;
}





@end
