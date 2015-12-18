//
//  SearchView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/5.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "SearchView.h"
#import "UIColor+MyColor.h"
#import "UIButton+BackgroundColor.h"
#import "SelectorUIButton.h"




@interface SearchView ()<UITextFieldDelegate>{
    UIView *_maskView;
    
    SelectorUIButton *_searchButton;
    SelectorUIButton *_drawerSwitchButton;
    
    UITextField *_searchTextField;
}
@end

@implementation SearchView

- (id)init {
    if (self = [super init]) {
        
        //UIView *rootView = [self superview];
        //self.frame = CGRectMake(kViewHeight / 4.0f, kViewHeight / 2.0f, rootView.frame.size.width - kViewHeight / 2.0f, kViewHeight);
        
        
        [self initSearchView];
        
    }
    return self;
}


-(void)didMoveToSuperview{
    UIView *rootView = [self superview];
    
    NSLog(@"didMoveToSuperviewdidMoveToSuperviewdidMoveToSuperviewdidMoveToSuperviewdidMoveToSuperview");
    
//    self.frame = CGRectMake(0, 0, rootView.frame.size.width, rootView.frame.size.height);
//    self.backgroundColor = [UIColor redColor];
    
    
    _searchButton.frame = CGRectMake(self.frame.size.width - self.frame.size.height + kMargin / 2.0f, kMargin / 2.0f, self.frame.size.height - kMargin, self.frame.size.height - kMargin);
    
    
    _drawerSwitchButton.frame = CGRectMake(kMargin / 2.0f, kMargin / 2.0f, self.frame.size.height - kMargin, self.frame.size.height - kMargin);
    
    _searchTextField.frame = CGRectMake(self.frame.origin.x + _drawerSwitchButton.frame.size.width + kMargin / 2.0f, kMargin / 2.0f, _searchButton.frame.origin.x - kMargin - _drawerSwitchButton.frame.size.width - kMargin / 2.0f, self.frame.size.height - kMargin);
    
    //[rootView addSubview:_topBarRootView];
    
    _maskView = [[UIView alloc]init];
    
    CGRect root = rootView.frame;
    _maskView.frame = CGRectMake(0, 0, root.size.width, root.size.height);
    _maskView.backgroundColor = [UIColor whiteColor];
    _maskView.alpha = 0.0;
    
    
    
    [rootView addSubview:_maskView];
    [rootView bringSubviewToFront:self];
    
}

-(void)enterSearch:(BOOL)isEnterSearch{
    if (isEnterSearch) {
        UIImage *exit = [UIImage imageNamed:@"ic_arrow_back_18pt"];
        [_drawerSwitchButton setImage:exit forState:UIControlStateNormal];
    } else{
        UIImage *enter = [UIImage imageNamed:@"ic_qu_menu_grabber"];
        [_drawerSwitchButton setImage:enter forState:UIControlStateNormal];
        
    }
}



-(void) initSearchView{
    

    //_topBarRootView = [[UIView alloc]init];
    
    self.backgroundColor = [UIColor whiteColor];
    
    //设置View圆角
    self.layer.cornerRadius = 2.0f;
    // 阴影的颜色
    self.layer.shadowColor = [[UIColor blackColor]CGColor];
    // 阴影的透明度
    self.layer.shadowOpacity = 0.3f;
    //设置View Shadow的偏移量
    self.layer.shadowOffset = CGSizeMake(0, 0.5f);
    
    
    _searchButton = [SelectorUIButton buttonWithType:UIButtonTypeCustom];

    UIImage *searchImage = [UIImage imageNamed:@"ic_qu_search"];
    [_searchButton setImage:searchImage forState:UIControlStateNormal];

    
    //[_searchButton addTarget:self action:@selector(showOrHideWhiteBgViewWithAnim) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_searchButton];
    
    
    _drawerSwitchButton = [SelectorUIButton buttonWithType:UIButtonTypeCustom];

    UIImage *srawerImage = [UIImage imageNamed:@"ic_qu_menu_grabber"];
    [_drawerSwitchButton setImage:srawerImage forState:UIControlStateNormal];
    
    
    //[_drawerSwitchButton addTarget:self action:@selector(openLeftDrawer) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_drawerSwitchButton];
    
    
    _searchTextField = [[UITextField alloc]init];

    _searchTextField.placeholder = @"请输入关键字";

    [_searchTextField setDelegate:self];
    
    [self addSubview:_searchTextField];
    
    
    
    

}

-(void)addDrawerOpenButtonClickListener:(OnClickListener)drawerClickListener{
    [_drawerSwitchButton addOnClickListener:drawerClickListener];
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
    CGFloat alpha = _maskView.alpha;
    [self enterSearch:alpha == 0.f];
    
    _maskView.alpha = alpha > 0.f ? 0.f : 1.f;

    [UIView commitAnimations];
}

@end
