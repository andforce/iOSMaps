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

#import "SearchGroup.h"
#import "GrideGroup.h"
#import "ListGroup.h"

#import "GrideSearchTableViewCell.h"
#import "ListSearchTableViewCell.h"

#import "CommonUtils.h"



@interface SearchView ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, AMapSearchDelegate>{
    
    
    UIView *_maskView;
    
    SelectorUIButton *_searchButton;
    SelectorUIButton *_drawerSwitchButton;
    
    UITextField *_searchTextField;
    
    UITableView *_searchResultTableView;
    
    BOOL _isHasSearchText;
    
    //UIBezierPath *path;
}

@property (nonatomic, strong) NSMutableArray *searchTips;

@property (nonatomic, strong) NSMutableArray *busLines;

@property (nonatomic, strong) NSMutableArray *categorys;

@end

@implementation SearchView

#pragma mark Init
- (id)init {
    if (self = [super init]) {
        
        _alert = [AlertProgressViewController alertControllerWithTitle:@"正在搜索" message:@"\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
        //path = [UIBezierPath bezierPath];
        _isHasSearchText = NO;
        
        self.searchTips = [NSMutableArray array];
        self.busLines = [NSMutableArray array];
        self.categorys = [NSMutableArray array];
        
        [self initGroup];
        [self initPoiSearch];
        [self initSearchView];
        
    }
    return self;
}

-(void) initGroup{
    GrideGroup *gride = [[GrideGroup alloc]init];
    [gride addChild:@"LineOne"];
    
    [_categorys addObject:gride];
    
    ListGroup * list = [[ListGroup alloc]init];
    [list addChild:@"ic_local_parking_18pt" name:@"停车场"];
    [list addChild:@"ic_local_parking_18pt" name:@"停车场"];
    [list addChild:@"ic_local_parking_18pt" name:@"停车场"];
    [list addChild:@"ic_local_parking_18pt" name:@"停车场"];
    [list addChild:@"ic_local_parking_18pt" name:@"停车场"];
    [_categorys addObject:list];
    
    
}

-(void) initSearchView{
    
    
    
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
-(void) initPoiSearch{
    // 搜索
    [AMapSearchServices sharedServices].apiKey = kApiKey;
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
}


#pragma mark SeartchMethod
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


#pragma mark UIViewOverride
-(void)didMoveToSuperview{
    UIView *rootView = [self superview];
    
    NSLog(@"didMoveToSuperviewdidMoveToSuperviewdidMoveToSuperviewdidMoveToSuperviewdidMoveToSuperview");
    
    _searchButton.frame = CGRectMake(self.frame.size.width - self.frame.size.height + kMargin / 2.0f, kMargin / 2.0f, self.frame.size.height - kMargin, self.frame.size.height - kMargin);
    
    
    _drawerSwitchButton.frame = CGRectMake(kMargin / 2.0f, kMargin / 2.0f, self.frame.size.height - kMargin, self.frame.size.height - kMargin);
    
    _searchTextField.frame = CGRectMake(self.frame.origin.x + _drawerSwitchButton.frame.size.width + kMargin / 2.0f, kMargin / 2.0f, _searchButton.frame.origin.x - kMargin - _drawerSwitchButton.frame.size.width - kMargin / 2.0f, self.frame.size.height - kMargin);
    
    _maskView = [[UIView alloc]init];
    
    CGRect root = rootView.frame;
    _maskView.frame = CGRectMake(0, 0, root.size.width, root.size.height);
    _maskView.backgroundColor = [UIColor colorWithRed:238 / 255.f green:238/255.f blue:238/255.f alpha:1];//[UIColor whiteColor];
    _maskView.alpha = 0.0;
    
    CGRect selfFrame = self.frame;
    
    CGRect tableViewFrame = CGRectMake(self.frame.origin.x, selfFrame.origin.y + selfFrame.size.height , self.frame.size.width, root.size.height);
    
    _searchResultTableView = [[UITableView alloc]initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
    
    _searchResultTableView.delaysContentTouches = NO;
    
    _searchResultTableView.backgroundColor = _maskView.backgroundColor;
    _searchResultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置TableView的dataSource
    _searchResultTableView.dataSource = self;
    _searchResultTableView.delegate = self;
    
    [_maskView addSubview:_searchResultTableView];
    
    [rootView addSubview:_maskView];
    [rootView bringSubviewToFront:self];
    
    
  
    
    self.backgroundColor = [UIColor whiteColor];
    
    //设置View圆角
    self.layer.cornerRadius = 2.5f;
    // 阴影的颜色
    self.layer.shadowColor = [[UIColor blackColor]CGColor];
    // 阴影的透明度
    self.layer.shadowOpacity = 0.5f;
    //设置View Shadow的偏移量
    self.layer.shadowOffset = CGSizeMake(0, 0.3f);
    
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;

    
}


-(UIImage*)imageFromView:(UIView*)view{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, view.layer.contentsScale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

#pragma mark - UITextFieldDelegate

- (void) textFieldDidChange:(UITextField *) textField{
    NSLog(@"textFieldDidChange 000000000000000000000000000000000000000000");
    [self searchTipsWithKey:textField.text];
}

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

//section 顶部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
//section头部视图
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
//    view.backgroundColor = [UIColor redColor];
//    return view;
//}
//section底部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
//section
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
//    view.backgroundColor = [UIColor blueColor];
//    return view;
//}

/** 点击某一行 **/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self enterSearch:NO];

    
    AMapTip *tip = self.searchTips[indexPath.row];
    
    _searchTextField.text = tip.name;
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(clearAndShowAnnotationWithTip:)]) {
        [_delegate clearAndShowAnnotationWithTip:tip];
    }
    
}
/** 分组的数量 **/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_categorys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    SearchGroup * searchGroup = _categorys[section];
    return searchGroup.childCount;
    
    //return _searchTips.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     id group= _categorys[indexPath.section];
    
    if ([group isKindOfClass:[GrideGroup class]]) {
        //
        static NSString *tipCellIdentifier = @"GrideSearchTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GrideSearchTableViewCell" owner:self options:nil]lastObject];
        }
        return cell;
    } else if([group isKindOfClass:[ListGroup class]] ){
        
        static NSString *tipCellIdentifier = @"ListSearchTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ListSearchTableViewCell" owner:self options:nil]lastObject];
        }
        
        return cell;
    } else{
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
    
}


#pragma mark - SearchView
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
