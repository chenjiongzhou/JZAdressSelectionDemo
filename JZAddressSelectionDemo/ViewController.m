//
//  ViewController.m
//  JZAddressSelectionDemo
//
//  Created by jiong23 on 2017/4/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import "ViewController.h"
#import "JZAddressMainController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)jumpToAddressMainController:(id)sender {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[JZAddressMainController new]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [self presentViewController:nav animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
