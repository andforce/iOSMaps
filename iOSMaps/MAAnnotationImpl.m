//
//  MAAnnotation.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/19.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "MAAnnotationImpl.h"

@implementation MAAnnotationImpl{

}

-(NSString *)title{
    return _title;
}

-(NSString *)subtitle{
    return _subtitle;
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    _coordinate = newCoordinate;
}

@end
