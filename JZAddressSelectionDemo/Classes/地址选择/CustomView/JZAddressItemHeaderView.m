//
//  JZAddressItemHeaderView.m
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import "JZAddressItemHeaderView.h"

@interface JZAddressItemHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation JZAddressItemHeaderView

+ (instancetype)addressItemHeaderViewWithTableView:(UITableView *)tableView {
    
    static NSString *reuseID = @"JZAddressItemHeaderView";
    JZAddressItemHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseID];
    
    if (!header) {
        
        header = [[NSBundle mainBundle]loadNibNamed:@"JZAddressItemHeaderView" owner:nil options:nil][0];
        
    }
    
    return header;
    
}

- (void)setTitle:(NSString *)title {

    _title = title;
    _titleLabel.text = title;
    
}

+ (CGFloat)headerHeight {

    return 30.f;

}

@end
