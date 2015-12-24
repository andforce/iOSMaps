//
//  SearchView.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/5.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+BackgroundColor.h"
#import <AMapNaviKit/MAMapServices.h>
#import <AMapSearchKit/AMapSearchKit.h>

#define kViewHeight 50
#define kMargin 6

@interface SearchView : UIView


-(void) addDrawerOpenButtonClickListener:(OnClickListener) drawerClickListener;

-(void)enterSearch:(BOOL) isEnterSearch;

@property (nonatomic, strong) AMapSearchAPI *search;

@end
