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
#import <AMapSearchKit/AMapCommonObj.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "BaseMapViewController.h"
#import "POIAnnotation.h"




@interface SearchView ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, AMapSearchDelegate>{
    UIView *_maskView;
    
    SelectorUIButton *_searchButton;
    SelectorUIButton *_drawerSwitchButton;
    
    UITextField *_searchTextField;
    
    UITableView *_searchResultTableView;
}

@property (nonatomic, strong) NSMutableArray *searchTips;

@property (nonatomic, strong) NSMutableArray *busLines;

@end

@implementation SearchView

- (id)init {
    if (self = [super init]) {
        
        _alert = [AlertProgressViewController alertControllerWithTitle:@"正在搜索" message:@"\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
        
        self.searchTips = [NSMutableArray array];
        self.busLines = [NSMutableArray array];
        
        [self initPoiSearch];
        [self initSearchView];
        
    }
    return self;
}

-(void) initPoiSearch{
    // 搜索
    [AMapSearchServices sharedServices].apiKey = kApiKey;
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
}


- (void)searchTipsWithKey:(NSString *)key{
    if (key.length == 0){
        return;
    }
    
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = key;
    tips.city     = @"北京";
    
    [self.search AMapInputTipsSearch:tips];
}

/* 根据关键字来搜索POI. */
- (void)searchPoiByKeyword: (NSString* ) key{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = key;
    request.city                = @"010";
    request.requireExtension    = YES;
    [self.search AMapPOIKeywordsSearch:request];
}

-(void)didMoveToSuperview{
    UIView *rootView = [self superview];
    
    NSLog(@"didMoveToSuperviewdidMoveToSuperviewdidMoveToSuperviewdidMoveToSuperviewdidMoveToSuperview");
    
    _searchButton.frame = CGRectMake(self.frame.size.width - self.frame.size.height + kMargin / 2.0f, kMargin / 2.0f, self.frame.size.height - kMargin, self.frame.size.height - kMargin);
    
    
    _drawerSwitchButton.frame = CGRectMake(kMargin / 2.0f, kMargin / 2.0f, self.frame.size.height - kMargin, self.frame.size.height - kMargin);
    
    _searchTextField.frame = CGRectMake(self.frame.origin.x + _drawerSwitchButton.frame.size.width + kMargin / 2.0f, kMargin / 2.0f, _searchButton.frame.origin.x - kMargin - _drawerSwitchButton.frame.size.width - kMargin / 2.0f, self.frame.size.height - kMargin);
    
    _maskView = [[UIView alloc]init];
    
    CGRect root = rootView.frame;
    _maskView.frame = CGRectMake(0, 0, root.size.width, root.size.height);
    _maskView.backgroundColor = [UIColor whiteColor];
    _maskView.alpha = 0.0;
    
    _searchResultTableView = [[UITableView alloc]init];
    CGRect selfFrame = self.frame;
    _searchResultTableView.frame = CGRectMake(0, selfFrame.origin.y + selfFrame.size.height + 10, root.size.width, root.size.height);
    _searchResultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置TableView的dataSource
    _searchResultTableView.dataSource = self;
    _searchResultTableView.delegate = self;
    
    [_maskView addSubview:_searchResultTableView];
    
    [rootView addSubview:_maskView];
    [rootView bringSubviewToFront:self];
    
}





-(void) initSearchView{
    
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
    _searchTextField.returnKeyType = UIReturnKeySearch;

    _searchTextField.placeholder = @"请输入关键字";

    [_searchTextField setDelegate:self];
    [_searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self addSubview:_searchTextField];
    
    
}


- (void) textFieldDidChange:(UITextField *) textField{
    NSLog(@"textFieldDidChange 000000000000000000000000000000000000000000");
    [self searchTipsWithKey:textField.text];
}


#pragma mark - UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self searchTipsWithKey:textField.text];
    NSLog(@"textFieldDidEndEditing 000000000000000000000000000000000000000000");
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing 000000000000000000000000000000000000000000");
    [self enterSearch:YES];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturntextFieldShouldReturntextFieldShouldReturntextFieldShouldReturntextFieldShouldReturn");
    
    if (![textField.text isEqualToString:@""]) {

        [_delegate showAlertProgress];
        
        [self enterSearch:NO];
        [self searchPoiByKeyword:textField.text];
    }
    
    
    return YES;
}


#pragma mark - AMapSearchDelegate

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response{
    [self.searchTips setArray:response.tips];
    [_searchResultTableView reloadData];
    //[self.displayController.searchResultsTableView reloadData];
}

/* 公交搜索回调. */
- (void)onBusLineSearchDone:(AMapBusLineBaseSearchRequest *)request response:(AMapBusLineSearchResponse *)response{
    if (response.buslines.count != 0){
        [self.busLines setArray:response.buslines];
        
        //[self presentCurrentBusLine];
    }
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    
    [_delegate hideAlertProgress];
    
    if (response.pois.count == 0){
        return;
    }
    
    [self enterSearch:NO];
    
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        
    }];
    
    // 显示POI搜索结果
    [_delegate showPoiSearchResult:poiAnnotations];
    
}

#pragma mark - UITableViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self enterSearch:NO];

    
    AMapTip *tip = self.searchTips[indexPath.row];
    
    _searchTextField.text = tip.name;
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(clearAndShowAnnotationWithTip:)]) {
        [_delegate clearAndShowAnnotationWithTip:tip];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchTips.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tipCellIdentifier = @"tipCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tipCellIdentifier];
        cell.imageView.image = [UIImage imageNamed:@"locate"];
    }
    
    AMapTip *tip = self.searchTips[indexPath.row];
    
    if (tip.location == nil){
        cell.imageView.image = [UIImage imageNamed:@"search"];
    }
    
    cell.textLabel.text = tip.name;
    cell.detailTextLabel.text = tip.district;
    
    return cell;
}



-(void)enterSearch:(BOOL)isEnterSearch{
    if (isEnterSearch) {
        UIImage *exit = [UIImage imageNamed:@"ic_arrow_back_18pt"];
        [_drawerSwitchButton setImage:exit forState:UIControlStateNormal];
        [self showWhiteBgViewWithAnim];
    } else{
        UIImage *enter = [UIImage imageNamed:@"ic_qu_menu_grabber"];
        [_drawerSwitchButton setImage:enter forState:UIControlStateNormal];
        [self hideWhiteBgViewWithAnim];
    }
}


-(BOOL)isInSearchSate{
    return (_maskView.alpha == 1.f);
}

-(void)addDrawerOpenButtonClickListener:(OnClickListener)drawerClickListener{
    [_drawerSwitchButton addOnClickListener:drawerClickListener];
}

-(void)hideWhiteBgViewWithAnim{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    [UIView beginAnimations:nil context:nil];
    
    _maskView.alpha = 0.f;
    
    [UIView commitAnimations];
}

-(void)showWhiteBgViewWithAnim{
    [UIView beginAnimations:nil context:nil];
    
    _maskView.alpha = 1.f;

    [UIView commitAnimations];
}

@end
