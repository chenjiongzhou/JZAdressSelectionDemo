//
//  JZAddressModel.m
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import "JZAddressModel.h"

@implementation JZAddressModel

- (instancetype)init {
    
    if (self = [super init]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"citydata" ofType:@"plist"];
        NSMutableArray *cityDataArr = [NSMutableArray arrayWithContentsOfFile:path];
        _cityDictionary = [self fiterCityData:cityDataArr];
        
        NSString *cityPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        _cityArray = [NSMutableArray arrayWithContentsOfFile:cityPath];
        
        
        NSString *overseasPath = [[NSBundle mainBundle] pathForResource:@"overseas" ofType:@"plist"];
        _overseaArray = [NSMutableArray arrayWithContentsOfFile:overseasPath];
        
        _overseasCityDictionary = [self fiterOverseasCityData:_overseaArray];
    }
    
    return self;
}

- (NSMutableDictionary *)fiterCityData:(NSArray *)cityDataArr {
    
    NSMutableDictionary *citiesDict = [NSMutableDictionary dictionary];
    for (NSDictionary *cityDict in cityDataArr) {
        
        NSArray *cityList = cityDict[@"citylist"];
        
        for (NSDictionary *dict in cityList) {
            
            NSMutableString *cityName = [NSMutableString stringWithString:dict[@"cityName"]];
            
            if (![cityName hasSuffix:@"市"]) {
                [cityName appendString:@"市"];
            }
            
            NSArray *areas = dict[@"arealist"];
            NSMutableArray *areaArray = [NSMutableArray array];
            
            for (NSDictionary *areaDict in areas) {
                
                [areaArray addObject:areaDict[@"areaName"]];
                
            }
            
            citiesDict[cityName] = areaArray;
            
        }
        
    }
    
    return citiesDict;
}

- (NSMutableDictionary *)fiterOverseasCityData:(NSArray *)cityDataArr {
    
    NSMutableDictionary *citiesDict = [NSMutableDictionary dictionary];
    for (NSDictionary *cityDict in cityDataArr) {
        
        NSArray *cityList = cityDict[@"cityLists"];
        NSString *areaName = cityDict[@"areaName"];
        citiesDict[areaName] = cityList;
        
    }
    
    return citiesDict;
}

- (NSMutableArray *)districtArray {

    NSString *currentCity = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"];
    NSMutableArray *districtArray = [NSMutableArray arrayWithObject:@"全城"];
    [districtArray addObjectsFromArray:[_cityDictionary objectForKey:[NSString stringWithFormat:@"%@市",currentCity]]];
    return districtArray;
    
}

- (NSMutableArray *)overseasCityArray {

    NSString *currentOverseasCity = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentOverseasCity"];
    NSMutableArray *districtArray = [NSMutableArray array];
    [districtArray addObjectsFromArray:[_overseasCityDictionary objectForKey:[NSString stringWithFormat:@"%@",currentOverseasCity]]];
    return districtArray;
    
}



@end
