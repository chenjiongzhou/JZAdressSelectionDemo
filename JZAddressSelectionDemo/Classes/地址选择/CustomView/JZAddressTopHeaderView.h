//
//  JZAddressTopHeaderView.h
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JZAddressTopHeaderView;

@protocol JZAddressTopHeaderViewDelegate <NSObject>

- (void)addressTopHeaderView:(JZAddressTopHeaderView *)headerView isSelectCity:(BOOL)isSelect;

@end

@interface JZAddressTopHeaderView : UITableViewHeaderFooterView

@property(nonatomic, weak) id <JZAddressTopHeaderViewDelegate> delegate;

+ (instancetype)addressTopHeaderViewWithTableView:(UITableView *)tableView;

@end
