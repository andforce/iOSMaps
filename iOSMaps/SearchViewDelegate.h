//
//  SearchViewDelegate.h
//  iOSMaps
//
//  Created by WDY on 15/12/25.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchViewDelegate<NSObject>

@required
- (void)clearAndShowAnnotationWithTip:(AMapTip *)tip;

@end
