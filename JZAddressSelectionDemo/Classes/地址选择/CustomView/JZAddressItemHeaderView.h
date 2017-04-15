//
//  JZAddressItemHeaderView.h
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZAddressItemHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *title;

+ (instancetype)addressItemHeaderViewWithTableView:(UITableView *)tableView;

+ (CGFloat)headerHeight;

@end
