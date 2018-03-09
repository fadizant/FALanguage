//
//  UINavigationController+FALanguageNavigationController.m
//  FALanguage
//
//  Created by Fadi Abuzant on 3/9/18.
//

#import "UINavigationController+FALanguageNavigationController.h"
#import "NSBundle+FABundle.h"
#import <objc/runtime.h>

@implementation UINavigationController (FALanguageNavigationController)

- (void)viewDidLoad
{
    [super viewDidLoad];
    // swipe to back from edge
    [self.view setSemanticContentAttribute:[NSBundle isDeviceLanguageRightToLeft] ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight];
}



@end
