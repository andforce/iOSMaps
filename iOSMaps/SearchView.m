//
//  SearchView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/5.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "SearchView.h"
#import "LeftDrawerView.h"


#define kViewHeight 50
#define kMargin 6

@interface SearchView ()<UITextFieldDelegate>{
    UIView *_whiteBgView;
    
    LeftDrawerView *_leftDrawerView;
    
    UIView *_topBarRootView;
    
    UIButton *_searchButton;
    UIButton *_drawerSwitchButton;
    
    UITextField *_searchTextField;
}
@end

@implementation SearchView

- (id)init:(UIView *)rootView{
    if (self == [super init]) {
        
        [self initWhiteBgView:rootView];
        [self initSearchView:rootView];
        
        _leftDrawerView = [[LeftDrawerView alloc]init];
        [rootView addSubview:_leftDrawerView];

    }
    return self;
}


-(void) initWhiteBgView:(UIView *) rootView{
    _whiteBgView = [[UIView alloc]init];
    
    _whiteBgView.frame = CGRectMake(0, 0, rootView.frame.size.width, rootView.frame.size.height);
    _whiteBgView.backgroundColor = [UIColor whiteColor];
    _whiteBgView.alpha = 0.f;
    
    
    [rootView addSubview:_whiteBgView];
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
    
    //[_searchButton addTarget:self action:@selector(showOrHideWhiteBgViewWithAnim) forControlEvents:UIControlEventTouchUpInside];
    [_topBarRootView addSubview:_searchButton];
    
    
    _drawerSwitchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _drawerSwitchButton.frame = CGRectMake(kMargin / 2.0f, kMargin / 2.0f, _topBarRootView.frame.size.height - kMargin, _topBarRootView.frame.size.height - kMargin);
    UIImage *srawerImage = [UIImage imageNamed:@"ic_qu_menu_grabber"];
    [_drawerSwitchButton setImage:srawerImage forState:UIControlStateNormal];
    
    [_drawerSwitchButton addTarget:self action:@selector(openLeftDrawer) forControlEvents:UIControlEventTouchUpInside];
    [_topBarRootView addSubview:_drawerSwitchButton];
    
    
    _searchTextField = [[UITextField alloc]init];
    _searchTextField.frame = CGRectMake(_drawerSwitchButton.frame.origin.x + _drawerSwitchButton.frame.size.width + kMargin / 2.0f, kMargin / 2.0f, _searchButton.frame.origin.x - kMargin - _drawerSwitchButton.frame.size.width - kMargin / 2.0f, _topBarRootView.frame.size.height - kMargin);
    _searchTextField.placeholder = @"请输入关键字";

    [_searchTextField setDelegate:self];
    
    [_topBarRootView addSubview:_searchTextField];
    
    
    [rootView addSubview:_topBarRootView];
}

-(void)openLeftDrawer{
    [_leftDrawerView open];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self showOrHideWhiteBgViewWithAnim];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self showOrHideWhiteBgViewWithAnim];
    return YES;
}

-(void)showOrHideWhiteBgViewWithAnim{
    
    [UIView beginAnimations:nil context:nil];
    _whiteBgView.alpha = _whiteBgView.alpha > 0.f ? 0.f : 1.f;
    [UIView commitAnimations];
}

@end
