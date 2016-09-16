//
//  UIView+FAUIView.m
//  Kazoz
//
//  Created by Fadi on 24/2/16.
//  Copyright © 2016 apprikot. All rights reserved.
//

#import "UIView+FAUIView.h"
#import "NSBundle+FABundle.h"
#import <objc/runtime.h>

@implementation UIView (FAUIView)

-(float)heightWithConstraint {
    return [objc_getAssociatedObject(self, @selector(heightWithConstraint)) floatValue];
}

-(void)setHeightWithConstraint:(float)heightWithConstraint {
    objc_setAssociatedObject(self, @selector(heightWithConstraint), [NSNumber numberWithFloat:heightWithConstraint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setGone:(BOOL)Gone
{
    for (NSLayoutConstraint *item in [self constraints]) {
        if (item.firstAttribute == NSLayoutAttributeHeight &&
            item.relation == NSLayoutRelationEqual &&
            item.secondAttribute == NSLayoutAttributeNotAnAttribute &&
            [item.firstItem isEqual:self] &&
            item.shouldBeArchived) {
            //init height
            if (!self.heightWithConstraint)
                self.heightWithConstraint = item.constant;
//            NSLog(@"%f - %f",self.heightWithConstraint,item.constant);
            //set visible
            item.constant = Gone ? 0 : self.heightWithConstraint;
            [self setHidden:Gone];
            
            break;
        }
    }
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
    [self.superview layoutIfNeeded];
}

//support language layout

-(UISemanticContentAttribute)semanticContentAttribute {
    if ((UISemanticContentAttribute)objc_getAssociatedObject(self, @selector(semanticContentAttribute)) == UISemanticContentAttributeUnspecified &&
        [NSBundle languageChanged]) {
        UISemanticContentAttribute Dir = [NSBundle isDeviceLanguageRightToLeft] ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight;
        
        return Dir;

    }
    return (UISemanticContentAttribute)objc_getAssociatedObject(self, @selector(semanticContentAttribute));
}




@end
