//
//  SearchGroup.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/26.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "SearchGroup.h"

@implementation SearchGroup

#pragma mark Init
- (instancetype)init
{
    self = [super init];
    if (self) {
        _childs = [NSMutableArray array];
    }
    return self;
}

-(NSUInteger)childCount{
    return _childs.count;
}

@end
