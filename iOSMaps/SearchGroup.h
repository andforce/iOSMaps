//
//  SearchGroup.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/26.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchGroup : NSObject

-(NSUInteger) childCount;

@property (nonatomic, strong) NSMutableArray * childs;

@end
