//
//  SearchView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/5.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "SearchView.h"

#define kViewHeight 50
#define kMargin 6

@interface SearchView (){
    UIView *_whiteBgView;
    UIView *_topBarRootView;
    
    UIButton *_searchButton;
    UIButton *_drawerSwitchButton;
    
    UITextField *_searchTextField;
}
@end

@implementation SearchView

- (id)init:(UIView *)rootView{
    if (self == [super init]) {
        
        self.frame = CGRectMake(0, 0, rootView.frame.size.width, rootView.frame.size.height);
        
        [self initWhiteBgView:rootView];
        [self initSearchView:rootView];
        
        //[_topBarRootView addTarget:self action:@selector(showOrHideWhiteBgView) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void) initWhiteBgView:(UIView *) rootView{
    _whiteBgView = [[UIView alloc]init];
    
    _whiteBgView.frame = CGRectMake(0, rootView.frame.size.height, rootView.frame.size.width, rootView.frame.size.height);
    _whiteBgView.backgroundColor = [UIColor whiteColor];
    
    
    [self addSubview:_whiteBgView];
}

-(void) initSearchView:(UIView *) rootView{
    _topBarRootView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _topBarRootView.frame = CGRectMake(kViewHeight / 4.0f, kViewHeight / 2.0f, rootView.frame.size.width - kViewHeight / 2.0f, kViewHeight);
    _topBarRootView.backgroundColor = [UIColor whiteColor];
    
    //设置View圆角
    _topBarRootView.layer.cornerRadius = 2.0f;
    // 阴影的颜色
    _topBarRootView.layer.shadowColor = [[UIColor blackColor]CGColor];
    // 阴影的透明度
    _topBarRootView.layer.shadowOpacity = 0.3f;
    //设置View Shadow的偏移量
    _topBarRootView.layer.shadowOffset = CGSizeMake(0, 0.5f);
    
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchButton.frame = CGRectMake(_topBarRootView.frame.size.width - _topBarRootView.frame.size.height + kMargin / 2.0f, kMargin / 2.0f, _topBarRootView.frame.size.height - kMargin, _topBarRootView.frame.size.height - kMargin);
    UIImage *searchImage = [UIImage imageNamed:@"ic_qu_search"];
    [_searchButton setImage:searchImage forState:UIControlStateNormal];
    
    [_searchButton addTarget:self action:@selector(showOrHideWhiteBgView) forControlEvents:UIControlEventTouchUpInside];
    [_topBarRootView addSubview:_searchButton];
    
    
    _drawerSwitchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _drawerSwitchButton.frame = CGRectMake(kMargin / 2.0f, kMargin / 2.0f, _topBarRootView.frame.size.height - kMargin, _topBarRootView.frame.size.height - kMargin);
    UIImage *srawerImage = [UIImage imageNamed:@"ic_qu_menu_grabber"];
    [_drawerSwitchButton setImage:srawerImage forState:UIControlStateNormal];
    
    //[_drawerSwitchButton addTarget:self action:@selector(showOrHideWhiteBgView) forControlEvents:UIControlEventTouchUpInside];
    [_topBarRootView addSubview:_drawerSwitchButton];
    
    
    _searchTextField = [[UITextField alloc]init];
    _searchTextField.frame = CGRectMake(_drawerSwitchButton.frame.origin.x + _drawerSwitchButton.frame.size.width + kMargin / 2.0f, kMargin / 2.0f, _searchButton.frame.origin.x - kMargin - _drawerSwitchButton.frame.size.width - kMargin / 2.0f, _topBarRootView.frame.size.height - kMargin);
    _searchTextField.placeholder = @"请输入关键字";
    [_topBarRootView addSubview:_searchTextField];
    
    
    [self addSubview:_topBarRootView];
}

-(void)showOrHideWhiteBgView{
    [UIView beginAnimations:nil context:nil];
    CGRect currentRect = _whiteBgView.frame;
    if (currentRect.origin.y == self.frame.size.height) {
        currentRect.origin.y = 0;
    } else{
        currentRect.origin.y = self.frame.size.height;
    }
    _whiteBgView.frame = currentRect;
    
    [UIView commitAnimations];
}

@end
