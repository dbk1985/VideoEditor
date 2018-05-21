/*
See LICENSE.txt for this sample’s licensing information.

Abstract:
Application delegate.
*/

#import "AVCamAppDelegate.h"
#import "Global.h"

@implementation AVCamAppDelegate
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
{
    if ([Global share].isCam) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskLandscape;
}
@end
