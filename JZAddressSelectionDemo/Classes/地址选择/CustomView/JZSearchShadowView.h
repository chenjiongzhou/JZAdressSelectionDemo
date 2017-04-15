//
//  JZSearchShadowView.h
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JZSearchShadowViewTapBlock)(void);

@interface JZSearchShadowView : UIView

@property (nonatomic, copy) JZSearchShadowViewTapBlock tapBlock;

@end
