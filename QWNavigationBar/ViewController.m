//
//  ViewController.m
//  QWNavigationBar
//
//  Created by 王权伟 on 2018/11/4.
//  Copyright © 2018 王权伟. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"我是天才";
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithTitle:@"666" style:(UIBarButtonItemStyleDone) target:self action:@selector(left:)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"888" style:(UIBarButtonItemStyleDone) target:self action:@selector(right:)];
    self.navigationItem.rightBarButtonItem = right;
    
    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    Class class = NSClassFromString(@"TwoViewController");
    UIViewController * vc = [[class alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
