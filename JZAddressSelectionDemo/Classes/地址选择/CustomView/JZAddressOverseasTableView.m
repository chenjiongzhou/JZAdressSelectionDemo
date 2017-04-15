//
//  JZAddressOverseasTableView.m
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/13.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import "JZAddressOverseasTableView.h"
#import "JZCityItemCell.h"
#import "JZAddressTopHeaderView.h"
#import "JZAddressItemHeaderView.h"
#import "JZAddressModel.h"
#import "JZSearchShadowView.h"

@interface JZAddressOverseasTableView () <UITableViewDataSource, UITableViewDelegate, JZAddressTopHeaderViewDelegate,
UISearchBarDelegate, UISearchControllerDelegate>
{
    
    BOOL _countyDisplay;
    BOOL _isRightIndexHidden;
    JZSearchShadowView *_shadowView;
    
}

@property (nonatomic, strong) NSArray *overseasCityArr;
@property (nonatomic, strong) NSMutableDictionary *overseasCityDataDict;

//@property (nonatomic, strong) NSMutableDictionary *sectionDict;
@property (nonatomic, strong) NSMutableArray *indexesArray;
@property (nonatomic, strong) NSMutableArray *countyArray;

@property (nonatomic, strong) NSArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *sectionTitleArray;

@property (nonatomic, strong, readwrite) UISearchController *searchController;



@end

@implementation JZAddressOverseasTableView

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
    
    return self.sectionTitleArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section < self.sectionArray.count) {
        
        return 1;
        
    }
    
    NSMutableArray *arr = self.overseasCityDataDict[self.sectionTitleArray[section]];
//    return arr.count;
    return (arr.count % 3)==0 ? (arr.count / 3) : (arr.count / 3)+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *cities = [self returnArray:self.overseasCityDataDict[self.sectionTitleArray[indexPath.section]] indexPath:indexPath];
//        cities = self.overseasCityDataDict[self.indexesArray[indexPath.section]];
        
    JZCityItemCell *cell = [JZCityItemCell cityItemCellWithCityArray:cities tableView:tableView];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section < self.sectionArray.count) {
        
        return [JZCityItemCell cellHeight];
        
    }
    
    return [JZCityItemCell cellHeightWithCityDataDictionary:self.overseasCityDataDict isDisplay:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return [JZAddressItemHeaderView headerHeight];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *title = self.sectionTitleArray[section];
    JZAddressItemHeaderView *headerView = [JZAddressItemHeaderView addressItemHeaderViewWithTableView:tableView];
    headerView.title = title;
    
    return headerView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.indexesArray[indexPath.section];
    [[NSUserDefaults standardUserDefaults] setObject:title forKey:@"currentCity"];
    
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
    // 如果直接调用searchCancelAction，会直接回退到上一界面，暂时不知道原因
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

// 尝试了一个cell中返回一个地球的所有城市，出现了cell重用导致数据错乱的问题， 参考了余锦海的方案，重新构造数据源，每3个城市构成一个cell的数据源

- (NSArray *)returnArray:(NSArray *)arr indexPath:(NSIndexPath *)indexPath{
    
    NSInteger aCount = 3;
    
    NSInteger indexPathCount = (indexPath.row+1) * 3;
    
    NSInteger isOverCount = (indexPathCount - arr.count);
    
    if (isOverCount > 0) {
        
        aCount = 3 - isOverCount;
    }
    
    NSMutableArray *temparr = [NSMutableArray array];
    
    for (NSInteger i = 0; i<aCount; i++) {
        
        NSInteger index = indexPath.row * 3 + i;
        
        [temparr addObject:arr[index]];
        
    }
    return temparr;
}

#pragma mark - Getter && Setter

- (void)setOverseasCityArr:(NSArray *)overseasCityArr {
    
    _overseasCityArr = overseasCityArr;
}

- (void)setAddressModel:(JZAddressModel *)addressModel {
    
    _addressModel = addressModel;
    
    self.overseasCityArr = addressModel.overseaArray;
    
    self.overseasCityDataDict[self.sectionTitleArray[0]] = self.sectionArray[0];
    self.overseasCityDataDict[self.sectionTitleArray[1]] = self.sectionArray[1];
    
    for (NSDictionary *dict in self.overseasCityArr) {
        
        NSString *areaName = dict[@"areaName"];
        [self.sectionTitleArray addObject:areaName];
        
        self.overseasCityDataDict[areaName] = dict[@"cityLists"];
        
    }
    
}

- (NSMutableDictionary *)overseasCityDataDict {

    if (!_overseasCityDataDict) {
        
        _overseasCityDataDict = [NSMutableDictionary dictionary];
        
    }
    
    return _overseasCityDataDict;

}

- (NSArray *)sectionArray {
    
    if(!_sectionArray) {
        
        _sectionArray = @[@[@"北京"], @[@"北京", @"上海", @"广州"]];
        
    }
    return _sectionArray;
}

- (NSMutableArray *)sectionTitleArray {
    
    if (!_sectionTitleArray) {
        
        _sectionTitleArray = [NSMutableArray arrayWithObjects:@"定位城市", @"最近访问城市", nil];
        
    }
    
    return _sectionTitleArray;
    
}

- (NSMutableArray *)indexesArray {
    
    if (!_indexesArray) {
        
        _indexesArray = [NSMutableArray arrayWithObjects:@"!", @"#", nil];
        
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
        _searchController.searchBar.placeholder = @"城市/拼音/英文名";
        [_searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
        // 设置取消颜色
        _searchController.searchBar.tintColor = [UIColor colorWithHexString:@"#00bfaf"];
        
    }
    
    return _searchController;
    
}

@end
