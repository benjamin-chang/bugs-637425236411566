//
//  FirstViewController.m
//  fb-bug-sample
//
//  Created by Benjamin Chang on 6/3/16.
//  Copyright © 2016 Example. All rights reserved.
//

#import "FirstViewController.h"

#import "OverlayViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Our test button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Lauch Test Form" forState:UIControlStateNormal];
    [button sizeToFit];
    [button setCenter:self.view.center];
    [button addTarget:self action:@selector(launch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)launch {
    OverlayViewController *next = [[OverlayViewController alloc] initWithNibName:nil bundle:nil];
    [next show:YES];
}

@end
