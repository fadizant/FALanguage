//
//  UIView+FAUIView.m
//  Kazoz
//
//  Created by Fadi on 24/2/16.
//  Copyright © 2016 apprikot. All rights reserved.
//

#import "UIView+FALanguageView.h"
#import "NSBundle+FABundle.h"
#import <objc/runtime.h>

@implementation UIView (FALanguageView)

//support language layout
-(UISemanticContentAttribute)semanticContentAttribute {
    if ((UISemanticContentAttribute)objc_getAssociatedObject(self, @selector(semanticContentAttribute)) == UISemanticContentAttributeUnspecified &&
        [NSBundle languageChanged]) {
        return [NSBundle isDeviceLanguageRightToLeft] ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight;
    }
    return (UISemanticContentAttribute)objc_getAssociatedObject(self, @selector(semanticContentAttribute));
}


@end
