//
//  JZAddressModel.h
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZAddressModel : NSObject

// 国内
@property (nonatomic, strong) NSMutableDictionary *cityDictionary;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *districtArray;

// 海外
@property (nonatomic, strong) NSMutableArray *overseaArray;
@property (nonatomic, strong) NSMutableDictionary *overseasCityDictionary;

@end
