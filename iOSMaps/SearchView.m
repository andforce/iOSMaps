//
//  SearchView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/5.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "SearchView.h"

#define kViewHeight 50

@implementation SearchView

- (id)init:(UIView *)rootView{
    if (self == [super init]) {
        self.frame = CGRectMake(kViewHeight / 4.0f, kViewHeight / 2.0f, rootView.frame.size.width - kViewHeight / 2.0f, kViewHeight);
        self.backgroundColor = [UIColor whiteColor];
        
        //设置View圆角
        self.layer.cornerRadius = 2.0f;
        // 阴影的颜色
        self.layer.shadowColor = [[UIColor blackColor]CGColor];
        // 阴影的透明度
        self.layer.shadowOpacity = 0.3f;
        
        //设置View Shadow的偏移量
        self.layer.shadowOffset = CGSizeMake(0, 0.5f);
        
    }
    return self;
}

@end
