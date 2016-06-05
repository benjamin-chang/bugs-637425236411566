//
//  OverlayViewController.m
//  fb-bug-sample
//
//  Created by Benjamin Chang on 6/3/16.
//  Copyright © 2016 Example. All rights reserved.
//

#import "OverlayViewController.h"

@import FBAudienceNetwork;

@interface OverlayViewController ()<FBAdViewDelegate>

@property (nonatomic, strong) UIWindow *overlayWindow; // Parent window

// native ad visual elements
@property (nonatomic, strong) UILabel *adTitleLabel;
@property (nonatomic, strong) UILabel *adCallToActionLabel;

@end


#pragma mark - UIViewController

@implementation OverlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    // FB native ad
    FBAdView *adView =
    [[FBAdView alloc] initWithPlacementID:@"237443386635569_239460769767164"
                                   adSize:kFBAdSize320x50
                       rootViewController:self];
    
    adView.delegate = self;
    [adView loadAd];
    [adView sizeToFit];
    [self.view addSubview:adView];
    
    // close button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Close" forState:UIControlStateNormal];
    [button sizeToFit];
    [button setCenter:self.view.center];
    [button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.overlayWindow.hidden = YES;
    self.overlayWindow = nil;
}


#pragma mark - OverlayViewController

- (UILabel *)adTitleLabel {
    if (!_adTitleLabel) {
        _adTitleLabel = [[UILabel alloc] init];
        [self.view addSubview:_adTitleLabel];
    }
    return _adTitleLabel;
}

- (UILabel *)adCallToActionLabel {
    if (!_adCallToActionLabel) {
        _adCallToActionLabel = [[UILabel alloc] init];
        [self.view addSubview:_adCallToActionLabel];
    }
    return _adCallToActionLabel;
}

// animating this cleanly 'cover' the status bar as the view transitions in
- (void)show:(BOOL)animated {
    self.overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayWindow.rootViewController = [[UIViewController alloc] init];
    
    // window level is set to status bar
    self.overlayWindow.windowLevel = UIWindowLevelStatusBar;
    
    [self.overlayWindow makeKeyAndVisible];
    [self.overlayWindow.rootViewController presentViewController:self animated:animated completion:nil];
}

- (void)close {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - FBNativeAdsManagerDelegate

- (void)nativeAdsLoaded {
    NSLog(@"Native ads loaded");
}

- (void)nativeAdsFailedToLoadWithError:(NSError *)error; {
    NSLog(@"Native ads failed to load with error: %@", error);
}


@end
