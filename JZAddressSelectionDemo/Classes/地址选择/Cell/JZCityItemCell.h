//
//  JZCityItemCell.h
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JZCityItemCellSelectedCityItemBlock) (NSString *cityString);

@interface JZCityItemCell : UITableViewCell

@property (nonatomic, strong)JZCityItemCellSelectedCityItemBlock selectedCityItemBlock;

@property (nonatomic, strong) NSArray *cityItems;

+ (instancetype)cityItemCellWithCityArray:(NSArray *)cityArray tableView:(UITableView *)tableView;
+ (CGFloat)cellHeightWithCityDataDictionary:(NSDictionary *)cityDataDictionary isDisplay:(BOOL)isDisplay;
+ (CGFloat)cellHeight;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cityArr:(NSArray *)cityArr;
@end
