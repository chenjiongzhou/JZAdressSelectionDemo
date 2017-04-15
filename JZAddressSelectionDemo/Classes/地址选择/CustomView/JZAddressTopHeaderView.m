//
//  JZAddressTopHeaderView.m
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import "JZAddressTopHeaderView.h"

@implementation JZAddressTopHeaderView

+ (instancetype)addressTopHeaderViewWithTableView:(UITableView *)tableView {
    
    static NSString *reuseID = @"JZAddressTopHeaderView";
    JZAddressTopHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseID];
    
    if (!header) {
        
        header = [[NSBundle mainBundle] loadNibNamed:@"JZAddressTopHeaderView" owner:nil options:nil][0];
        
    }
    
    return header;
    
}

- (IBAction)selectCity:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(addressTopHeaderView:isSelectCity:)]) {
        
        [_delegate addressTopHeaderView:self isSelectCity:btn.isSelected];
        
    }
    
}

@end
