//
//  JZCityItemsView.h
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/13.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZCityItemsView : UIView

@property (nonatomic, strong) NSArray *cityItems;

+ (CGSize)sizeWithCityItemsCount:(NSInteger)count;

@end
