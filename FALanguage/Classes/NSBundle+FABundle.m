//
//  NSBundle+FABundle.m
//  Gloocall
//
//  Created by Fadi on 30/5/16.
//  Copyright © 2016 Apprikot. All rights reserved.
//

#import "NSBundle+FABundle.h"
#import <objc/runtime.h>

static const char _bundle=0;

@interface Language : NSBundle

@end

@implementation Language

-(NSString*)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    NSBundle* bundle=objc_getAssociatedObject(self, &_bundle);
    if (!bundle)
        bundle = [NSBundle bundleWithPath:[[ NSBundle mainBundle ] pathForResource:@"Base" ofType:@"lproj" ]];
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}

@end

@implementation NSBundle (FABundle)
static bool languageChanged;

+(void)setLanguage:(NSString*)language
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
                  {
                      object_setClass([NSBundle mainBundle],[Language class]);
                  });
    
    objc_setAssociatedObject([NSBundle mainBundle], &_bundle, language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:language, nil] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setValue:language forKey:@"AppLanguage"];
    
    
    languageChanged = YES;
    
    
    [[UIView appearance] setSemanticContentAttribute:[self isDeviceLanguageRightToLeft] ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight];
    [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UINavigationController class]]] setSemanticContentAttribute:[self isDeviceLanguageRightToLeft] ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight];
    [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UITabBar class]]] setSemanticContentAttribute:[self isDeviceLanguageRightToLeft] ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight];

}

+(BOOL)languageChanged {
    return languageChanged;
}

+ (BOOL)isDeviceLanguageRightToLeft {
    NSString *Value = [[NSUserDefaults standardUserDefaults] stringForKey:@"AppLanguage"];
    NSLocaleLanguageDirection direction = [NSLocale characterDirectionForLanguage:Value];
    return (direction == NSLocaleLanguageDirectionRightToLeft);
}

@end
