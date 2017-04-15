//
//  UIColor+CustomColor.h
//  美团地址选择框VIP
//
//  Created by 八点钟学院 on 2017/4/6.
//  Copyright © 2017年 八点钟学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CustomColor)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
