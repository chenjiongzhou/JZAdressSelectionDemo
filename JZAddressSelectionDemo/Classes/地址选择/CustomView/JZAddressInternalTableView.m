//
//  JZAddressTableView.m
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import "JZAddressInternalTableView.h"
#import "JZCityItemCell.h"
#import "JZAddressTopHeaderView.h"
#import "JZAddressItemHeaderView.h"
#import "JZAddressModel.h"
#import "JZSearchShadowView.h"

@interface JZAddressInternalTableView () <UITableViewDataSource, UITableViewDelegate, JZAddressTopHeaderViewDelegate,
                                    UISearchBarDelegate, UISearchControllerDelegate>
{
    
    BOOL _countyDisplay;
    BOOL _isRightIndexHidden;
    JZSearchShadowView *_shadowView;
    
}

@property (nonatomic, strong) NSArray *cityArr;
@property (nonatomic, strong) NSDictionary *cityDataDict;

@property (nonatomic, strong) NSMutableDictionary *sectionDict;
@property (nonatomic, strong) NSMutableArray *indexesArray;
@property (nonatomic, strong) NSArray *hotCityArray;
@property (nonatomic, strong) NSMutableArray *countyArray;

@property (nonatomic, strong) NSArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *sectionTitleArray;

@property (nonatomic, strong, readwrite) UISearchController *searchController;

@end
@implementation JZAddressInternalTableView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.sectionIndexColor = [UIColor colorWithHexString:@"#00bfaf"];
        self.tableHeaderView = self.searchController.searchBar;
        // 广州
        [[NSUserDefaults standardUserDefaults] setObject:@"广州" forKey:@"currentCity"];
    }
    
    return self;
}


#pragma mark - TableViewDelegate && TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.indexesArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return _countyDisplay? 1 : 0;
        
    } else if (section < 4) {
        
        return 1;
        
    }
    
    NSMutableArray *citiesArr = self.sectionDict[self.indexesArray[section]];
    return citiesArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section < 4) {
       
        NSArray *cities;
        if (indexPath.section == 0) {
            
            cities = self.countyArray;
            
        } else {
            
            cities = self.sectionArray[indexPath.section];
            
        }
    
        JZCityItemCell *cell = [JZCityItemCell cityItemCellWithCityArray:cities tableView:tableView];
        return cell;
        
    }
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSMutableArray *citiesArr = self.sectionDict[self.indexesArray[indexPath.section]];
    cell.textLabel.text = citiesArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return [JZCityItemCell cellHeightWithCityDataDictionary:self.cityDataDict isDisplay:_countyDisplay];
        
    }
    
    return [JZCityItemCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return [JZAddressItemHeaderView headerHeight];;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        JZAddressTopHeaderView *topHeaderView = [JZAddressTopHeaderView addressTopHeaderViewWithTableView:tableView];
        topHeaderView.delegate = self;
        return topHeaderView;
        
    } else if (section < 4) {
        
        NSString *title = self.sectionTitleArray[section];
        JZAddressItemHeaderView *headerView = [JZAddressItemHeaderView addressItemHeaderViewWithTableView:tableView];
        headerView.title = title;
        return headerView;
    }
    
    NSString *title = self.indexesArray[section];
    JZAddressItemHeaderView *headerView = [JZAddressItemHeaderView addressItemHeaderViewWithTableView:tableView];
    headerView.title = title;
    
    return headerView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.indexesArray[indexPath.section];
    [[NSUserDefaults standardUserDefaults] setObject:title forKey:@"currentCity"];
    
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return _isRightIndexHidden? 0 : self.indexesArray;
    
}

#pragma mark - JZAddressTopHeaderViewDelegate

- (void)addressTopHeaderView:(JZAddressTopHeaderView *)headerView isSelectCity:(BOOL)isSelect {

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    _countyDisplay = isSelect;
    if (isSelect) {
        
        self.countyArray = self.addressModel.districtArray;
        
        [self beginUpdates];
        [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self endUpdates];
        
    } else {
        
        [self.countyArray removeAllObjects];
        
        [self beginUpdates];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self endUpdates];

    }

}

#pragma mark - UISearchControllerDelegate

- (void)didPresentSearchController:(UISearchController *)searchController {
    
    _isRightIndexHidden = YES;
    [self reloadSectionIndexTitles];
    
    CGFloat shadowY = CGRectGetMaxY(self.searchController.searchBar.frame) + 64;
    _shadowView = [[JZSearchShadowView alloc] initWithFrame:CGRectMake(0.f, shadowY, self.eoc_width, self.eoc_height - shadowY)];
    _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    __weak typeof(self) weakSelf = self;
    
    _shadowView.tapBlock = ^{
        
        [weakSelf searchCancelAction:searchController.searchBar];
        
    };
    
    [searchController.view.superview addSubview:_shadowView];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {

    _isRightIndexHidden = NO;
    [self reloadSectionIndexTitles];
    
    _searchController.active = YES;
    
    
    [_shadowView removeFromSuperview];
    
}

#pragma mark - Privite

- (void)searchCancelAction:(UISearchBar *)searchBar {

    _isRightIndexHidden = NO;
    [self reloadSectionIndexTitles];
    _searchController.active = NO;
    [_shadowView removeFromSuperview];
    
}

#pragma mark - Getter && Setter 

- (void)setCityArr:(NSArray *)cityArr {
    
    _cityArr = cityArr;
    [self sectionDict];
    
}

- (void)setAddressModel:(JZAddressModel *)addressModel {

    _addressModel = addressModel;
    
    self.cityArr = addressModel.cityArray;
    self.cityDataDict = addressModel.cityDictionary;
    
}

- (NSArray *)sectionArray {
    
    if(!_sectionArray) {
        
        _sectionArray = @[self.countyArray, @[@"北京"], @[@"北京", @"上海", @"广州"], @[@"北京", @"上海", @"广州"]];
        
    }
    return _sectionArray;
}

- (NSMutableArray *)sectionTitleArray {

    if (!_sectionTitleArray) {
        
        _sectionTitleArray = [NSMutableArray arrayWithObjects:@"", @"定位城市", @"最近访问城市", @"热门城市", nil];
        
    }
    
    return _sectionTitleArray;
    
}

- (NSMutableDictionary *)sectionDict {
    
    if (!_sectionDict) {
        
        _sectionDict = [NSMutableDictionary dictionary];
        
        for (NSDictionary *dict in _cityArr) {
            
            NSString *cityName = dict[@"name"];
            NSString *cityPinyin = dict[@"pinyin"];
            NSString *firstWord = [[cityPinyin substringToIndex:1] uppercaseString];
            
            if (![self.indexesArray containsObject:firstWord]) {
                
                [self.indexesArray addObject:firstWord];
                
                NSMutableArray *citiesArr = [NSMutableArray arrayWithObject:cityName];
                _sectionDict[firstWord] = citiesArr;
                
            } else {
                
                //存在着这个首字母，将城市添加到该首字母所拥有的城市数组里
                NSMutableArray *citiesArr = _sectionDict[firstWord];
                [citiesArr addObject:cityName];
                
            }
            
        }
        
    }
    
    [_indexesArray sortUsingSelector:@selector(compare:)];
    
    return _sectionDict;
    
}

- (NSMutableArray *)indexesArray {
    
    if (!_indexesArray) {
        
        _indexesArray = [NSMutableArray arrayWithObjects:@"!", @"#", @"$",@"*", nil];
        
    }
    return _indexesArray;
    
}

- (NSMutableArray *)countyArray {

    if (!_countyArray) {
        
        _countyArray = [NSMutableArray array];
    }
    
    return _countyArray;
    
}

- (UISearchController *)searchController {

    if (!_searchController) {
        
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.delegate = self;
        
        _searchController.searchBar.barTintColor = [UIColor whiteColor];
        // 隐藏蒙板
        _searchController.dimsBackgroundDuringPresentation = NO;
        // 隐藏导航条
        _searchController.hidesNavigationBarDuringPresentation = NO;
        // 删除掉SearchBar上下两根线条
        NSArray *subviews = self.searchController.searchBar.subviews.firstObject.subviews;
        
        for (id view in subviews) {
            
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                
                [view removeFromSuperview];
                
            }
        }
        
        UITextField *textField = [_searchController.searchBar valueForKey:@"_searchField"];
        textField.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        
        [_searchController.searchBar sizeToFit];
        _searchController.searchBar.delegate = self;
        _searchController.searchBar.placeholder = @"八点钟学院";
        [_searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
        // 设置取消颜色
        _searchController.searchBar.tintColor = [UIColor colorWithHexString:@"#00bfaf"];
        
    }
    
    return _searchController;
    
}


@end
