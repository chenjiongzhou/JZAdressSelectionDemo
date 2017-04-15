//
//  JZAddressMainController.m
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import "JZAddressMainController.h"
#import "JZSegmentedControl.h"
#import "JZAddressInternalTableView.h"
#import "JZAddressModel.h"
#import "JZAddressOverseasTableView.h"


@interface JZAddressMainController ()

@property (nonatomic, weak) UIViewController *currentController;


@property (nonatomic, strong) JZAddressInternalTableView *internalTableView;
@property (nonatomic, strong) JZAddressOverseasTableView *overseasTableView;
@property (nonatomic, strong) JZAddressModel *addressModel;
@end

static const CGFloat kNaviationHeigt = 64.f;

@implementation JZAddressMainController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavigation];
    
    [self.view addSubview:self.internalTableView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - Privite Method

- (void)customNavigation {

    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0.f, 0.f, 20.f, 20.f);
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"closeBtn"] forState:UIControlStateNormal];
    UIBarButtonItem *closeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.navigationItem.leftBarButtonItem = closeButtonItem;
    
    JZSegmentedControl *segmentedControl = [[JZSegmentedControl alloc] initWithItems:@[@"国内", @"海外"]];
    [segmentedControl addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    
}

- (void)closeAction {
    
//    if (self.addressTableView.searchController.active) {
//        self.addressTableView.searchController.active = NO;
//    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)segmentChange:(UISegmentedControl *)segmentedControl {
    
    switch (segmentedControl.selectedSegmentIndex) {
            
        case 0:
            [self.overseasTableView removeFromSuperview];
            [self.view addSubview:self.internalTableView];
            break;
            
        case 1:
            [self.internalTableView removeFromSuperview];
            [self.view addSubview:self.overseasTableView];
            break;
        default:
            break;
            
    }
    
}

#pragma mark - Setter && Getter

- (JZAddressOverseasTableView *)overseasTableView {
    
    if(!_overseasTableView) {
        
        _overseasTableView = [[JZAddressOverseasTableView alloc] initWithFrame:CGRectMake(0.f, kNaviationHeigt, self.view.eoc_width, self.view.eoc_height - kNaviationHeigt) style:UITableViewStylePlain];
        _overseasTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _overseasTableView.addressModel = self.addressModel;
        [_overseasTableView reloadData];
        
    }
    
    return _overseasTableView;
    
}

- (JZAddressInternalTableView *)internalTableView {
    
    if(!_internalTableView) {
        
        _internalTableView = [[JZAddressInternalTableView alloc] initWithFrame:CGRectMake(0.f, kNaviationHeigt, self.view.eoc_width, self.view.eoc_height - kNaviationHeigt) style:UITableViewStylePlain];
        _internalTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        _internalTableView.addressModel = self.addressModel;
        [_internalTableView reloadData];
        
    }
    
    return _internalTableView;
    
}

- (JZAddressModel *)addressModel {
    
    if (!_addressModel) {
        
        _addressModel = [[JZAddressModel alloc] init];
        
    }
    
    return _addressModel;
    
}

@end
