//
//  JZSegmentedControl.m
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import "JZSegmentedControl.h"

@implementation JZSegmentedControl

- (instancetype)initWithItems:(NSArray *)items {
    
    if (self = [super initWithItems:items]) {
        
        self.frame = CGRectMake(0.f, 0.f, 160.f, 30.f);
        self.selectedSegmentIndex = 0;
        
        //点击的时候有高亮的颜色
        [self setTintColor:[UIColor colorWithHexString:@"#00bfaf"]];
        
    }
    
    return self;
}

@end
