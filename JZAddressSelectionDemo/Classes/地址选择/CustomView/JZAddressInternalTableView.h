//
//  JZAddressTableView.h
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JZAddressModel;
@interface JZAddressInternalTableView : UITableView

@property (nonatomic, strong) JZAddressModel *addressModel;
@property (nonatomic, strong, readonly) UISearchController *searchController;

@end
