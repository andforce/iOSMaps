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

@interface SearchView ()<UITextFieldDelegate>{
    UIView *_whiteBgView;
    
    UIView *_leftDrawerView;
    UIButton *_leftDrawerMaskView;
    
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
        [self initLeftDrawerView:rootView];
        
        self.frame = CGRectMake(0, 0, 5, rootView.frame.size.height);
        
        [rootView addSubview:self];
        
        UIScreenEdgePanGestureRecognizer *edgePab = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handlerEdgePan:)];
        edgePab.edges = UIRectEdgeLeft;
        
        [self addGestureRecognizer:edgePab];
        
        
    }
    return self;
}


-(void) handlerEdgePan:(UIScreenEdgePanGestureRecognizer *) recognizer{
    
    CGPoint translation = [recognizer translationInView:_leftDrawerView];
    
    CGFloat x = _leftDrawerView.center.x + translation.x;
    
    if (x > self.superview.frame.size.width / 3.0f) {
        return;
    }
    
    if (translation.x > 0) {
        _leftDrawerView.layer.shadowOpacity = 0.5f;
    }
    
    [UIView animateWithDuration:0.05 animations:^{
        CGPoint p = recognizer.view.center;
        p.x = x;
        _leftDrawerView.center = p;

        _leftDrawerMaskView.alpha = (_leftDrawerView.frame.origin.x + _leftDrawerView.frame.size.width) / _leftDrawerView.frame.size.width * 0.6f;
        
    }];
    
    
    [recognizer setTranslation:CGPointZero inView:_leftDrawerView];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:_leftDrawerView];
        
        NSLog(@"Touch ===   %f", velocity.x);
        
        if (velocity.x > 0) {
            [self showLeftDrawerWithAdim];
        } else{
            [self hideLeftDrawerWithAnim];
        }
    }

    
    NSLog(@"handlerEdgePan");
}


-(void) initWhiteBgView:(UIView *) rootView{
    _whiteBgView = [[UIView alloc]init];
    
    _whiteBgView.frame = CGRectMake(0, 0, rootView.frame.size.width, rootView.frame.size.height);
    _whiteBgView.backgroundColor = [UIColor whiteColor];
    _whiteBgView.alpha = 0.f;
    
    
    [rootView addSubview:_whiteBgView];
}

-(void) initLeftDrawerView:(UIView*) rootView{
    
    _leftDrawerMaskView = [[UIButton alloc]init];
    _leftDrawerMaskView.frame = CGRectMake(0, 0, rootView.frame.size.width, rootView.frame.size.height);
    _leftDrawerMaskView.backgroundColor = [UIColor blackColor];
    _leftDrawerMaskView.alpha = 0.0f;
    

    [_leftDrawerMaskView addTarget:self action:@selector(hideLeftDrawerWithAnim) forControlEvents:UIControlEventTouchUpInside];

    UIPanGestureRecognizer *maskPan = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handleMaskPan:)];
    [_leftDrawerMaskView addGestureRecognizer:maskPan];
    
    [rootView addSubview:_leftDrawerMaskView];
    
    
    _leftDrawerView = [[UIView alloc]init];
    
    CGFloat with = rootView.frame.size.width * 2 / 3;
    _leftDrawerView.frame = CGRectMake(- with, 0, with, rootView.frame.size.height);
    _leftDrawerView.backgroundColor = [UIColor whiteColor];
    
    _leftDrawerView.layer.shadowColor = [[UIColor blackColor]CGColor];
    // 阴影的透明度
    _leftDrawerView.layer.shadowOpacity = 0.f;
    //设置View Shadow的偏移量
    _leftDrawerView.layer.shadowOffset = CGSizeMake(5.f, 0);
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    [_leftDrawerView addGestureRecognizer:panGestureRecognizer];
    
    
    [rootView addSubview:_leftDrawerView];
}


- (void) handleMaskPan:(UIPanGestureRecognizer*) recognizer{
    
    
    CGPoint translation = [recognizer translationInView:_leftDrawerView];
    
    
    CGFloat x = _leftDrawerView.center.x + translation.x ;
    
    NSLog(@" trans x = %f,    center = %f       touch x = %f", x, _leftDrawerView.center.x, translation.x);
    if (x < _leftDrawerView.frame.size.width / 2.0f) {
        
        [UIView animateWithDuration:0.05 animations:^{
            CGPoint p = recognizer.view.center;
            p.x = x;
            _leftDrawerView.center = p;
            
            _leftDrawerMaskView.alpha = (_leftDrawerView.frame.origin.x + _leftDrawerView.frame.size.width) / _leftDrawerView.frame.size.width * 0.6f;
            
            NSLog(@" trans x =============================%f" , _leftDrawerView.frame.origin.x);
            
            
        }];
        
    }
    
    [recognizer setTranslation:CGPointZero inView:_leftDrawerView];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:_leftDrawerView];
        
        NSLog(@"Touch ===   %f", velocity.x);
        
        if (velocity.x > 0) {
            [self showLeftDrawerWithAdim];
        } else{
            [self hideLeftDrawerWithAnim];
        }
    }
    
}


- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:recognizer.view];
    CGFloat x = recognizer.view.center.x + translation.x;
    if (x > self.superview.frame.size.width / 3.0f) {
        return;
    }

    if (translation.x >0 ) {
        _leftDrawerView.layer.shadowOpacity = 0.5f;
    }
    
    [UIView animateWithDuration:0.05 animations:^{
        CGPoint p = recognizer.view.center;
        p.x = x;
        _leftDrawerView.center = p;
        _leftDrawerMaskView.alpha = (_leftDrawerView.frame.origin.x + _leftDrawerView.frame.size.width) / _leftDrawerView.frame.size.width * 0.6f;

    }];

    
    [recognizer setTranslation:CGPointZero inView:_leftDrawerView];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:_leftDrawerView];
        
        NSLog(@"Touch ===   %f", velocity.x);
        
        if (velocity.x > 0) {
            [self showLeftDrawerWithAdim];
        } else{
            [self hideLeftDrawerWithAnim];
        }
    }
    
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
    
    [_drawerSwitchButton addTarget:self action:@selector(showLeftDrawerWithAdim) forControlEvents:UIControlEventTouchUpInside];
    [_topBarRootView addSubview:_drawerSwitchButton];
    
    
    _searchTextField = [[UITextField alloc]init];
    _searchTextField.frame = CGRectMake(_drawerSwitchButton.frame.origin.x + _drawerSwitchButton.frame.size.width + kMargin / 2.0f, kMargin / 2.0f, _searchButton.frame.origin.x - kMargin - _drawerSwitchButton.frame.size.width - kMargin / 2.0f, _topBarRootView.frame.size.height - kMargin);
    _searchTextField.placeholder = @"请输入关键字";

    [_searchTextField setDelegate:self];
    
    [_topBarRootView addSubview:_searchTextField];
    
    
    [rootView addSubview:_topBarRootView];
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self showOrHideWhiteBgViewWithAnim];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self showOrHideWhiteBgViewWithAnim];
    return YES;
}

- (void) showLeftDrawerWithAdim{
    [UIView beginAnimations:nil context:nil];
    CGRect currentRect = _leftDrawerView.frame;
    currentRect.origin.x = 0;
    _leftDrawerView.frame = currentRect;
    
    _leftDrawerMaskView.alpha =  0.6f;
    
    _leftDrawerView.layer.shadowOpacity = 0.5f;
    
    [UIView commitAnimations];
}


-(void) hideLeftDrawerWithAnim{
    [UIView beginAnimations:nil context:nil];
        CGRect currentRect = _leftDrawerView.frame;
        currentRect.origin.x = -_leftDrawerView.frame.size.width;
        _leftDrawerView.frame = currentRect;
    
    _leftDrawerView.layer.shadowOpacity = 0.f;
    
    _leftDrawerMaskView.alpha =  0.0f;
    [UIView commitAnimations];
}



-(void)showOrHideWhiteBgViewWithAnim{
    
    [UIView beginAnimations:nil context:nil];
    _whiteBgView.alpha = _whiteBgView.alpha > 0.f ? 0.f : 1.f;
    [UIView commitAnimations];
}

@end
