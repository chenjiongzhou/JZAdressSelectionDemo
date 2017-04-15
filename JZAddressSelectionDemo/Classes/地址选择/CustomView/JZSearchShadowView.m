//
//  JZSearchShadowView.m
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import "JZSearchShadowView.h"

@implementation JZSearchShadowView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (self.tapBlock) {
        self.tapBlock();
    }
    
}

@end
