//
//  JZCityItemCell.m
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import "JZCityItemCell.h"
#import "JZCityItemsView.h"
@interface JZCityItemCell ()

@property (nonatomic, strong) JZCityItemsView *cityItemsView;

@end

@implementation JZCityItemCell

+ (instancetype)cityItemCellWithCityArray:(NSArray *)cityArray tableView:(UITableView *)tableView {
    
    static NSString *reuseID = @"JZCityItemCell";
    JZCityItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[JZCityItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID cityArr:cityArray];
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cityArr:(NSArray *)cityArr {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor =  [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        for (int i =0 ; i<cityArr.count; i++) {
            
            UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat btnSpace = 15.f;
            NSInteger btnNumber = 3;
            CGFloat btnHeight = 35.f;
            
            CGFloat btnWidth = ([UIScreen mainScreen].bounds.size.width - 5*btnSpace)/btnNumber;
            
            cityBtn.frame = CGRectMake((i%btnNumber)*(btnWidth + btnSpace)+btnSpace, 4.5+(44.f)*(i/btnNumber), btnWidth, btnHeight);
            cityBtn.layer.cornerRadius = 5.f;
            cityBtn.layer.masksToBounds = YES;
            
            [cityBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [cityBtn setBackgroundColor:[UIColor whiteColor]];
            [cityBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
            [cityBtn setTitle:cityArr[i] forState:UIControlStateNormal];
            [cityBtn addTarget:self action:@selector(citySelct:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:cityBtn];
        }
//            [self addSubview:self.cityItemsView];
            
        
    }
    
    return self;
    
}

- (void)setCityItems:(NSArray *)cityItems {
    
    _cityItems = cityItems;
    
    self.cityItemsView.cityItems = cityItems;
    
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.cityItemsView.frame = CGRectMake(0.f, 0.f, self.contentView.eoc_width, [JZCityItemsView sizeWithCityItemsCount:_cityItems.count].height);
}


- (void)citySelct:(UIButton *)sender {
    
    if (self.selectedCityItemBlock) {
        self.selectedCityItemBlock(sender.titleLabel.text);
    }
    
}

+ (CGFloat)cellHeightWithCityDataDictionary:(NSDictionary *)cityDataDictionary isDisplay:(BOOL)isDisplay {

    if (!isDisplay) {
        
        return 0.0;
        
    }
    
    NSString *currentCity = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"];
    NSMutableArray *countyArray = [NSMutableArray arrayWithObject:@"全城"];
    [countyArray addObjectsFromArray:[cityDataDictionary objectForKey:[NSString stringWithFormat:@"%@市",currentCity]]];
    
    NSUInteger buttonLine = countyArray.count / 3;
    if (countyArray.count % 3 > 0) {
        buttonLine ++;
    }
    
//    return [JZCityItemsView sizeWithCityItemsCount:countyArray.count].height;
    
    return  buttonLine * 44.f;
}

+ (CGFloat)cellHeight {

    return 44.f;

}

- (JZCityItemsView *)cityItemsView {

    if (!_cityItemsView) {
        
        _cityItemsView = [[JZCityItemsView alloc] init];
        
    }
    
    return _cityItemsView;

}

@end
