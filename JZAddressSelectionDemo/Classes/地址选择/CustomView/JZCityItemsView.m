//
//  JZCityItemsView.m
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/13.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import "JZCityItemsView.h"

@implementation JZCityItemsView

- (void)setCityItems:(NSArray *)cityItems {

    _cityItems = cityItems;
    
    NSInteger count = cityItems.count;
    
    while (self.subviews.count < count) {
        
        UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cityBtn.layer.cornerRadius = 5.f;
        cityBtn.layer.masksToBounds = YES;
        [cityBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [cityBtn setBackgroundColor:[UIColor whiteColor]];
        [cityBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [cityBtn addTarget:self action:@selector(citySelct:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    for (int i = 0; i < self.subviews.count; i++) {
        
        UIButton *cityBtn = self.subviews[i];
        if (i < count) {
            
            cityBtn.hidden = NO;
            [cityBtn setTitle:cityItems[i] forState:UIControlStateNormal];
            
        } else {
        
            cityBtn.hidden = YES;
            
        }
        
    }
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat btnSpace = 15.f;
    NSInteger btnNumber = 3;
    CGFloat btnHeight = 35.f;
    CGFloat btnWidth = ([UIScreen mainScreen].bounds.size.width - 5*btnSpace)/btnNumber;

    
    for (int i = 0; i < _cityItems.count ; i++) {
        
        UIButton *cityBtn = self.subviews[i];
        NSUInteger col = i % btnNumber;
        cityBtn.eoc_x = col * (btnNumber + btnSpace);
        NSUInteger row = i / btnNumber;
        cityBtn.eoc_y = row * (btnHeight + btnSpace);
        cityBtn.eoc_width = btnWidth;
        cityBtn.eoc_height = btnHeight;
        
    }
}

- (void)citySelct:(UIButton *)btn {
    
//    NSInteger index = btn.tag ;
//    if (_delegate && [_delegate respondsToSelector:@selector(clickHotPostPhotosView:WithIndex: )]) {
//        [_delegate clickHotPostPhotosView:self.photos WithIndex:index];
//    }
}

+ (CGSize)sizeWithCityItemsCount:(NSInteger)count {

    NSInteger btnNumber = 3;
    NSUInteger maxCols = 3;
   
    CGFloat btnSpace = 15.f;
    CGFloat btnHeight = 35.f;
    CGFloat btnWidth = ([UIScreen mainScreen].bounds.size.width - 5*btnSpace)/btnNumber;
    CGFloat btnMargin = 4.5;
    
    NSUInteger cols = (count >= maxCols)? maxCols : count;
    CGFloat photoW = cols * btnWidth + (cols -1) * btnSpace;
    
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    
    CGFloat photoH = rows *btnHeight+ (rows - 1) * btnMargin;
    return CGSizeMake(photoW, photoH);

    
}



@end
