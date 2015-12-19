//
//  CameraDAO.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/18.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "CameraDAO.h"

@implementation CameraDAO


-(NSMutableArray *)praseCameras:(NSString *)jsonFilePath{
    
    NSError *error;
    
    NSData *jsonData = [[NSData alloc]initWithContentsOfFile:jsonFilePath];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];




    return [jsonObject objectForKey:@"Cameras"];
}





@end
