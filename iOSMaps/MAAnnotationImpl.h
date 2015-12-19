//
//  MAAnnotation.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/19.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/MAAnnotation.h>

@interface MAAnnotationImpl : NSObject<MAAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, assign) NSString *title;
@property (nonatomic, assign) NSString *subtitle;

@end
