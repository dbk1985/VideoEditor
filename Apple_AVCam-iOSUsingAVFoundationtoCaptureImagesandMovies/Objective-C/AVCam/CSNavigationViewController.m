//
//  CSNavigationViewController.m
//  AVCam
//
//  Created by wzkj on 2018/5/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "CSNavigationViewController.h"
#import "AVCamCameraViewController.h"

@interface CSNavigationViewController ()

@end

@implementation CSNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(BOOL)shouldAutorotate {
//    return [[self.viewControllers lastObject] shouldAutorotate];
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
//}

-(BOOL)shouldAutorotate {
    if ([[self.viewControllers lastObject]isKindOfClass:[AVCamCameraViewController class]]) {
        return YES;
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[self.viewControllers lastObject]isKindOfClass:[AVCamCameraViewController class]]) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskLandscape;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    if ([[self.viewControllers lastObject]isKindOfClass:[AVCamCameraViewController class]]) {
//        return UIInterfaceOrientationLandscapeLeft;
//    }
//    return UIInterfaceOrientationPortrait;
//}

@end
