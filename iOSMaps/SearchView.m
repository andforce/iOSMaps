//
//  SearchView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/5.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "SearchView.h"

#define kViewHeight 50

@interface SearchView (){
    UIView *_whiteBgView;
    UIButton *_myButton;
}
@end

@implementation SearchView

- (id)init:(UIView *)rootView{
    if (self == [super init]) {
        
        self.frame = CGRectMake(0, 0, rootView.frame.size.width, rootView.frame.size.height);
        
        [self initWhiteBgView:rootView];
        [self initSearchView:rootView];
        
        [_myButton addTarget:self action:@selector(showOrHideWhiteBgView) forControlEvents:UIControlEventTouchUpInside];
        
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
    _myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _myButton.frame = CGRectMake(kViewHeight / 4.0f, kViewHeight / 2.0f, rootView.frame.size.width - kViewHeight / 2.0f, kViewHeight);
    _myButton.backgroundColor = [UIColor whiteColor];
    
    //设置View圆角
    _myButton.layer.cornerRadius = 2.0f;
    // 阴影的颜色
    _myButton.layer.shadowColor = [[UIColor blackColor]CGColor];
    // 阴影的透明度
    _myButton.layer.shadowOpacity = 0.3f;
    
    //设置View Shadow的偏移量
    _myButton.layer.shadowOffset = CGSizeMake(0, 0.5f);
    
    [self addSubview:_myButton];
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
